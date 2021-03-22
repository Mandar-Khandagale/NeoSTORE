import 'package:flutter/material.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/pages/add_address_page.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text('Address List',style: TextStyle(fontSize: 25.0),),
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
          IconButton(
              icon: Icon(Icons.add),
              iconSize: 30.0,
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressPage()));
              }
          ),
        ],
      ),
    );
  }
}
