import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:neostore/model_class/user_model.dart';

class ResetPasswordBloc{
  int responseStatus;

  StreamController stateStreamController = StreamController<String>();
  StreamSink<String> get resetPassSink => stateStreamController.sink;
  Stream<String> get resetPassStream => stateStreamController.stream;

  resetPassword(String currentPass, String newPass, String confirmPass,String accessToken) async {
    final String apiUrl = 'http://staging.php-dev.in:8844/trainingapp/api/users/change';
    final response = await http.post(apiUrl, body: {
      'old_password' : currentPass,
      'password' : newPass,
      'confirm_password' : confirmPass
    },
      headers: {
      "access_token" : accessToken
      },
    );
    final success = SuccessModel.fromJson(jsonDecode(response.body));
    final error = ErrorModel.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      responseStatus = response.statusCode;
      print('reset pass success ${response.statusCode}');
      resetPassSink.add(success.userMsg);
    }else if(response.statusCode == 401){
      responseStatus = response.statusCode;
      print('reset pass error ${response.statusCode}');
      resetPassSink.add(error.userMsg);
    }
    else {
      responseStatus = response.statusCode;
      print('reset pass error ${response.statusCode}');
      resetPassSink.add(error.userMsg);
    }

  }



  void dispose(){
    stateStreamController.close();
  }

}