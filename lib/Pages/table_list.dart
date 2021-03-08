import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neostore/Model_Class/product_list_model_class.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class ProductTable extends StatefulWidget {
  @override
  _ProductTableState createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {

  Future<ProductList> fetchData() async {
    var response = await http.get("http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=1&limit=10&page=1");
   if(response.statusCode == 200){
     var jsonData = response.body;
     ProductList productList = ProductList.fromJson(jsonDecode(jsonData));
     return productList;
   }
   else{
     return null;
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tables', style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        backgroundColor: myRed1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },),
        actions: [
          Icon(Icons.search, color: Colors.white, size: 30.0,)
        ],
      ),
      body:FutureBuilder<ProductList>(
        future: fetchData(),
        builder: (context, snapshot){
         if(snapshot.hasData){
           List<ProductData> list = snapshot.data.data;
           return ListView.builder(
             itemCount: list.length,
             itemBuilder: (context, index){
               return Column(
                 children: [
                   Container(
                     height: 93.0,
                     child: Padding(
                       padding: const EdgeInsets.only(top:13.0,bottom: 13.0),
                       child: ListTile(
                         leading: Container(
                            height: 73.0,
                            width: 66.0,
                           child: Image(
                             image: NetworkImage(list[index].productImages),
                           ),
                         ),
                         title: Text(list[index].name,style: TextStyle(fontSize: 15.0,),),
                         subtitle: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(list[index].producer,style: TextStyle(fontSize: 10.0),),
                             SizedBox(height: 16.0,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Rs."+list[index].cost.toString(),style: TextStyle(fontSize: 20.0,color: Colors.red),),
                               //  productRating(list[index].rating),
                               ],
                             ),
                           ],
                         ),
                         trailing: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             productRating(list[index].rating),
                           ],
                         ),
                         // Container(
                         //   color: Colors.red,
                         //   child: Padding(
                         //     padding: const EdgeInsets.only(top:40.0),
                         //     child: Container(
                         //     width: 60,
                         //       height: 11,
                         //       child: Row(
                         //         children: [
                         //           Icon(Icons.star,color: Colors.yellow,size: 12.0,),
                         //           Icon(Icons.star,color: Colors.yellow,size: 12.0,),
                         //           Icon(Icons.star,color: Colors.yellow,size: 12.0,),
                         //           Icon(Icons.star,color: Colors.yellow,size: 12.0,),
                         //           Icon(Icons.star,color: Colors.yellow,size: 12.0,),
                         //         ],
                         //       ),
                         //     ),
                         //   ),
                         // ),

                       ),
                     ),
                   ),
                   Divider(height: 2.0,
                   thickness: 2.0,
                    ),
                 ],
               );
             },
           );
         }else{
           return Center(
               child: CircularProgressIndicator());
         }
        },
      ),
    );
  }

  Widget productRating(int rating) {
    switch(rating){
      case 1 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.grey,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),
            ],
          ),
        );
      } break;
      case 2 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),
            ],
          ),
        );
      }break;
      case 3 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),
            ],
          ),
        );
      }break;
      case 4 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.grey,size: 12.0,),
            ],
          ),
        );
      }break;
      case 5 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),
            ],
          ),
        );
      }
    }

  }
}
