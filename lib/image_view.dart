import 'dart:io';
import 'package:flutter/material.dart';

class imageView extends StatefulWidget{
  imageView({required this.imagePath});
  final String imagePath;
  @override
  _imageViewState createState()=>_imageViewState();
}

class _imageViewState extends State<imageView>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.file(
        File(widget.imagePath),
        fit: BoxFit.contain,
      ),
    );
  }
}