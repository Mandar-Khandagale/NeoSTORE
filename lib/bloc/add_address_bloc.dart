import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/user_model.dart';

class AddAddressBloc{

  int responseStatus;

  StreamController stateStreamController = StreamController<SuccessModel>();
  StreamSink<SuccessModel> get addAddressSink => stateStreamController.sink;
  Stream<SuccessModel> get addAddressStream => stateStreamController.stream;

  addAddress(String accessToken, String address) async {
    var requestUrl = "http://staging.php-dev.in:8844/trainingapp/api/order";
    var response = await http.post(requestUrl, body: {
    "address" : address,
    },
      headers: {
      "access_token" : accessToken,
      }
    );
    SuccessModel success = SuccessModel.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      print("AccessToken:-$accessToken");
      responseStatus = response.statusCode;
      addAddressSink.add(success);
    }else{
      responseStatus = response.statusCode;
      addAddressSink.add(success);
    }
  }

  void dispose(){
    stateStreamController.close();
  }
}