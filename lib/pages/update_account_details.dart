import 'dart:convert';
import 'dart:io' as Io ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore/Bloc/update_account_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'loginPage.dart';

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
  String accessToken; String  base64Image;

  final updateObj = UpdateAccountBloc();

  Io.File _image;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      fName.text = perf.getString("key1");
      lName.text = perf.getString("key2");
      emailAdd.text = perf.getString("key3");
      phoneNo.text = perf.getString("key5");
      dob.text = perf.getString("key6");
      accessToken = perf.getString("key4");
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
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text('Edit Profile',style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
          Navigator.pop(context);
        },),
        actions: [
          Icon(Icons.search,color: Colors.white,size: 30.0,)
        ],
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
                              ),
                              child: _image != null ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(_image,fit: BoxFit.fitHeight,),
                              ) : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.camera_alt),
                              ),
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
                             String firstN = fName.text; String lastN = lName.text; String email = emailAdd.text; String phone = phoneNo.text;
                             String date = dob.text; final String pic = base64Image;
                              updateObj.updateAccount(firstN,lastN,email,phone,date,accessToken,pic);
                            }
                          },
                          color: Colors.white,
                          child: Text("SUBMIT",style: TextStyle(fontSize: 23.0, color: Colors.red,fontWeight: FontWeight.w400)),
                        ),
                      ),
                      SizedBox(height: 45,),
                      StreamBuilder<String>(
                          stream: updateObj.updateAccountStream,
                          builder: (BuildContext context, snapshot ){
                            if(snapshot.data != null){
                              Fluttertoast.showToast(
                                  msg: snapshot.data,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black
                              );
                              if(updateObj.responseStatus == 200){
                                // print("Saurabh:-${snapshot.data.hashCode}");
                                Future.delayed(Duration(seconds: 2), (){
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
              ],
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
    var image = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = Io.File(image.path);
      List<int> imageBytes =  _image.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    });
  }
  _imgFromGallery() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = Io.File(image.path);
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

}
