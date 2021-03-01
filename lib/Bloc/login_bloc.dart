import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/user_model.dart';

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
    final success = SuccessModel.fromJson(jsonDecode(response.body));
    final error = ErrorModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      responseStatus = response.statusCode;
      print('Login Successful ${response.statusCode}');
      print(user);
      loginSink.add(success.userMsg);
    } else if (response.statusCode == 401){
      responseStatus = response.statusCode;
      print('Login error ${response.statusCode}');
      loginSink.add(error.userMsg);
    }else {
      responseStatus = response.statusCode;
      print('Login error ${response.statusCode}');
      loginSink.add(error.userMsg);
    }
  }



void dispose(){
  stateStreamController.close();
}

}