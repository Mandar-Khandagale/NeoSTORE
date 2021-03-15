import 'package:flutter/material.dart';
import 'package:neostore/pages/product_details_page.dart';
import 'package:neostore/pages/splash_screen_page.dart';
import 'package:neostore/pages/table_list.dart';


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



