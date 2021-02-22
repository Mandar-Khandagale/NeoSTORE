import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

Future<Login> userValidate(String user, String pass) async {
  final String apiUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/login";
  final response = await http.post(apiUrl, body: {
    "email": user,
    "password": pass
  });

  if(response.statusCode == 200){
    final String respo = response.body;
    return loginFromJson(respo);
  }else {
    print('Login ${response.statusCode}');
    return null;
  }
}





class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  bool showPass0 = true;
  TextEditingController passUser = TextEditingController();
  TextEditingController userName = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 33.33,right: 33.33),
          child: Form(
            key: _loginKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 49.33),
                    child: Text("NeoSTORE",style: TextStyle(fontSize:45.0,color: Colors.white,fontWeight: FontWeight.bold ),),
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
                  SizedBox(height: 10.0,),
                  TextFormField(
                    controller: passUser,
                    style: TextStyle(color: Colors.white),
                    obscureText: showPass0,
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
                        borderSide: BorderSide(color: Colors.green[500]),),
                      enabledBorder: OutlineInputBorder(
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
                          style: TextStyle(fontSize: 26.0, color: Colors.red),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Forget Password?",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgetPass()));
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Text('DONT HAVE AN ACCOUNT?',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegistrationPage()));
        },
        child: Icon(Icons.add,size: 46.0,),
        backgroundColor: Colors.red[700],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0))
        ),
      ),
    );
  }

  login() async {
    if(_loginKey.currentState.validate()){
     final String user = userName.text; final String pass = passUser.text;
     final Login log = await userValidate(user, pass);
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePageScreen()));
     print("Post Login value ${log.email}");
      } else{
      print('Login Unsuccessful');
    }
  }



}
