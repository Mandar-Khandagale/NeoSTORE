import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neostore/pages/homePage.dart';
import 'package:neostore/pages/reset_password_page.dart';
import 'package:neostore/pages/update_account_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  String firstName, lastName, email,phoneNo,dob,profilePic;



  fetchData() async{
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      firstName = perf.getString("firstName");
      lastName = perf.getString("lastName");
      email = perf.getString("email");
      phoneNo = perf.getString("phoneNo");
      dob = perf.getString("dob");
      profilePic = perf.getString("profilePic");
    });
    print("Image url $profilePic ");

  }

@override
  void initState() {
      fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text('My Account',style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));
        },),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(33.0,0.0,33.0,0.0),
                child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 133.0,
                        width: 133.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(image: profilePic != null ? NetworkImage(profilePic):NetworkImage('https://www.pngitem.com/pimgs/m/4-40070_user-staff-man-profile-user-account-icon-jpg.png'),
                              fit:BoxFit.fill ),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.white,),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: firstName,
                      labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  SizedBox(height: 15.0,),
                  TextField(
                   enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.white,),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: lastName,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.white,),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: email,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android, color: Colors.white,),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: phoneNo,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.cake, color: Colors.white,),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: dob != null ? dob : "Edit your DOB",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateAccountDetails()));
                      },
                      color: Colors.white,
                      child: Text("EDIT PROFILE",style: TextStyle(fontSize: 23.0, color: Colors.red,fontWeight: FontWeight.w400)),
                      ),
                    ),
                  SizedBox(height: 45,),
                ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 52.0,
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordPage()));
                  },
                  color: Colors.white,
                  child: Text("RESET PASSWORD",style: TextStyle(fontSize: 17.0, color: Colors.black,fontWeight: FontWeight.w300)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
