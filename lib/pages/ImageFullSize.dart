import 'package:flutter/material.dart';

class ImageFullSizePage extends StatefulWidget {
  var resource;
  ImageFullSizePage(this.resource, {Key key}) : super(key: key);

  @override
  _MyImageFullSizePageState createState() => _MyImageFullSizePageState();
}

class _MyImageFullSizePageState extends State<ImageFullSizePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: CircleAvatar(
            radius: 500.0,
            child: ClipRRect(
              child: Image.memory(widget.resource),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
