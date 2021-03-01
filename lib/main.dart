import 'package:flutter/material.dart';
import 'package:neostore/Pages/loginPage.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(MyApp());
}

// void main() => runApp(
//   DevicePreview(
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

