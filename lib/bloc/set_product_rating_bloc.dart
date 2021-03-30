import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore/model_class/set_rating_model_class.dart';

class SetProductRatingBloc {

  int responseStatus;

  StreamController stateStreamController = StreamController<SetRating>.broadcast();
  StreamSink<SetRating> get setRatingSink => stateStreamController.sink;
  Stream<SetRating> get setRatingStream => stateStreamController.stream;

  setRating(int id,String rate) async {
    var requestUrl = "http://staging.php-dev.in:8844/trainingapp/api/products/setRating";
    var response = await http.post(requestUrl, body: {
      "product_id" : id.toString(),
      "rating" : rate,
    });
    SetRating setRating = SetRating.fromJson(jsonDecode(response.body));
    if(response.statusCode == 200){
      responseStatus = response.statusCode;
      print('Rate success ${response.statusCode}');
      print('rate success ${response.body}');
      setRatingSink.add(setRating);
    }else if(response.statusCode == 401){
      responseStatus = response.statusCode;
      print('Rate  error ${response.statusCode}');
      setRatingSink.add(setRating);
    }
    else {
      responseStatus = response.statusCode;
      print('Rate  error ${response.statusCode}');
      setRatingSink.add(setRating);
    }
  }



  void dispose(){
    stateStreamController.close();
  }
}