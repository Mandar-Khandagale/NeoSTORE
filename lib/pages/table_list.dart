import 'package:flutter/material.dart';
import 'package:neostore/bloc/product_table_list_bloc.dart';
import 'package:neostore/model_class/product_list_model_class.dart';
import 'package:neostore/pages/product_details_page.dart';
import '../constants.dart';

class ProductTable extends StatefulWidget {
  @override
  _ProductTableState createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  final tableListObj = TableListBloc();
  ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  List<ProductData> dataList = List();

  @override
  void initState() {
    tableListObj.fetchData(pageNumber);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        tableListObj.fetchData(++pageNumber);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tableListObj.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Tables',
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
            Navigator.pop(context,true);
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
      body: Container(
        child: StreamBuilder<ProductList>(
            stream: tableListObj.tableListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dataList.addAll(snapshot.data.data);
                return ListView.builder(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 100.0,
                            child: ListTile(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailPage(id: dataList[index].id, name: dataList[index].name,
                              listImage: dataList[index].productImages,)));
                              },
                              leading: Container(
                                height: 66.0,
                                width: 73.0,
                                child: Image(image: NetworkImage(dataList[index].productImages),fit: BoxFit.fill,),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Text(dataList[index].name,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataList[index].producer,
                                    style: TextStyle(fontSize: 10.0),
                                  ),
                                  SizedBox(height: 16.0,),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Rs." + dataList[index].cost.toString(),
                                        style: TextStyle(fontSize: 20.0, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  productRating(dataList[index].rating),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                            thickness: 2.0,
                          ),
                        ],
                      );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
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
