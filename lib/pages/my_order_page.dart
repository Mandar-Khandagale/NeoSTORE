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
  final orderListObj = OrderListBloc();
  List<OrderData> orderList = List();


  @override
  void initState() {
    getToken();
    super.initState();
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
        title: Text("My Orders",style: TextStyle(fontSize: 25.0),),
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
          Icon(Icons.search,color: Colors.white,size: 30.0,)
        ],
      ),
      body: Container(
        child: StreamBuilder<OrderListModel>(
          stream: orderListObj.orderListStream,
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(snapshot.data.data.isEmpty){
                return Center(child: Text("Not Anything Ordered Yet!",style: TextStyle(fontSize: 30.0),),);
              }
              else{
                orderList.addAll(snapshot.data.data);
                return ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          Container(
                            height: 100.0,
                            child: Padding(
                              padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPage(id: orderList[index].id,)));
                                },
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom:10.0),
                                  child: Text("Order ID : "+orderList[index].id.toString(),style: TextStyle(fontSize: 16.0),),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 125.0,
                                        child: Divider(height: 0.6,thickness: 0.6,)),
                                    Padding(
                                      padding: EdgeInsets.only(top:10.0),
                                      child: Text("Ordered Date : "+orderList[index].created,style: TextStyle(fontSize: 11.0),),
                                    ),
                                  ],
                                ),
                                trailing: Text("₹ "+orderList[index].cost.toStringAsFixed(2),style: TextStyle(fontSize: 20.0),),
                              ),
                            ),
                          ),
                          Divider(height: 2.0, thickness: 2.0,),
                        ],
                      );
                    });
              }
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
