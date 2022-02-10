import 'package:flutter/material.dart';
 void main() => runApp(MyScrollApp());

class MyScrollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Scrollbar(
              child: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                
                Container(
                  color: Colors.pink, // Yellow
                  height: 120.0,
                ),

                Image.network('https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg',
                   width: 300, height: 200, fit: BoxFit.contain),

                Image.network('https://flutter-examples.com/wp-content/uploads/2019/09/sample_img.png',
                   width: 200, fit: BoxFit.contain),
               
                Container(
                  color: Colors.blue, // Yellow
                  height: 120.0,
                ),

                Text('Some Sample Text - 1', style: TextStyle(fontSize: 28)),

                Container(
                  color: Colors.orange, // Yellow
                  height: 120.0,
                ),

                Image.network('https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg',
                   width: 300, height: 200, fit: BoxFit.contain),

                Text('Some Sample Text - 2', style: TextStyle(fontSize: 28)),

                Text('Some Sample Text - 3', style: TextStyle(fontSize: 28)),

              ],
            ),
             ),
            )
        )
      );
  }
}