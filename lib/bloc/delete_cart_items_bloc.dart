import 'dart:async';
import 'dart:convert';
import 'package:neostore/model_class/edit_cart_model_class.dart';
import 'package:http/http.dart' as http;

class DeleteCartItems {

  int responseStatus;

  StreamController stateStreamController = StreamController<EditCartModel>.broadcast();
  StreamSink<EditCartModel> get deleteCartSink => stateStreamController.sink;
  Stream<EditCartModel> get deleteCartStream => stateStreamController.stream;

  deleteCart(String id,String accessToken) async {
     var requestUrl = "http://staging.php-dev.in:8844/trainingapp/api/deleteCart";
     var response = await http.post(requestUrl , body: {
       "product_id" : id,
     },
     headers: {
       "access_token" : accessToken,
     });
     EditCartModel cart = EditCartModel.fromJson(jsonDecode(response.body));
     if(response.statusCode == 200){
       responseStatus = response.statusCode;
       deleteCartSink.add(cart);
     }else{
       print("Delete cart response:- ${response.statusCode}");
       responseStatus = response.statusCode;
       deleteCartSink.add(cart);
     }
  }


  void dispose(){
    stateStreamController.close();
  }
}