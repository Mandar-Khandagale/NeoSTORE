import 'package:flutter/material.dart';
import '../constants.dart';

class ProductTable extends StatefulWidget {
  @override
  _ProductTableState createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tables',style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        backgroundColor: myRed1,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){
      Navigator.pop(context);
    },),
        actions: [
          Icon(Icons.search,color: Colors.white,size: 30.0,)
        ],
      ),
    );
  }
}
