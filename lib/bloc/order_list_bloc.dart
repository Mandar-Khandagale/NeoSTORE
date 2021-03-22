import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:neostore/model_class/oder_list_model_class.dart';

class OrderListBloc{

  int responseStatus;

  StreamController stateStreamController = StreamController<OrderListModel>.broadcast();
  StreamSink<OrderListModel> get orderListSink => stateStreamController.sink;
  Stream<OrderListModel> get orderListStream => stateStreamController.stream;

  getOrderList(String accessToken) async {

    var requestUrl = "http://staging.php-dev.in:8844/trainingapp/api/orderList";
    var response = await http.get(requestUrl,headers: {
      "access_token" : accessToken,
    });

    OrderListModel orderList = OrderListModel.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      print("OrderList:-${response.body}");
      responseStatus = response.statusCode;
      orderListSink.add(orderList);
    }else{
      responseStatus = response.statusCode;
      orderListSink.add(orderList);
    }
  }


  void dispose(){
    stateStreamController.close();
  }
}