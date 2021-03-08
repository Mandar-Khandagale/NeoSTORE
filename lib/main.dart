import 'package:flutter/material.dart';
import 'package:neostore/Pages/account_details.dart';
import 'package:neostore/Pages/homePage.dart';
import 'package:neostore/Pages/loginPage.dart';
import 'package:neostore/Pages/table_list.dart';


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

