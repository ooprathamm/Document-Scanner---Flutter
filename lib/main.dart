import 'dart:ffi';

import 'package:flutter/material.dart';
void main()=>runApp(app());

class app extends StatelessWidget{
  app({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Document Scanner' ,
      theme: ThemeData(
        primarySwatch: Colors.grey
      ),
      home: _Homepage(),
    );
  }
}

class _Homepage extends StatefulWidget{
  @override
  homestate createState()=>homestate();
}

class homestate extends State<_Homepage>{
  Animation<double> animation;
  AnimationController controller;
  
  @override
  void initState() {
    controller=AnimationController(vsync: this,duration: Duration(milliseconds: 2500));
    animation=Tween<Double>(begin: 0.0,end: 1.0).animate(controller);
    animation.addListener(() {
         setState(() {
           print(animation.value.toString());

         });
    });
    animation.addStatusListener((status) {
       if(status==AnimationStatus.completed){
         controller.reverse();
       }
       else if(status==AnimationStatus.dismissed){
         controller.forward();
       }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("TEST"),
      ),
    );
  }
}

