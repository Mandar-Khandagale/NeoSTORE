import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore/Bloc/reset_password_bloc.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final resetKey = GlobalKey<FormState>();
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  final resetObj = ResetPasswordBloc();
  String accessToken;
  bool isLoading = false;


  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      accessToken = perf.getString("accessToken");
    });
  }

@override
  void dispose() {
   currentPass.dispose();
   newPass.dispose();
   confirmPass.dispose();
   resetObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: myRed1,
        elevation: 0.0,
        title: Text('Reset Password',style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 33.0,right: 33.0),
              child: Form(
                key: resetKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:49.0,bottom:49.0,),
                      child: Text('NeoSTORE',style: TextStyle(color: Colors.white,fontSize: 45.0,fontWeight: FontWeight.bold),),
                    ),
                    TextFormField(
                      controller: currentPass,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.white,),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        errorBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        hintText: 'Current Password',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 18.0),
                        errorStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }else if(value.length <6){
                          return "Password should be greater than 6 characters";
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      controller: newPass,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.white,),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        errorBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        hintText: 'New Password',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 18.0),
                        errorStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        } else if (value.length < 6) {
                          return 'Password should be greater than 6 characters';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 13,),
                    TextFormField(
                      controller: confirmPass,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.white,),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        errorBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 18.0),
                        errorStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }else if (newPass.text != confirmPass.text) {
                          return 'Password does not match';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 13,),
                    isLoading == false ?
                    Container(
                      width: double.infinity,
                      height: 55.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          print("AccessToken:-$accessToken");
                          if(resetKey.currentState.validate()){
                            setState(() {
                              isLoading = true;
                            });
                          final String currentPassword = currentPass.text;
                          final String newPassword = newPass.text;
                           final String confirmPassword = confirmPass.text;
                          resetObj.resetPassword(currentPassword,newPassword,confirmPassword,accessToken);
                          }
                        },
                        color: Colors.white,
                        child: Text("RESET PASSWORD",style: TextStyle(fontSize: 23.0, color: Colors.red,fontWeight: FontWeight.w400)),
                      ),
                    ) : CircularProgressIndicator(),
                    StreamBuilder<String>(
                        stream: resetObj.resetPassStream,
                        builder: (BuildContext context, snapshot ){
                          if(snapshot.data != null){
                            Fluttertoast.showToast(
                                msg: snapshot.data,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white
                            );
                            if(resetObj.responseStatus == 200){
                              isLoading = false;
                              Future.delayed(Duration(seconds: 1), (){
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage()));
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
        ),
      ),
    );
  }
}
