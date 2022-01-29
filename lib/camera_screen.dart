import 'package:flutter/material.dart';
import 'package:document_scanner_flutter/main.dart';
import 'package:camera/camera.dart';
import 'main.dart';

class camera extends StatefulWidget{
  @override
  cameraState createState()=>cameraState();
}

class cameraState extends State<camera> with WidgetsBindingObserver{
  CameraController? controller;
  bool _isCameraInitalized=false;
  void onNewCameraSelected(CameraDescription cameraDescription) async{
    final previousCameraController=controller;

    final CameraController cameraController=CameraController(cameraDescription,
        ResolutionPreset.high,
    imageFormatGroup: ImageFormatGroup.jpeg
    );

    await previousCameraController?.dispose();

    if(mounted){
      setState(() {
        controller=cameraController;
      });
    }
    cameraController.addListener(() {
      if(mounted){
        setState(() {

        });
      }
    });

    await cameraController.initialize();

    if(mounted){
      setState(() {
        _isCameraInitalized=controller!.value.isInitialized;
      });
    }
  }
  
  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitalized?AspectRatio(
          aspectRatio: 1/controller!.value.aspectRatio,
      child: controller!.buildPreview()):Container()
    );
  }
}