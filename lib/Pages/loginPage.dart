import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neostore/Pages/forgetpass_page.dart';
import 'package:neostore/Pages/homePage.dart';
import 'package:neostore/Pages/registrationPage.dart';
import '../user_model.dart';
import 'package:http/http.dart' as http;
Color myRed1 = Color(0xffe91c1a);


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}




class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginKey = GlobalKey<FormState>();
  bool showPass0 = true;
  TextEditingController passUser = TextEditingController();
  TextEditingController userName = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.red,
      body: Stack(
        children:[
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:33.0,right: 33.0),
                  child: Container(
                    child: Form(
                         key: _loginKey,
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                         child: Column(
                           children: [
                         Padding(
                           padding: const EdgeInsets.fromLTRB(25, 150, 25, 0),
                           child: Text("NeoSTORE",style: TextStyle(fontSize:45.0,color: Colors.white,fontWeight: FontWeight.bold ),),
                         ),
                         SizedBox(height: 49,),
                         TextFormField(
                           controller: userName,
                           style: TextStyle(color: Colors.white),
                           keyboardType: TextInputType.emailAddress,
                           cursorColor: Colors.white,
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.person, color: Colors.white,),
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white),),
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             errorBorder:OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             focusedErrorBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             hintText: 'Username',
                             hintStyle: TextStyle(color: Colors.white,fontSize: 18.0),
                             errorStyle: TextStyle(color: Colors.green),
                           ),
                           validator: (value) {
                             if (value.isEmpty) {
                               return 'Required';
                             } else if (!RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                               return 'Invalid Username';
                             } else {
                               return null;
                             }
                           },
                         ),
                         SizedBox(height: 20.0,),
                         TextFormField(
                           controller: passUser,
                           style: TextStyle(color: Colors.white),
                           obscureText: showPass0,
                           cursorColor: Colors.white,
                           keyboardType: TextInputType.visiblePassword,
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.lock, color: Colors.white,),
                             suffixIcon: IconButton(
                               color: Colors.white,
                               icon: Icon(showPass0 ? Icons.visibility : Icons.visibility_off),
                               onPressed: (){
                                 setState(() {
                                   showPass0 = !showPass0;
                                 });
                               },
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white),),
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             errorBorder:OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             focusedErrorBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             hintText: 'Password',
                             hintStyle: TextStyle(color: Colors.white,fontSize: 18.0),
                             errorStyle: TextStyle(color: Colors.green),
                           ),
                           validator: (value) {
                             if (value.isEmpty) {
                               return 'Please Enter Password';
                             } else {
                               return null;
                             }
                           },
                         ),
                         SizedBox(height: 26.0,),
                         SizedBox(
                           width: 293.33,
                           height: 47.33,
                           child: FlatButton(
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0),
                                   side: BorderSide(color: Colors.white)),
                               onPressed: () {
                                 setState(() {
                                   login();
                                 });
                               },
                               color: Colors.white,
                               child: Text('LOGIN',
                                 style: TextStyle(fontSize: 26.0, color: Colors.red),)
                           ),
                         ),
                         SizedBox(height: 21.0,),
                         RichText(
                           text: TextSpan(
                             text: "Forget Password?",
                             style: TextStyle(fontSize: 18.0, color: Colors.white),
                             recognizer: TapGestureRecognizer()
                               ..onTap = (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgetPass()));
                               }
                           ),
                         ),
                           ],
                         ),
                       ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 210, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("DONT HAVE AN ACCOUNT?",style: TextStyle(color: Colors.white,fontSize:16.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 60.0,),
                      Container(
                        color: myRed1,
                        height: 46.0,width: 46.0,
                        child: Center(child: IconButton(icon: Icon(Icons.add,size: 30.0,color: Colors.white,),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegistrationPage()));
                        },
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    ]
      ),
    );
  }

  login() async {
    final String user = userName.text; final String pass = passUser.text;
    if(_loginKey.currentState.validate()) {
      Future userValidate(String user, String pass) async {
        final String apiUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/login";
        final response = await http.post(apiUrl,
            body: {
              "email": user,
              "password": pass
            });
        final error = ErrorModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          print('Login Successful ${response.statusCode}');
          print(user);
          final success = SuccessModel.fromJson(jsonDecode(response.body));
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(success.userMsg),
            duration: Duration(seconds: 5),
            action: SnackBarAction(label: 'Ok', onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePageScreen()));
            })
          ));
        } else if (response.statusCode == 401){
          print("error ${error.userMsg}");
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(error.userMsg),
            duration: Duration(seconds:5),
          ));
          print(user);
          print('Login ${response.statusCode}');
        }else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(error.userMsg),
            duration: Duration(seconds: 5),
          ));
        }
      }
      userValidate(user, pass);
      }
  }



}
