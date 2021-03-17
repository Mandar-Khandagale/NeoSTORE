import 'dart:async';
import 'dart:convert';
import 'package:neostore/model_class/buy_now_model_class.dart';
import 'package:http/http.dart' as http;

class BuyNowBloc{
  int responseStatus;
  StreamController stateStreamController = StreamController<String>.broadcast();
  StreamSink<String>get buyNowSink => stateStreamController.sink;
  Stream<String> get buyNowStream => stateStreamController.stream;

  buyNow(int id,String qua,String accessToken) async {
    var requestUrl = "http://staging.php-dev.in:8844/trainingapp/api/addToCart";
    var response = await http.post(requestUrl, body: {
      "product_id": id.toString(),
      "quantity": qua,
    },
        headers: {
          "access_token": accessToken,
        });
    print('buy success mandar ${response.body}');
    BuyNowModel buyNowModel = BuyNowModel.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      responseStatus = response.statusCode;
      print('Buy success ${response.statusCode}');
      print('buy success ${response.body}');
      print('buy success access ${accessToken}');
      buyNowSink.add(buyNowModel.userMsg);
    }else if(response.statusCode == 401){
      responseStatus = response.statusCode;
      print('buy  error ${response.statusCode}');
      buyNowSink.add(buyNowModel.userMsg);
    }
    else {
      responseStatus = response.statusCode;
      print('buy  error ${response.statusCode}');
      buyNowSink.add(buyNowModel.userMsg);
    }
  }

  void dispose(){
    stateStreamController.close();
  }
}