import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore/Bloc/product_detail_bloc.dart';
import 'package:neostore/bloc/buy_now_bloc.dart';
import 'package:neostore/bloc/set_product_rating_bloc.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/model_class/product_detail_model_class.dart';
import 'package:neostore/model_class/set_rating_model_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailPage extends StatefulWidget {

  int id;
  String name;
  String listImage;
  ProductDetailPage({this.id,this.name,this.listImage});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState(this.id,this.name,this.listImage);
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  int id;
  String name;
  String listImage;
  _ProductDetailPageState(this.id,this.name,this.listImage);

  TextEditingController quantityCon = TextEditingController();
  final productObj = ProductDetailBloc();
  final ratingObj = SetProductRatingBloc();
  final buyObj = BuyNowBloc();
  String image,accessToken;
  int rate;
  var updatedRating;
  int responseStatus;

  @override
  void dispose() {
    productObj.dispose();
    ratingObj.dispose();
    buyObj.dispose();
    quantityCon.dispose();
    super.dispose();
  }

  @override
  void initState() {
    productObj.getProductDetail(id);
    getToken();
    super.initState();
  }

  getToken() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    setState(() {
      accessToken = perf.getString("key4");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
           name,
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: myRed1,
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
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30.0,
          )
        ],
      ),
      body: StreamBuilder<ProductDetails>(
          stream: productObj.productDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductImages> imageList = snapshot.data.data.productImages;
               rate = snapshot.data.data.rating;
                    return SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 13.0, right: 13.0, top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      snapshot.data.data.name,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Text("Category - Tables", style: TextStyle(fontSize: 16.0, color: Colors.black),),
                                    SizedBox(height: 10.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data.data.producer, style: TextStyle(fontSize: 10.0, color: Colors.black),),
                                        productRating(snapshot.data.data.rating),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 13.0, right: 13.0, top: 16.0, bottom: 16.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10.0, right: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rs."+ snapshot.data.data.cost.toString(),
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.red),
                                              ),
                                              Icon(
                                                Icons.share,
                                                size: 25.0,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 257,
                                          height: 178,
                                          child: Image.network(image != null ? image : listImage,),
                                        ),
                                        SizedBox(height: 6.0,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Container(
                                            height: 70.0,
                                            child: ListView.builder(
                                                itemCount: imageList.length,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index){
                                              return Row(
                                                children: [
                                                  Container(
                                                    child: InkWell(child: Image.network(imageList[index].image,),
                                                    onTap: (){centerImage(imageList[index].image);},
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                        SizedBox(height: 35.0,),
                                        Divider(thickness: 2.0,),
                                        Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Description",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 10.0),
                                                Text(
                                                  snapshot.data.data.description,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 13.0, right: 13.0, top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 150.0,
                                      height: 55.0,
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: BorderSide(color: Colors.white)),
                                        onPressed: () {
                                          buyNowScreen(context);
                                        },
                                        color: Colors.red,
                                        child: Text("BUY NOW",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      width: 150.0,
                                      height: 55.0,
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: BorderSide(color: Colors.white)),
                                        onPressed: () {
                                          setProductRating(context);
                                        },
                                        color: grey,
                                        child: Text("RATE",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: greyText,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
  centerImage(String ig){
    setState(() {
      image = ig;
    });
  }

  productRating(int rating) {
    switch (rating) {
      case 1:
        {
          return Container(
            width: 60,
            height: 11,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
              ],
            ),
          );
        }
        break;
      case 2:
        {
          return Container(
            width: 60,
            height: 11,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
              ],
            ),
          );
        }
        break;
      case 3:
        {
          return Container(
            width: 60,
            height: 11,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
              ],
            ),
          );
        }
        break;
      case 4:
        {
          return Container(
            width: 60,
            height: 11,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: 12.0,
                ),
              ],
            ),
          );
        }
        break;
      case 5:
        {
          return Container(
            width: 60,
            height: 11,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12.0,
                ),
              ],
            ),
          );
        }
    }
  }

  setProductRating(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(name,style: TextStyle(fontSize: 25),)),
            content:  Container(
              height: 300,
              child: Column(
                children: [
                  Image.network(listImage),
                  SizedBox(height: 10.0,),
                  RatingBar.builder(
                    initialRating: rate.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, i) => Icon(Icons.star, color: Colors.amber,size: 44,),
                    onRatingUpdate: (rating) {
                      print(rating);
                      updatedRating = rating.toString();
                    },),
                  SizedBox(height: 10.0,),
                  Container(
                    width: double.infinity,
                    height: 55.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                        ratingObj.setRating(id,updatedRating);
                      },
                      color: Colors.red,
                      child: Text("RATE NOW", style: TextStyle(fontSize: 20.0, color: Colors.white,)),
                    ),
                  ),
                  StreamBuilder<SetRating>(
                    stream: ratingObj.setRatingStream,
                    builder: (context, snapshot){
                      if(snapshot.data != null){
                        Fluttertoast.showToast(
                            msg: snapshot.data.userMsg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black
                        );
                        if(ratingObj.responseStatus == 200){
                          Future.delayed(Duration(seconds: 2), (){
                            Navigator.pop(context);
                          });
                        }
                      }
                      return Container();
                    },),
                ],
              ),
            ),
          );
        });
  }

   buyNowScreen(BuildContext context) {
     showDialog(
         context: context,
         builder: (context) {
           return SingleChildScrollView(
             child: AlertDialog(
               title: Center(child: Text(name,style: TextStyle(fontSize: 25),)),
               content:  Container(
                 height: 320,
                 child: Column(
                   children: [
                     Container(
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.black)
                       ),
                         child: Image.network(listImage)),
                     SizedBox(height: 10.0,),
                     Text("Enter Qty",style: TextStyle(fontSize: 25),),
                     SizedBox(height: 10.0,),
                     TextFormField(
                       controller: quantityCon,
                     ),
                     SizedBox(height: 10.0,),
                     Container(
                       width: 198.0,
                       height: 47.0,
                       child: FlatButton(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10.0),
                             side: BorderSide(color: Colors.white)),
                         onPressed: () {
                           final String qua = quantityCon.text;
                           buyObj.buyNow(id, qua, accessToken);
                         },
                         color: Colors.red,
                         child: Text("SUBMIT", style: TextStyle(fontSize: 20.0, color: Colors.white,)),
                       ),
                     ),
                     StreamBuilder<String>(
                       stream: buyObj.buyNowStream,
                       builder: (context, snapshot){
                         if(snapshot.data != null){
                           Fluttertoast.showToast(
                               msg: snapshot.data,
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.BOTTOM,
                               backgroundColor: Colors.white,
                               textColor: Colors.black
                           );
                           if(buyObj.responseStatus == 200){
                             Future.delayed(Duration(seconds: 2), (){
                               Navigator.pop(context);
                             });
                           }
                         }
                         return Container();
                       },),
                   ],
                 ),
               ),
             ),
           );
         });
   }
}