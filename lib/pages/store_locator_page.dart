import 'package:flutter/material.dart';
import 'package:neostore/bloc/store_locator_bloc.dart';
import 'package:neostore/constants.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class StoreLocatorPage extends StatefulWidget {
  @override
  _StoreLocatorPageState createState() => _StoreLocatorPageState();
}

class _StoreLocatorPageState extends State<StoreLocatorPage> {

  final storeLocatorObj = StoreLocatorBloc();
  List data;

 Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString("assets/store_locator.json");
    setState(() {
      data = json.decode(jsonText);
    });
    print("Store $data");
    return "Success";
  }

  @override
  void initState() {
   this.loadJsonData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text("Store Locator",style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(Icons.search, color: Colors.white, size: 30.0,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 166.0,
              color: Colors.cyan,
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (builder, index){
              return Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0,bottom:20.0),
                      child: ListTile(
                        leading: Icon(Icons.location_pin) ,
                        title: Text(data[index]["store_name"],style: TextStyle(fontSize: 15.0),),
                        subtitle: Text(data[index]["store_address"],style: TextStyle(fontSize: 13.0)),
                      ),
                    ),
                  ),
                  Divider(height: 2.0,thickness: 2.0,),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
