import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/my_cart_model_class.dart';

class MyCartBloc{

  StreamController stateStreamController = StreamController<MyCartModel>();
  StreamSink<MyCartModel> get myCartSink => stateStreamController.sink;
  Stream<MyCartModel> get myCartStream => stateStreamController.stream;

  getCart(String accessToken) async{
    var requestUrl = "http://staging.php-dev.in:8844/trainingapp/api/cart";
    var response = await http.get(requestUrl,headers: {
      "access_token" : accessToken,
    });
    print("AccessToken:- $accessToken");
    print("Mycart body ${response.body}");
    if(response.statusCode == 200){
      MyCartModel myCart = MyCartModel.fromJson(jsonDecode(response.body));
      myCartSink.add(myCart);
    }

  }


  void dispose(){
    stateStreamController.close();
  }
}