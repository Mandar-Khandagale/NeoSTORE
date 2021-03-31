import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/user_model.dart';

class RegisterBloc {

  int responseStatus ;

  final stateStreamController = StreamController<String>.broadcast();
  StreamSink<String> get registerSink => stateStreamController.sink;
  Stream<String> get registerStream => stateStreamController.stream;



   createUser(String fname, String lname, String mail, String pas, String conpass, String gen, String num,) async {
    final String apiUrl = 'http://staging.php-dev.in:8844/trainingapp/api/users/register';
    final response = await http.post(apiUrl, body: {
      "first_name": fname,
      "last_name": lname,
      "email": mail,
      "password": pas,
      "confirm_password": conpass,
      "gender": gen,
      "phone_no": num,
    });
    final success = SuccessModel.fromJson(jsonDecode(response.body));
    final error = ErrorModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      responseStatus = response.statusCode;
      print("Status Code:- ${response.statusCode}");
      registerSink.add(success.userMsg);
    } else if (response.statusCode == 404) {
      responseStatus = response.statusCode;
      print('Error${response.statusCode}');
      registerSink.add(error.userMsg);
    } else {
      responseStatus = response.statusCode;
      print('Error${response.statusCode}');
      registerSink.add(error.userMsg);
    }
  }

  void dispose() {
    stateStreamController.close();
  }
}
