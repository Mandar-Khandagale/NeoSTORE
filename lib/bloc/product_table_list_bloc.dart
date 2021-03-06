import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/product_list_model_class.dart';




class TableListBloc{

  int responseStatus;

  final stateStreamController = StreamController<ProductList>.broadcast();
  StreamSink<ProductList> get tableListSink => stateStreamController.sink;
  Stream<ProductList> get tableListStream => stateStreamController.stream;


    fetchData(int pageNumber) async {
     var endpointUrl = "http://staging.php-dev.in:8844/trainingapp/api/products/getList";
     Map<String, String> queryParams ={
       'product_category_id': '1',
       'limit': '10',
       'page' : pageNumber.toString()
     };
     String queryString = Uri(queryParameters : queryParams).query;
     var requestUrl = endpointUrl + "?" + queryString;
     var response = await http.get(requestUrl);
      var jsonData = response.body;
      print("tablelist:- ${response.body}");
      if(response.statusCode == 200){
        responseStatus = response.statusCode;
        ProductList productList = ProductList.fromJson(jsonDecode(jsonData));
        tableListSink.add(productList);
      }else{
        responseStatus = response.statusCode;
        ProductList productList = ProductList.fromJson(jsonDecode(jsonData));
        tableListSink.add(productList);
      }
  }


  void dispose(){
    stateStreamController.close();
  }

}



