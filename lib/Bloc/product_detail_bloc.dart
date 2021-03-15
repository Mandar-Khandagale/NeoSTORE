import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/Model_Class/product_detail_model_class.dart';





class ProductDetailBloc {

  StreamController stateStreamController = StreamController<ProductDetails>();
  StreamSink<ProductDetails> get productDetailSink  => stateStreamController.sink;
  Stream<ProductDetails> get productDetailStream => stateStreamController.stream;


  getProductDetail() async {
    var endpointUrl = "http://staging.php-dev.in:8844/trainingapp/api/products/getDetail";
    Map<String, String> queryParams ={
      "product_id" : "1",
    };
    String queryString = Uri(queryParameters : queryParams).query;
    var requestUrl = endpointUrl+ "?" + queryString;
    var response = await http.get(requestUrl);
    print("productdetails:-${response.body}");
    if(response.statusCode == 200){
      ProductDetails productDetails = ProductDetails.fromJson(jsonDecode(response.body));
      productDetailSink.add(productDetails);
    }
  }




  void dispose(){
    stateStreamController.close();
  }

}