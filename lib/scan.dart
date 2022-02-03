import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_edge_detection/edge_detection.dart';
import 'camera_view.dart';
import 'image_view.dart';
import 'edge_detector.dart';

class Scan extends StatefulWidget{
  @override
  _scanState createState()=>_scanState();

}

class _scanState extends State<Scan> {

  CameraController controller;
  List<CameraDescription> cameras;
  String imagePath;
  EdgeDetectionResult edgeDetectionResult;

  @override
  void initState() {
    super.initState();
    checkForCameras().then((value) {
      _initializeController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            main_widget(),
          ],
        ),
      ),
    );
  }


  Future<void> checkForCameras() async {
    cameras = await availableCameras();
  }

  void _initializeController() {
    checkForCameras();
    controller = CameraController(
        cameras[0],
        ResolutionPreset.veryHigh,
        enableAudio: false
    );
  }

  Widget main_widget() {
    if (imagePath == null && edgeDetectionResult == null) {
      return CameraView(controller: controller);
    }
    return EdgeDetectionPreview(
      imagePath: imagePath,
      edgeDetectionResult: edgeDetectionResult,
    );
  }
  Future<String> takePicture() async {
    final Directory extDir = await getTemporaryDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/img1.jpg';
    await controller.takePicture(filePath);
    return filePath;
  }
  void onTakePictureButtonPressed() async {
    String filePath = await takePicture();
    log('Picture saved to $filePath');
    await _detectEdges(filePath);
  }

  Future _detectEdges(String filePath) async {
    if (filePath == null) {
      return;
    }
    setState(() {
      imagePath = filePath;
    });
    EdgeDetectionResult result = await EdgeDetector().detectEdges(filePath);
    setState(() {
      edgeDetectionResult = result;
    });
  }



}


