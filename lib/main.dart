import 'package:flutter/material.dart';
import 'package:flutter_ams/pages/LoginPageScreen.dart';
import 'package:flutter_ams/size_config.dart';

var loginkey;

void main() {
  runApp(MyAMSApp());
}

class MyAMSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Approval Management System',
              home: LoginPageScreen(),
              //home: RaisedTicketPage(),
            );
          },
        );
      },
    );
  }
}
