import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore/Bloc/registration_bloc.dart';

import '../constants.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}



class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String gender;
  bool status= false;
  bool isValidateForm1 = false;
  bool showPass1 = true;
  bool showPass2 = true;
  bool isLoading = false;

  final registerObj = RegisterBloc();


  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conPass = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void dispose() {
      registerObj.dispose();
      fName.dispose();
      lName.dispose();
      email.dispose();
      pass.dispose();
      conPass.dispose();
      phone.dispose();
    super.dispose();
  }

  progressIndicator(){
    ///Stream Listener
    registerObj.registerStream.listen((value) {
      if(value.isNotEmpty){
        Fluttertoast.showToast(
            msg: value,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
      if(registerObj.responseStatus == 200){
        isLoading = false;
        Future.delayed(Duration(seconds: 1), (){
          Navigator.pop(context);
        });
      }else{
        setState(() {
          isLoading = false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    print("------Register widget tree-------");
    return Scaffold(
      key: scaffoldKey,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
         automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
          Navigator.pop(context);
        },),
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text('Register',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0),),
        centerTitle: true,
      ),
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 33.0,right: 33.0,bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('NeoSTORE', style: TextStyle(fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
              ),
              _form(),
              isLoading == false ?
              SizedBox(
                width: 293.0,
                height: 47.0,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () {
                        addData();
                    },
                    color: Colors.white,
                    child: Text('REGISTER',
                      style: TextStyle(fontSize: 26.0, color: Colors.red),)),
              ) : CircularProgressIndicator(),
              // StreamBuilder<String>(
              //     stream: registerObj.registerStream,
              //     builder: (BuildContext context, snapshot ){
              //       if(snapshot.data != null){
              //         Fluttertoast.showToast(
              //             msg: snapshot.data,
              //             toastLength: Toast.LENGTH_SHORT,
              //             gravity: ToastGravity.BOTTOM,
              //             backgroundColor: Colors.white,
              //             textColor: Colors.black);
              //         if(registerObj.responseStatus == 200){
              //           Future.delayed(Duration(seconds: 1), (){
              //             Navigator.pop(context);
              //           });
              //         }
              //       }
              //       return Container();
              //     }
              // ),
            ],
          ),
        ),
      ),
    );
  }


  void addData() async {
    isValidateForm1 = true;
    final String fname = fName.text;
    final String lname = lName.text;
    final String mail = email.text;
    final String pas = pass.text;
    final String conpass = conPass.text;
    final String gen = gender;
    final String num = phone.text;
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      if (gender != null && status == true ) {
        registerObj.createUser(fname, lname, mail, pas, conpass, gen, num);
      }
      progressIndicator();
    }
  }

    Widget _form() {
      return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: fName,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.name,
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
                hintText: 'First Name',
                hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                errorStyle: TextStyle(color: Colors.white),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                  return 'Only Characters';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 13,),
            TextFormField(
              controller: lName,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.text,
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
                hintText: 'Last Name',
                hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                errorStyle: TextStyle(color: Colors.white),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                  return 'Only Characters';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 13,),
            TextFormField(
              controller: email,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.white,),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,),),
                errorBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,),),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,),),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                errorStyle: TextStyle(color: Colors.white),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Invalid Email';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 13,),
            TextFormField(
              controller: pass,
              style: TextStyle(color: Colors.white),
              obscureText: showPass1,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.white,),
                suffixIcon: IconButton(
                  color: Colors.white,
                  icon: Icon(showPass1 ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      if(showPass1 == true){ showPass1 = false;} else{ showPass1 = true;}
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
                hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                errorStyle: TextStyle(color: Colors.white),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Password';
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
              controller: conPass,
              style: TextStyle(color: Colors.white),
              obscureText: showPass2,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.white,),
                suffixIcon: IconButton(
                  color: Colors.white,
                  icon: Icon(showPass2 ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      if(showPass2 == true){ showPass2 = false;} else{ showPass2 = true;}
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
                hintText: 'Confirm Password',
                hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                errorStyle: TextStyle(color: Colors.white),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please re-enter Password';
                }
                else if (pass.text != conPass.text) {
                  return 'Password does not match';
                }
                else return null;
              },
            ),
            SizedBox(height: 23.0,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Gender",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),),
                  Radio(
                    activeColor: Colors.white,
                    value: 'M',
                    groupValue: gender,
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                      });
                    },
                  ),
                  Text("Male",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),),
                  Radio(
                    activeColor: Colors.white,
                    value: 'F',
                    groupValue: gender,
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                      });
                    },
                  ),
                  Text("Female",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),),
                ]),
            isValidateForm1 && gender == null ? Text('Required', style: TextStyle(color: Colors.white, fontSize: 12.0),) : Container(),
            SizedBox(height: 23.0,),
            TextFormField(
              controller: phone,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_android, color: Colors.white,),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,),),
                errorBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,),),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,),),
                hintText: 'Phone Number ',
                hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                errorStyle: TextStyle(color: Colors.white),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                }  if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                  return 'Only Numbers';
                }  if (value.length < 10) {
                  return 'Enter Valid Number';
                }  if (value.length > 10){
                  return 'Number Should be less than 10';
                }
                return null;
              },
            ),
            SizedBox(height: 23.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  value: status,
                  onChanged: (bool val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                      text: 'I agree the ',
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                      children: [
                        TextSpan(
                            text: "Terms & Condition",
                            style: TextStyle(fontSize: 15.0,
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {

                              }
                        ),
                      ]
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.0,),
          //  status1 && status ==false ? Text('Required', style: TextStyle(color: Colors.white, fontSize: 12.0),) : Container(),
            SizedBox(height: 13.0,),
          ],
        ),
      );
    }
  }
