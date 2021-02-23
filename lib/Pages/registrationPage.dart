import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:neostore/user_model.dart';
import 'package:http/http.dart' as http;

Color myRed1 = Color(0xffe91c1a);

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

Future<Register> createUser(String fname,String lname,String mail,String pas,String conpass,
    String gen, String num,) async {

  final String apiUrl = 'http://staging.php-dev.in:8844/trainingapp/api/users/register';
  final response = await http.post(apiUrl, body: {
    "first_name" : fname,
    "last_name" : lname,
    "email" : mail,
    "password" : pas,
    "confirm_password" : conpass,
    "gender" : gen,
    "phone_no" : num,
  });

  if(response.statusCode == 200){
    final String respo = response.body;
    print("Status Code:- ${response.statusCode}");
    return registerFromJson(respo);
  }else{
    print('Error${response.statusCode}');
    return null;
  }

}




class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String gender;
  String status;
  bool isValidateForm1 = false;
  bool showPass1 = true;
  bool showPass2 = true;
  bool status1 = false;


  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conPass = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text('Register'),
        centerTitle: true,
      ),
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
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
              SizedBox(
                width: 293.33,
                height: 47.33,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        addData();
                      });
                    },
                    color: Colors.white,
                    child: Text('REGISTER',
                      style: TextStyle(fontSize: 26.0, color: Colors.red),)),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void addData() async {
    isValidateForm1 = true;
    status1 = true;
    if(_formKey.currentState.validate()){
      if(gender != null && status !=null) {
        final String fname = fName.text;
        final String lname = lName.text; final String mail = email.text;final String pas = pass.text;
        final String  conpass = conPass.text; final String gen = gender;  final String num = phone.text;

        final Register data = await createUser(fname, lname, mail, pas, conpass, gen, num);

      }
    }else{
      print('Submit Unsuccessful');
    }

  }

  Widget _form() {
    return Padding(
       padding: EdgeInsets.only(left: 20.0, right: 20.0,),
      child: Form(
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
                     borderSide: BorderSide(color: Colors.green[500]),),
                   enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),),
                  hintText: 'First Name',
                  hintStyle: TextStyle(color: Colors.white,fontSize:18,),
                errorStyle: TextStyle(color: Colors.green),
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
            SizedBox(height: 10,),
            TextFormField(
              controller: lName,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.white,),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[500]),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),),
                  hintText: 'Last Name',
                  hintStyle: TextStyle(color: Colors.white,fontSize:18,),
                errorStyle: TextStyle(color: Colors.green),
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
            SizedBox(height: 10,),
            TextFormField(
              controller: email,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.white,),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[500]),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white,fontSize:18,),
                errorStyle: TextStyle(color: Colors.green),
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
            SizedBox(height: 10,),
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
                  onPressed: (){
                      setState(() {
                        showPass1 = !showPass1;
                      });
                  },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[500]),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white,fontSize:18,),
                errorStyle: TextStyle(color: Colors.green),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Password';
                }else if(value.length < 6){
                  return 'Password should be greater than 6 characters';
                }
                else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
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
                    onPressed: (){
                      setState(() {
                        showPass2 = !showPass2;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[500]),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),),
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(fontSize:18,color: Colors.white),
                errorStyle: TextStyle(color: Colors.green),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please re-enter Password';
                }
                if(pass.text != conPass.text) {
                  return 'Password does not match';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top:23.0,bottom:13.0),
              child: Row(
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
            ),
            isValidateForm1 && gender == null ? Text('Required', style: TextStyle(color: Colors.green,fontSize: 12.0),) : Container(),
            SizedBox(height: 10.0,),
            TextFormField(
              controller: phone,
              maxLength: 10,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_android, color: Colors.white,),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[500]),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),),
                  hintText: 'Phone Number ',
                  hintStyle: TextStyle(fontSize:18,color: Colors.white),
                errorStyle: TextStyle(color: Colors.green),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                } else if (!RegExp(r"^[0-9,.\-]+$").hasMatch(value)) {
                  return 'Only Numbers';
                }else if (value.length < 10){
                  return 'Enter Valid Number';
                }else {
                  return null;
                }
              },
            ),
            // SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    activeColor: Colors.white,
                    value: 'checked',
                    groupValue: status,
                    onChanged: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                RichText(
                  text: TextSpan(
                    text: 'I agree the ',
                    style: TextStyle(fontSize: 15.0,color: Colors.white),
                    children: [
                      TextSpan(
                        text: "Terms & Condition",
                        style: TextStyle(fontSize: 15.0,color: Colors.white,decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){

                        }
                      ),
                    ]
                  ),
                ),
                ],
              ),
            ),
            status1 && status == null ? Text('Required', style: TextStyle(color: Colors.green,fontSize: 12.0),) : Container(),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }

}
