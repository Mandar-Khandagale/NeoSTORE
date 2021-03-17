import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neostore/bloc/my_cart_bloc.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/model_class/my_cart_model_class.dart';
import 'package:shared_preferences/shared_preferences.dart';




class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {

  final myCartObj = MyCartBloc();
  String accessToken,qun;
  List<Data> cartList = List();


  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      accessToken = perf.getString("key4");
      print("bbks:- $accessToken");
    });
    myCartObj.getCart(accessToken);
  }
  @override
  void dispose() {
    myCartObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('My Cart', style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        backgroundColor: myRed1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(Icons.search, color: Colors.white, size: 30.0,)
        ],
      ),
      body: StreamBuilder<MyCartModel>(
        stream: myCartObj.myCartStream,
        builder: (context, snapshot){
          if(snapshot.hasData){
            cartList.addAll(snapshot.data.data);
            return Column(
              children: [
                ListView.builder(
                  itemCount: cartList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          Container(
                            height: 90.0,
                            child: Padding(
                              padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                              child: ListTile(
                                isThreeLine: true,
                                leading: Container(
                                  height: 73.0, width: 66.0,
                                  child: Image(image: NetworkImage(cartList[index].product.productImages),fit: BoxFit.fill,),
                                ),
                                title: Text(cartList[index].product.name, style: TextStyle(fontSize: 15.0,),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("(${cartList[index].product.productCategory})"),
                                   Text(cartList[index].quantity.toString()),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("₹ "+cartList[index].product.subTotal.toStringAsFixed(2),style: TextStyle(fontSize: 15.0)),
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
                        Text("₹ "+snapshot.data.total.toStringAsFixed(2),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
                Divider(height: 2.0,thickness: 2.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 40.0),
                  child: Container(
                    width: double.infinity,
                    height: 55.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: (){},
                      color: Colors.red,
                      child: Text("ORDER NOW",style: TextStyle(fontSize: 25.0, color: Colors.white,fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

}
