import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'main.dart';



class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Container(
      child: Stack(
        children: [
          CameraPreview(controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                child: RawMaterialButton(
                  fillColor: Colors.blue,
                  child: const Icon(Icons.camera,size: 35,),
                  padding: const EdgeInsets.all(15),
                  shape: CircleBorder(),
                  onPressed: ()async{
                    final image=await controller.takePicture();
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>displayImage(imagePath: image.path))
                    );
                  },
                )
            ),
          )
        ],
      ),
    );
  }
}

class displayImage extends StatelessWidget{
  final String imagePath;
  const displayImage({Key? key,required this.imagePath}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(File(imagePath))
      ],
    );
  }
}
