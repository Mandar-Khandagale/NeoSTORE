import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAccountBloc{
  int responseStatus;

  StreamController stateStreamController = StreamController<String>.broadcast();
  StreamSink<String> get updateAccountSink => stateStreamController.sink;
  Stream<String> get updateAccountStream => stateStreamController.stream;
// manabdabd
  updateAccount(String firstN,String lastN,String mail,String phone,String dob,String accessToken,String pic) async {
    print("Date:-$dob");
    print("first:-$firstN");
    print("last:-$lastN");
    print("email:-$mail");
    print("phoneno:-$phone");
    print("token:-$accessToken");
    print("profile:-$pic");
    final String apiUrl = 'http://staging.php-dev.in:8844/trainingapp/api/users/update';
    final response = await http.post(apiUrl, body: {
      'first_name' : firstN,
      'last_name' : lastN,
      'email' : mail,
      'phone_no' : phone,
      'dob' : dob,
      'profile_pic' : pic
    },
      headers: {
        "access_token" : accessToken
      },
    );
    final success = SuccessModel.fromJson(jsonDecode(response.body));
    final error = ErrorModel.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      responseStatus = response.statusCode;
      print('Update acc success ${response.statusCode}');
      print('Update acc success ${response.body}');
      SharedPreferences perf = await SharedPreferences.getInstance();
      perf.setString("firstName", success.data.firstName);
      perf.setString("lastName", success.data.lastName);
      perf.setString("email", success.data.email);
      perf.setString("phoneNo", success.data.phoneNo);
      perf.setString("dob", success.data.dob);
      perf.setString("profilePic", success.data.profilePic);
      updateAccountSink.add(success.userMsg);
    }else if(response.statusCode == 401){
      responseStatus = response.statusCode;
      print('Update acc error ${response.statusCode}');
      updateAccountSink.add(error.userMsg);
    }
    else {
      responseStatus = response.statusCode;
      print('Update acc error ${response.statusCode}');
      updateAccountSink.add(error.userMsg);
    }

  }




  void dispose(){
   stateStreamController.close();
  }
}