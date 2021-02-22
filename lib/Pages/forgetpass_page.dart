import 'package:flutter/material.dart';
import 'package:neostore/user_model.dart';
import 'package:http/http.dart' as http;
Color myRed1 = Color(0xffe91c1a);


class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}


Future<Forget> forgetPass(String email) async {
  final String apiUrl = 'http://staging.php-dev.in:8844/trainingapp/api/users/forgot';
  final response = await http.post(apiUrl, body: {
    'email' : email,
  });
  if(response.statusCode == 200){
    final String repo = response.body;
    return forgetFromJson(repo);
  }else{
    print('Forget pass ${response.statusCode}');
    return null;
  }
}



class _ForgetPassState extends State<ForgetPass> {

  final forgetKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myRed1,
        title: Text('Forget Password?'),
        centerTitle: true,
      ),
      backgroundColor: Colors.red,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 33.0,right: 33.0),
          child: Form(
            key: forgetKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:49.0,bottom:49.0,),
                  child: Text('NeoSTORE',style: TextStyle(color: Colors.white,fontSize: 45.0,fontWeight: FontWeight.bold),),
                ),
                TextFormField(
                  controller: userName,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.white,),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[500]),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,),),
                    hintText: 'Email Address',
                    hintStyle: TextStyle(color: Colors.white,fontSize: 18.0),
                    errorStyle: TextStyle(color: Colors.green),
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
                SizedBox(
                  width: 293.33,
                  height: 47.33,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () async {
                        setState(()  {
                          if(forgetKey.currentState.validate()){
                            final String email = userName.text;
                             forgetPass(email);
                             Navigator.of(context).pop();
                          }else {
                            print("Password not changed");
                          }
                        });
                      },
                      color: Colors.white,
                      child: Text('SUBMIT',
                        style: TextStyle(fontSize: 26.0, color: Colors.red),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
