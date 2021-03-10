import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/Model_Class/product_list_model_class.dart';




class TableListBloc{


  final stateStreamController = StreamController<ProductList>();
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
      if(response.statusCode == 200){
        ProductList productList = ProductList.fromJson(jsonDecode(jsonData));
        tableListSink.add(productList);
      }
  }


  void dispose(){
    stateStreamController.close();
  }

}



