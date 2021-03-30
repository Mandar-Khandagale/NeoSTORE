import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neostore/Bloc/forget_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}






class _ForgetPassState extends State<ForgetPass> {

 // final scaffoldKey = GlobalKey<ScaffoldState>();
  final forgetKey = GlobalKey<FormState>();
  TextEditingController forgetName = TextEditingController();
  final forgetObj = ForgetBloc();
  bool isLoading = false;


  @override
  void dispose() {
    forgetObj.dispose();
    super.dispose();
  }

  progressIndicator(){
    forgetObj.stateStream.listen((value) {
      if(value.isNotEmpty){
        Fluttertoast.showToast(
            msg: value,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Colors.black
        );
        if(forgetObj.responseStatus == 200){
          isLoading = false;
          Future.delayed(Duration(seconds: 1), (){
            Navigator.pop(context);
          });
        }else{
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    print("---forget widget tree---");
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 33.0,right: 33.0,top: 150.0,bottom: 250.0),
            child: Form(
              key: forgetKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:49.0,bottom:49.0,),
                      child: Text('NeoSTORE',style: TextStyle(color: Colors.white,fontSize: 45.0,fontWeight: FontWeight.bold),),
                    ),
                    TextFormField(
                      controller: forgetName,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
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
                        hintText: 'Email Address',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 18.0),
                        errorStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        } else if (!RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                          return 'Invalid Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 26.0,),
                    isLoading == false ?
                    SizedBox(
                      width: 293.0,
                      height: 47.0,
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.white)),
                          onPressed: () async {
                              if(forgetKey.currentState.validate()){
                                setState(() {
                                  isLoading = true;
                                });
                                final String email = forgetName.text;
                                forgetObj.forgetPass(email);
                                progressIndicator();
                              }
                          },
                          color: Colors.white,
                          child: Text('SUBMIT',
                            style: TextStyle(fontSize: 26.0, color: Colors.red),)),
                    ) : CircularProgressIndicator(),
                    // StreamBuilder<String>(
                    //   stream: forgetObj.stateStream,
                    //     builder: (BuildContext context, snapshot ){
                    //   if(snapshot.data != null){
                    //     Fluttertoast.showToast(
                    //         msg: snapshot.data,
                    //         toastLength: Toast.LENGTH_SHORT,
                    //         gravity: ToastGravity.BOTTOM,
                    //         backgroundColor: Colors.white,
                    //         textColor: Colors.black
                    //     );
                    //     if(forgetObj.responseStatus == 200){
                    //      // print("Saurabh:-${snapshot.data.hashCode}");
                    //       Future.delayed(Duration(seconds: 2), (){
                    //         Navigator.pop(context);
                    //       });
                    //     }
                    //   }
                    //     return Container();
                    //     }
                    // ),
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
