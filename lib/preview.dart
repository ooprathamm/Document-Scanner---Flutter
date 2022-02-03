import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:simple_edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';

class EdgeDetectionPreview extends StatefulWidget{
  EdgeDetectionPreview({required this.imagePath,required this.edgeDetectionResult});
  final String imagePath;
  final EdgeDetectionResult edgeDetectionResult;
  @override
  edgeState createState()=>edgeState();
}

class edgeState extends State<EdgeDetectionPreview>{
  GlobalKey imageWidgetKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(widget.imagePath),
            fit: BoxFit.contain,
            key: imageWidgetKey,
          ),
          FutureBuilder<ui.Image>(
              future: loadUiImage(widget.imagePath),
              builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                return getEdgePaint(snapshot, context);
              }
          )
        ],
      ),
    );
  }
  Widget getEdgePaint(AsyncSnapshot<ui.Image> imageSnapshot,BuildContext context){
    if(imageSnapshot.connectionState==ConnectionState.waiting)
      return Container();
    if (imageSnapshot.hasError)
      return Text('Error: ${imageSnapshot.error}');
    if (widget.edgeDetectionResult == null)
      return Container();
    final keyContext = imageWidgetKey.currentContext;
    if (keyContext == null) {
      return Container();
    }
    final box =keyContext.findRenderObject() as RenderBox;

    return CustomPaint(
      size: Size(box.size.width,box.size.height),
      painter: EdgePainter(
          topLeft: widget.edgeDetectionResult.topLeft,
          topRight: widget.edgeDetectionResult.topRight,
          bottomLeft: widget.edgeDetectionResult.bottomLeft,
          bottomRight: widget.edgeDetectionResult.bottomRight,
          image: imageSnapshot.data,
          color: Theme.of(context).colorScheme.secondary
      )
    );
  }
  Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final Uint8List data=await File(imageAssetPath).readAsBytes();
    final Completer<ui.Image> completer=Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image image) {
      return completer.complete(image);
    });
    return completer.future;
  }
}