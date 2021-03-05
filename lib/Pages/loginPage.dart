import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore/Bloc/login_bloc.dart';
import 'package:neostore/Pages/forgetpass_page.dart';
import 'package:neostore/Pages/homePage.dart';
import 'package:neostore/Pages/registrationPage.dart';
import 'package:neostore/constants.dart';




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}




class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginKey = GlobalKey<FormState>();
  bool showPass0 = true;
  bool state = false;
  TextEditingController passUser = TextEditingController();
  TextEditingController userName = TextEditingController();

  final loginObj = LoginBloc();

  @override
  void dispose() {
    loginObj.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print("------Login widget tree------");
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
           height: double.infinity,
          child: SingleChildScrollView(
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
                         SizedBox(height: 49.0,),
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
                             errorStyle: TextStyle(color: Colors.white),
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
                             errorStyle: TextStyle(color: Colors.white),
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
                                   login();
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
                  padding: EdgeInsets.fromLTRB(13, 210, 13, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("DONT HAVE AN ACCOUNT?",style: TextStyle(color: Colors.white,fontSize:16.0,fontWeight: FontWeight.bold),),
                      //SizedBox(width: 60.0,),
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
                StreamBuilder<String>(
                    stream: loginObj.loginStream,
                    builder: (BuildContext context, snapshot ){
                      if(snapshot.data != null){
                        Fluttertoast.showToast(
                            msg: snapshot.data,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black);
                        if(loginObj.responseStatus == 200){
                          Future.delayed(Duration(seconds: 2), (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePageScreen()));
                          });
                        }
                      }
                      return Container();
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if(_loginKey.currentState.validate()) {
      final String user = userName.text; final String pass = passUser.text;
      loginObj.userValidate(user, pass);
      }
  }



}
