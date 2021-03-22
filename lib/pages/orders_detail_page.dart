import 'package:flutter/material.dart';
import 'package:neostore/bloc/orders_detail_bloc.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/model_class/order_details_model_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {

  int id;
  OrderDetailsPage({this.id});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState(this.id);
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  int id;
  _OrderDetailsPageState(this.id);

  String accessToken;
  OrdersDetailBloc ordersDetailObj = OrdersDetailBloc();
  List<OrderDetails> orderDetailsList = List();

  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async{
    SharedPreferences perf = await SharedPreferences.getInstance();
    accessToken = perf.getString("accessToken");
    ordersDetailObj.getOrderDetails(accessToken, id);
  }


  @override
  void dispose() {
    ordersDetailObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text("Order ID : "+id.toString(),style: TextStyle(fontSize: 25.0),),
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
      body: Container(
        child: StreamBuilder<OrderDetailsModel>(
          stream: ordersDetailObj.orderDetailStream,
          builder: (context, snapshot){
            if(snapshot.hasData){
              orderDetailsList.addAll(snapshot.data.data.orderDetails);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orderDetailsList.length,
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              Container(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                                  child: ListTile(
                                    leading: Container(
                                      width: 66.0,
                                      height: 73.0,
                                      child: Image(
                                        image: NetworkImage(orderDetailsList[index].prodImage,),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(top:10.0),
                                      child: Text(orderDetailsList[index].prodName,style: TextStyle(fontSize: 15.0,),),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("(${orderDetailsList[index].prodCatName})",style: TextStyle(fontStyle: FontStyle.italic),),
                                        SizedBox(height: 13.0,),
                                        Text("QTY : "+orderDetailsList[index].quantity.toString()),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("₹ "+orderDetailsList[index].total.toStringAsFixed(2)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(height: 2.0,thickness: 2.0,),
                            ],
                          );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                      child: Container(
                        height: 66,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TOTAL",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                            Text("₹ "+snapshot.data.data.cost.toStringAsFixed(2),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 2.0,thickness: 2.0,),
                  ],
                ),
              );
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
