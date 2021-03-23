import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:neostore/model_class/store_locator_model_class.dart';

class StoreLocatorBloc{

  StreamController stateStreamController = StreamController<StoreLocatorModel>.broadcast();
  StreamSink<StoreLocatorModel> get storeLocatorSink => stateStreamController.sink;
  Stream<StoreLocatorModel> get storeLocatorStream => stateStreamController.stream;

   loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/store_locator.json');
    StoreLocatorModel data = json.decode(jsonText);
    print("Store $data");
   storeLocatorSink.add(data);
   }

  void dispose() {
    stateStreamController.close();
  }
}