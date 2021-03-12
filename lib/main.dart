import 'package:flutter/material.dart';
import 'package:neostore/pages/account_details.dart';
import 'package:neostore/pages/forgetpass_page.dart';
import 'package:neostore/pages/homePage.dart';
import 'package:neostore/pages/reset_password_page.dart';
import 'package:neostore/pages/splash_screen_page.dart';
import 'package:neostore/pages/update_account_details.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}



