import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neostore/Pages/loginPage.dart';
import 'package:neostore/Pages/registrationPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

