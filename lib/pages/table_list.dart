import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  List<ProductData> filterTables = List();
  bool isSearching = false;

  @override
  void initState() {
    tableListObj.fetchData(pageNumber);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(tableListObj.responseStatus == 200){
          tableListObj.fetchData(++pageNumber);
        }else{
          Fluttertoast.showToast(
              msg: 'Reached Last item',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
      }
    });
    tableListObj.tableListStream.listen((event) {
      if(event.data !=  null){
        setState(() {
          dataList.addAll(event.data);
          filterTables = dataList;
        });
      }else{
        Center(child: CircularProgressIndicator(),);
      }
    });
    super.initState();
  }

  void filterTableList(value){
    setState(() {
      filterTables = dataList.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void dispose() {
    tableListObj.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: isSearching == false ? Text('Tables', style: TextStyle(fontSize: 25.0),) :
          Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: TextField(
              onChanged: (value){
                filterTableList(value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,color: Colors.white,),
              hintText: "Search Tables Here",hintStyle: TextStyle(color: Colors.white),
            ),),
          ),
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
          actions: [ isSearching == true ?
          IconButton(
              icon: Icon(Icons.cancel,size: 30.0,),
              onPressed: (){
                setState(() {
                  isSearching = false;
                  filterTables = dataList;
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
        body: Container(
          child: ListView.builder(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            itemCount: filterTables.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 100.0,
                    child: ListTile(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailPage(id: filterTables[index].id, name: filterTables[index].name,
                          listImage: filterTables[index].productImages,)));
                      },
                      leading: Container(
                        height: 66.0,
                        width: 73.0,
                        child: Image(image: NetworkImage(filterTables[index].productImages),fit: BoxFit.fill,),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(filterTables[index].name,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filterTables[index].producer,
                            style: TextStyle(fontSize: 10.0),
                          ),
                          SizedBox(height: 16.0,),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rs." + filterTables[index].cost.toString(),
                                style: TextStyle(fontSize: 20.0, color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          productRating(filterTables[index].rating),
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
          ),
        ),
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
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
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
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
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
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
                Icon(Icons.star, color: Colors.grey,size: 12.0,),
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
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.grey, size: 12.0,),
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
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
                Icon(Icons.star, color: Colors.amber, size: 12.0,),
              ],
            ),
          );
        }
    }
  }

  Future<bool> _onWillPop() {
  Navigator.pop(context, true);
  }
}
