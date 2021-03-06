import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:neostore/Bloc/update_account_bloc.dart';
import 'package:neostore/bloc/account_details_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';


class UpdateAccountDetails extends StatefulWidget {
  @override
  _UpdateAccountDetailsState createState() => _UpdateAccountDetailsState();
}

class _UpdateAccountDetailsState extends State<UpdateAccountDetails> {

  final updateAccountKey = GlobalKey<FormState>();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController emailAdd = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController dob = TextEditingController();
  String accessToken; String  base64Image,profilePic;

  final updateObj = UpdateAccountBloc();
  final accountInfoObj = AccountDetailsBloc();

  bool isLoading = false;

  File _image;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      fName.text = perf.getString("firstName");
      lName.text = perf.getString("lastName");
      emailAdd.text = perf.getString("email");
      phoneNo.text = perf.getString("phoneNo");
      dob.text = perf.getString("dob");
      accessToken = perf.getString("accessToken");
      profilePic = perf.getString("profilePic");
    });
  }

  @override
  void dispose() {
    fName.dispose();
    lName.dispose();
    emailAdd.dispose();
    phoneNo.dispose();
    dob.dispose();
    updateObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: myRed1,
          title: Text('EDIT PROFILE',style: TextStyle(fontSize: 25.0),),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
            Navigator.pop(context,true);
          },),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: updateAccountKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(33.0,0.0,33.0,0.0),
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              _showerPicker(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 133.0,
                                width: 133.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  // image: DecorationImage(image: _image != null ?  FileImage(File(_image.path))
                                  //     : NetworkImage(profilePic != null ? profilePic :
                                  // "https://www.pngitem.com/pimgs/m/4-40070_user-staff-man-profile-user-account-icon-jpg.png",),fit: BoxFit.fill,
                                  // ),
                                ),
                                child: profilePic == null && _image == null ? Container(child: Center(
                                    child: fName.text.isEmpty && lName.text.isEmpty ? Text("") : Text(fName.text[0]+lName.text[0] ,style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),)),):
                                    Container(decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,
                                    image: DecorationImage(image: _image !=null ? FileImage(File(_image.path)) : NetworkImage(profilePic),fit: BoxFit.fill)),),
                              ),
                            ),
                          ),
                        ),
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
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: lName,
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
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                            errorStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required';
                            } else if (!RegExp(r"^[a-zA-Z,.\-]+$").hasMatch(value)) {
                              return 'Only Characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: emailAdd,
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
                            hintText: 'Email Address',
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
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: phoneNo,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
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
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
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
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: dob,
                          onTap: _pickDate,
                          style: TextStyle(color: Colors.white),
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.cake, color: Colors.white,),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),),
                            errorBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),),
                            hintText: 'Date of Birth',
                            hintStyle: TextStyle(color: Colors.white, fontSize: 18,),
                            errorStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required';
                            }else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0,),
                        isLoading == false ?
                        Container(
                          width: double.infinity,
                          height: 55.0,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: (){
                              print("Update:-$accessToken");
                              if(updateAccountKey.currentState.validate()){
                                setState(() {
                                  isLoading = true;
                                });
                               String firstN = fName.text; String lastN = lName.text; String email = emailAdd.text; String phone = phoneNo.text;
                               String date = dob.text;  String pic = base64Image;
                               if(pic == null){
                                 pic = "";
                                 updateObj.updateAccount(firstN,lastN,email,phone,date,accessToken,pic);
                               }else{
                                 pic = "data:image/jpg;base64," + pic;
                                 updateObj.updateAccount(firstN,lastN,email,phone,date,accessToken,pic);
                               }
                              }
                            },
                            color: Colors.white,
                            child: Text("SUBMIT",style: TextStyle(fontSize: 23.0, color: Colors.red,fontWeight: FontWeight.w400)),
                          ),
                        ) : CircularProgressIndicator(),
                        SizedBox(height: 45,),
                        StreamBuilder<String>(
                            stream: updateObj.updateAccountStream,
                            builder: (BuildContext context, snapshot ){
                              if(snapshot.data != null){
                                Fluttertoast.showToast(
                                    msg: snapshot.data,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white
                                );
                                if(updateObj.responseStatus == 200){
                                  isLoading = false;
                                  Future.delayed(Duration(milliseconds: 500), (){
                                    Navigator.pop(context,true);
                                  });
                                }
                              }
                              return Container();
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   _pickDate() async{
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025)
    );
    String formatDate = DateFormat('dd-MM-yyyy').format(date);
    dob.text=formatDate;
  }
  
  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera,imageQuality: 60,);
    setState(() {
      _image = File(image.path);
      List<int> imageBytes =  _image.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    });
  }
  _imgFromGallery() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 60,);
    setState(() {
      _image = File(image.path);
      List<int> imageBytes =  _image.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    });

  }

  void _showerPicker(context){
    showModalBottomSheet(context: context, builder: (BuildContext con){
      return SafeArea(child: Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: (){
                _imgFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Camera"),
              onTap: (){
                _imgFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ));
    });
  }


  Future<bool> _onWillPop() {
    Navigator.pop(context,true);
    return null;
  }
}
