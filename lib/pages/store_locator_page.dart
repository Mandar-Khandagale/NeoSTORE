import 'package:flutter/material.dart';
import 'package:neostore/bloc/store_locator_bloc.dart';
import 'package:neostore/constants.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Set<Marker> _markers = {};
 void _onMapCreated(GoogleMapController controller){
   setState(() {
     _markers.add(
       Marker(markerId: MarkerId("id-1"),
         position:  LatLng(19.2297281,72.845639),
         infoWindow: InfoWindow(
           title: "Royal Touche",
           snippet: "Wood and laminate flooring supplier",
         ),),
     );
     _markers.add(Marker(markerId: MarkerId("id-2"),
       position:  LatLng(19.2337028,72.8621114),
       infoWindow: InfoWindow(
         title: "A to Z Furnishing",
         snippet: "Strong Cupboard supplier",
       ),
     ),);
     _markers.add(
       Marker(markerId: MarkerId("id-3"),
         position:  LatLng(19.22786,72.8551824),
         infoWindow: InfoWindow(
           title: "Godrej Interio-Furniture Store",
           snippet: "Premium Chair Gallery in Borivali West, Mumbai",
         ),
       ),);
     _markers.add(
       Marker(markerId: MarkerId("id-4"),
         position:  LatLng(19.222180,72.869150),
         infoWindow: InfoWindow(
           title: "Shree Mahalaxmi Furniture",
           snippet: "Table Gallery in Borivali , Mumbai",
         ),
       ),);
     _markers.add(
       Marker(markerId: MarkerId("id-5"),
         position:  LatLng(19.229500,72.860320),
         infoWindow: InfoWindow(
           title: "Radha Krushna Furniture",
           snippet: "Modular furniture Gallery in Borivali",
         ),
       ),);
   });
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
      ),
      body: Column(
        children: [
          Container(
            height: 200.0,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(19.229500,72.860320),
                zoom: 13,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
