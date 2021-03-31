import 'package:flutter/material.dart';
import 'package:neostore/model_class/oder_list_model_class.dart';
import 'package:neostore/bloc/order_list_bloc.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/pages/orders_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {

  String accessToken;
  bool isSearching = false;
  final orderListObj = OrderListBloc();
  List<OrderData> orderList = List();
  List<OrderData> filteredOrderList = List();


  @override
  void initState() {
    getToken();
    /// Stream Listener
    orderListObj.orderListStream.listen((value) {
      if(value.data != null){
        print(filteredOrderList);
          setState(() {
            orderList.addAll(value.data);
            filteredOrderList = orderList;
          });
      }
      else{
        return Center(child: CircularProgressIndicator(),);
      }
    });

    super.initState();
  }

  void filterOrderList(value){
    setState(() {
      filteredOrderList = orderList.where((element) => element.id.toString().contains(value)).toList();
    });
  }


  getToken() async{
    SharedPreferences perf = await SharedPreferences.getInstance();
    accessToken = perf.getString("accessToken");
    orderListObj.getOrderList(accessToken);
  }

  @override
  void dispose() {
    orderListObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: isSearching == false ? Text('My Orders', style: TextStyle(fontSize: 25.0),) :
        Theme(
          data: ThemeData(primaryColor: Colors.white),
          child: TextField(
            onChanged: (value){
              filterOrderList(value);
            },
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,color: Colors.white,),
              hintText: "Search Order ID Here",hintStyle: TextStyle(color: Colors.white),
            //  border: InputBorder.none,
            ),),
        ),
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
        actions: [ isSearching == true ?
        IconButton(
            icon: Icon(Icons.cancel,size: 30.0,),
            onPressed: (){
              setState(() {
                isSearching = false;
                filteredOrderList = orderList;
              });
            }
        ) : IconButton(
            icon: Icon(Icons.search,size: 30.0,),
            onPressed: (){
              setState(() {
                isSearching = true;
              });
            }
        )
        ],
      ),
      body: filteredOrderList.isNotEmpty ?
      Container(
        child: ListView.builder(
            itemCount: filteredOrderList.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  Container(
                    height: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPage(id: filteredOrderList[index].id,)));
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(bottom:10.0),
                          child: Text("Order ID : "+filteredOrderList[index].id.toString(),style: TextStyle(fontSize: 16.0),),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 125.0,
                                child: Divider(height: 0.6,thickness: 0.6,)),
                            Padding(
                              padding: EdgeInsets.only(top:10.0),
                              child: Text("Ordered Date : "+filteredOrderList[index].created,style: TextStyle(fontSize: 11.0),),
                            ),
                          ],
                        ),
                        trailing: Text("₹ "+filteredOrderList[index].cost.toStringAsFixed(2),style: TextStyle(fontSize: 20.0),),
                      ),
                    ),
                  ),
                  Divider(height: 2.0, thickness: 2.0,),
                ],
              );
            }),
      ) :
      Center(child: Text("Nothing Ordered Yet!",style: TextStyle(fontSize: 30.0,color: Colors.black),),),
    );
  }
}
