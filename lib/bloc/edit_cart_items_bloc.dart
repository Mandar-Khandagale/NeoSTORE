import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/edit_cart_model_class.dart';

class EditCartBloc{

  int responseStatus;
  StreamController stateStreamController = StreamController<EditCartModel>.broadcast();
  StreamSink<EditCartModel> get editCartSink => stateStreamController.sink;
  Stream<EditCartModel> get editCartStream => stateStreamController.stream;

  editCart(String quantity,String id,String accessToken,) async {
    print("AccessTokencart:-$accessToken");
    print("id:-$id");
    print("qun:-$quantity");
    var requestUrl= "http://staging.php-dev.in:8844/trainingapp/api/editCart";
    var response = await http.post(requestUrl, body:{
      "product_id" : id,
      "quantity" : quantity,
    },
    headers: {
      "access_token" : accessToken,
    });
    var cart = EditCartModel.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      responseStatus = response.statusCode;
      editCartSink.add(cart);
    }
    else{
      print("Editcart:- ${response.statusCode}");
      responseStatus = response.statusCode;
      editCartSink.add(cart);
    }

  }

  void dispose(){
    stateStreamController.close();
  }
}