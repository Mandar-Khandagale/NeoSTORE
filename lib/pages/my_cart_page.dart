import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore/bloc/delete_cart_items_bloc.dart';
import 'package:neostore/bloc/edit_cart_items_bloc.dart';
import 'package:neostore/bloc/my_cart_bloc.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/model_class/edit_cart_model_class.dart';
import 'package:neostore/model_class/my_cart_model_class.dart';
import 'package:neostore/pages/add_address_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';




class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {

  final myCartObj = MyCartBloc();
  final editCartObj = EditCartBloc();
  final deleteCartObj = DeleteCartItems();
  String accessToken;
  List<Data> cartList = List();


  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      accessToken = perf.getString("accessToken");
    });
      print("bbks:- $accessToken");
    myCartObj.getCart(accessToken);
  }
  @override
  void dispose() {
    myCartObj.dispose();
    editCartObj.dispose();
    deleteCartObj.dispose();
    super.dispose();
  }

  getRefresh() async{
    getToken();
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
            Navigator.pop(context,true);
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
            if(snapshot.data.data == null){
              return Center(child:  Image(image: NetworkImage("https://professionalscareer.com/assets/images/emptycart.png")),
                //Text(snapshot.data.userMsg,style: TextStyle(fontSize: 30.0,)),
             );
            }
            else{
              cartList.addAll(snapshot.data.data);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: cartList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                secondaryActions: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle
                                      ),
                                      child: IconButton(
                                          icon: Icon(Icons.delete,color: Colors.white,),
                                          onPressed:(){
                                            deleteCartObj.deleteCart(cartList[index].productId.toString(), accessToken);
                                            cartList.clear();
                                            Future.delayed(Duration(milliseconds: 500), (){
                                              myCartObj.getCart(accessToken);
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                                child: Container(
                                  height: 100.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                                    child: ListTile(
                                      isThreeLine: true,
                                      leading: Container(
                                        height: 73.0, width: 66.0,
                                        child: Image(image: NetworkImage(cartList[index].product.productImages),fit: BoxFit.fill,),
                                      ),
                                      title: Text(cartList[index].product.name, style: TextStyle(fontSize: 15.0,),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.0,),
                                          Text("(${cartList[index].product.productCategory})"),
                                          SizedBox(height: 5.0,),
                                          Container(
                                            height: 23.0,width: 40.0,
                                            decoration: BoxDecoration(
                                                color: grey,
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child:
                                              DropdownButton<String>(
                                                value: cartList[index].quantity.toString(),
                                                icon: Icon(Icons.keyboard_arrow_down),
                                                hint: Text(cartList[index].quantity.toString()),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                      value: "1", child: Text('1')),
                                                  DropdownMenuItem<String>(
                                                      value: "2", child: Text('2')),
                                                  DropdownMenuItem<String>(
                                                      value: "3", child: Text('3')),
                                                  DropdownMenuItem<String>(
                                                      value: "4", child: Text('4')),
                                                  DropdownMenuItem<String>(
                                                      value: "5", child: Text('5')),
                                                  DropdownMenuItem<String>(
                                                      value: "6", child: Text('6')),
                                                  DropdownMenuItem<String>(
                                                      value: "7", child: Text('7')),
                                                  DropdownMenuItem<String>(
                                                      value: "8", child: Text('8')),
                                                ],
                                                onChanged: (val) {
                                                  editCartObj.editCart(val, cartList[index].productId.toString(), accessToken);
                                                  cartList.removeRange(0,cartList.length);
                                                  Future.delayed(Duration(milliseconds: 500), (){
                                                  myCartObj.getCart(accessToken);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          StreamBuilder<EditCartModel>(
                                              stream: editCartObj.editCartStream,
                                              builder: (context, snapshot){
                                                if(snapshot.data != null){
                                                  Fluttertoast.showToast(
                                                      msg: snapshot.data.userMsg,
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      backgroundColor: Colors.white,
                                                      textColor: Colors.black
                                                  );
                                                } return Container();
                                              }),
                                          StreamBuilder<EditCartModel>(
                                              stream: deleteCartObj.deleteCartStream,
                                              builder: (context, snapshot){
                                                if(snapshot.data != null){
                                                    Fluttertoast.showToast(
                                                      msg: snapshot.data.userMsg,
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      backgroundColor: Colors.white,
                                                      textColor: Colors.black,
                                                    );
                                                } return Container();
                                              }),
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
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressPage())).then((value) => value ? getRefresh() : null);
                          },
                          color: Colors.red,
                          child: Text("ORDER NOW",style: TextStyle(fontSize: 25.0, color: Colors.white,fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                  ],
                ),
              );
            }
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }



}
