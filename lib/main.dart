import 'package:flutter/material.dart';

void main() => runApp(doc());

class doc extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DocApp(),
    );
  }
}

class DocApp extends StatefulWidget {
  const DocApp({Key? key}) : super(key: key);

  @override
  _DocAppState createState() => _DocAppState();
}

class _DocAppState extends State<DocApp> with SingleTickerProviderStateMixin{
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