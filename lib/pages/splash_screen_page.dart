import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neostore/Pages/homePage.dart';
import 'package:neostore/Pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  String finalEmail;

  @override
  void initState() {
    setState(() {
      getUserData().whenComplete(() async {
        Timer(Duration(seconds: 1), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> finalEmail == null ? LoginPage() : HomePageScreen())));
      });
    });
    super.initState();
  }

   getUserData() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    setState(() {
      var obtainedEmail = loginData.getString("login");
      finalEmail = obtainedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Container(
          child: Text("NeoSTORE",style: TextStyle(fontSize: 45.0,fontWeight: FontWeight.bold,color: Colors.white),),
        ),
      ),
    );
  }
}