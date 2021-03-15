import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neostore/Bloc/product_detail_bloc.dart';
import 'package:neostore/Model_Class/product_detail_model_class.dart';
import 'package:neostore/constants.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final productObj = ProductDetailBloc();

  @override
  void dispose() {
    productObj.dispose();
    super.dispose();
  }

  @override
  void initState() {
    productObj.getProductDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
           "Centre Coffee Table",
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
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index){
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data.data.producer,
                                          style: TextStyle(
                                              fontSize: 10.0, color: Colors.black),
                                        ),
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
                                          child: Image(image: NetworkImage(imageList[0].image),fit: BoxFit.fill,),
                                        ),
                                        SizedBox(
                                          height: 6.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 78.0,
                                                height: 69.0,
                                                child: Image(image: NetworkImage(imageList[0].image),fit: BoxFit.fill,),
                                              ),
                                              Container(
                                                width: 78.0,
                                                height: 69.0,
                                                child: Image(image: NetworkImage(imageList[1].image),fit: BoxFit.fill,),
                                              ),
                                              Container(
                                                width: 78.0,
                                                height: 69.0,
                                                child: Image.network("https://www.ikea.com/in/en/images/products/ekedalen-extendable-table-dark-brown__0736963_pe740827_s5.jpg?f=xxs"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 35.0,),
                                        Divider(thickness: 2.0,),
                                        Container(
                                          width: double.infinity,
                                          height: 150,
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
                                        onPressed: () {},
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
                                        onPressed: () {},
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
              });
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
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

}
