import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/order_details_model_class.dart';

class OrdersDetailBloc{

  StreamController stateStreamController = StreamController<OrderDetailsModel>.broadcast();
  StreamSink<OrderDetailsModel> get orderDetailSink => stateStreamController.sink;
  Stream<OrderDetailsModel> get orderDetailStream => stateStreamController.stream;

  getOrderDetails(String accessToken, int id) async{
    var endPointUrl = "http://staging.php-dev.in:8844/trainingapp/api/orderDetail";
    Map<String, String> queryParams ={
      "order_id" : id.toString(),
    };
    String queryString = Uri(queryParameters : queryParams).query;
    var requestUrl = endPointUrl+ "?" +queryString;
    var response = await http.get(requestUrl,headers: {
      "access_token" : accessToken,
    });

    OrderDetailsModel orderDetail = OrderDetailsModel.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      orderDetailSink.add(orderDetail);
    }else{
      orderDetailSink.add(orderDetail);
    }
  }

  void dispose() async {
    stateStreamController.close();
  }
}