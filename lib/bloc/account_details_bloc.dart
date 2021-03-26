import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/account_details_model_class.dart';

class AccountDetailsBloc{

  StreamController stateStreamController = StreamController<AccountInfoDetails>.broadcast();
  StreamSink<AccountInfoDetails> get accountDetailsSink => stateStreamController.sink;
  Stream<AccountInfoDetails> get accountDetailsStream => stateStreamController.stream;

  getAccountDetails(String accessToken)async {
    var requestUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData";
    var response = await http.get(requestUrl, headers: {
      "access_token" : accessToken,
    });

    AccountInfoDetails details = AccountInfoDetails.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      accountDetailsSink.add(details);
    }else{
      accountDetailsSink.add(details);
    }

  }


  void dispose(){
    stateStreamController.close();
  }
}