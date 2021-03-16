import 'dart:async';
import 'dart:convert';
import 'package:neostore/model_class/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginBloc {

   int responseStatus;

  final stateStreamController = StreamController<String>();
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
        perf.setString("key1", success.data.firstName);
        perf.setString("key2", success.data.lastName);
        perf.setString("key3", success.data.email);
        perf.setString("key4", success.data.accessToken);
        perf.setString("key5", success.data.phoneNo);
        perf.setString("key6", success.data.dob);
      perf.setString("key7", success.data.profilePic);
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