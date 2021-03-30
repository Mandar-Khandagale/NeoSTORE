import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/user_model.dart';


class ForgetBloc {
   int responseStatus ;
  final stateStreamController = StreamController<String>.broadcast();
  StreamSink<String> get stateSink => stateStreamController.sink;
  Stream<String>  get stateStream => stateStreamController.stream;



       forgetPass(String email) async {
        final String apiUrl = 'http://staging.php-dev.in:8844/trainingapp/api/users/forgot';
        final response = await http.post(apiUrl, body: {
          'email' : email,
        });
        final success = SuccessModel.fromJson(jsonDecode(response.body));
        final error = ErrorModel.fromJson(jsonDecode(response.body));
        if(response.statusCode == 200){
          responseStatus = response.statusCode;
          print('Forget pass success ${response.statusCode}');
          stateSink.add(success.userMsg);
        }else if(response.statusCode == 401){
          responseStatus = response.statusCode;
          print('Forget pass error ${response.statusCode}');
          stateSink.add(error.userMsg);
        }
        else {
          responseStatus = response.statusCode;
          print('Forget pass error ${response.statusCode}');
          stateSink.add(error.userMsg);
        }
      }


  void dispose(){
    stateStreamController.close();
  }

}