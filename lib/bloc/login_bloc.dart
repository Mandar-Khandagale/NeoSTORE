import 'dart:async';
import 'dart:convert';
import 'package:neostore/model_class/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginBloc {

   int responseStatus;

  final stateStreamController = StreamController<String>.broadcast();
  StreamSink<String> get loginSink => stateStreamController.sink;
  Stream<String> get loginStream => stateStreamController.stream;


   userValidate(String user, String pass) async {
    final String apiUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/login";
    final response = await http.post(apiUrl,
        body: {
          "email": user,
          "password": pass
        });
    print("mandar:-${response.body}");


    if (response.statusCode == 200) {
      final success = SuccessModel.fromJson(jsonDecode(response.body));
      responseStatus = response.statusCode;
      print('Login Successful ${response.statusCode}');
      print("fname= ${success.data.firstName}");
      SharedPreferences loginData = await SharedPreferences.getInstance();
       loginData.setString('login', user);
        SharedPreferences perf = await SharedPreferences.getInstance();
        perf.setString("firstName", success.data.firstName);
        perf.setString("lastName", success.data.lastName);
        perf.setString("email", success.data.email);
        perf.setString("accessToken", success.data.accessToken);
        perf.setString("phoneNo", success.data.phoneNo);
        perf.setString("dob", success.data.dob);
      perf.setString("profilePic", success.data.profilePic);
      loginSink.add(success.userMsg);
    } else if (response.statusCode == 401){
       final error = ErrorModel.fromJson(jsonDecode(response.body));
      responseStatus = response.statusCode;
      print('Login error ${response.statusCode}');
      loginSink.add(error.userMsg);
    }else {
       final error = ErrorModel.fromJson(jsonDecode(response.body));
      responseStatus = response.statusCode;
      print('Login error ${response.statusCode}');
      loginSink.add(error.userMsg);
    }
  }

void dispose(){
  stateStreamController.close();
}

}