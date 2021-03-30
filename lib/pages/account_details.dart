import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neostore/bloc/account_details_bloc.dart';
import 'package:neostore/model_class/account_details_model_class.dart';
import 'package:neostore/pages/reset_password_page.dart';
import 'package:neostore/pages/update_account_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> with WidgetsBindingObserver {
  String firstName, lastName, email,phoneNo,dob,profilePic;
  String accessToken;
  final accountInfoObj = AccountDetailsBloc();


  fetchData() async{
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      // firstName = perf.getString("firstName");
      // lastName = perf.getString("lastName");
      // email = perf.getString("email");
      // phoneNo = perf.getString("phoneNo");
      // dob = perf.getString("dob");
      // profilePic = perf.getString("profilePic");
      accessToken = perf.getString("accessToken");
    });
    accountInfoObj.getAccountDetails(accessToken);
    print("Image url $accessToken ");

  }

@override
  void initState() {
      fetchData();
    super.initState();
  }

  getRefresh() async{
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
print("----Account----");
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: myRed1,
          title: Text('My Account',style: TextStyle(fontSize: 25.0),),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
            Navigator.pop(context,true);
          },),
        ),
        body: StreamBuilder<AccountInfoDetails>(
          stream: accountInfoObj.accountDetailsStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return SingleChildScrollView(
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
                                    // image: DecorationImage(image: snapshot.data.data.userData.profilePic != null ? NetworkImage(snapshot.data.data.userData.profilePic):
                                    // NetworkImage('https://www.pngitem.com/pimgs/m/4-40070_user-staff-man-profile-user-account-icon-jpg.png'),
                                    //     fit:BoxFit.fill ),
                                  ),
                                  child: snapshot.data.data.userData.profilePic != null ?
                                  Container(decoration: BoxDecoration(shape: BoxShape.circle,image:DecorationImage(image: NetworkImage(snapshot.data.data.userData.profilePic,),fit: BoxFit.fill)),) :
                                  Container(decoration:BoxDecoration(shape: BoxShape.circle),child: Center(child: Text(snapshot.data.data.userData.firstName[0]+snapshot.data.data.userData.lastName[0],
                                    style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),),),
                                   // decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
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
                                labelText: snapshot.data.data.userData.firstName,
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
                                labelText: snapshot.data.data.userData.lastName,
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
                                labelText: snapshot.data.data.userData.email,
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
                                labelText: snapshot.data.data.userData.phoneNo,
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
                                labelText: snapshot.data.data.userData.dob != null ? snapshot.data.data.userData.dob : "Edit your DOB",
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateAccountDetails())).then((value) => value ? getRefresh() : null);
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
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    Navigator.pop(context,true);
  }
}
