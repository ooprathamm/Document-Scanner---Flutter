import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'camera_screen.dart';


List<CameraDescription> cameras=[] ;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _animation(),
  ));
}

class _animation extends StatefulWidget {
  const _animation({Key? key}) : super(key: key);

  @override
  _animationState createState() => _animationState();
}

class _animationState extends State<_animation> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller= AnimationController(vsync: this,duration: Duration(seconds: 2));
    animation=Tween<double>(begin: 0,end: 300).animate(controller);
    animation.addListener(() {
      setState(() {
        //
      });
    });
    controller.forward();
    Timer(Duration(seconds: 5),
            ()=>Navigator.of(context).push(MaterialPageRoute(builder:
            (BuildContext context) => CameraApp()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: animation.value,
          width: animation.value,
          child: Image(image: AssetImage("assets/doc.png"),color: Colors.white,)
      ),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
