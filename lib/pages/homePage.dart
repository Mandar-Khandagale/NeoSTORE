import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:neostore/Bloc/login_bloc.dart';
import 'package:neostore/Pages/account_details.dart';
import 'package:neostore/Pages/loginPage.dart';
import 'package:neostore/Pages/table_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';





class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}



class _HomePageScreenState extends State<HomePageScreen> {

  String firstName, lastName, email,accessToken,profilePic;
 final drawerObj = LoginBloc();


 @override
  void initState() {
     getData();
    super.initState();
  }

  getData() async{
    SharedPreferences perf =  await SharedPreferences.getInstance();
    setState(() {
      firstName= perf.getString("key1");
      lastName= perf.getString("key2");
      email= perf.getString("key3");
      profilePic = perf.getString("key7");
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height-kToolbarHeight-kBottomNavigationBarHeight;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text("NeoSTORE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30.0),),
        centerTitle: true,
        actions: [
          Icon(Icons.search,color: Colors.white,size: 30.0,)
        ],
      ),
      drawer: Drawer(
        child: drawer(),
      ),
      body:Container(
        child: Column(
          children: [
            Container(
              height: itemHeight * 0.4,
              child: Carousel(
                dotColor: Colors.red,
                dotBgColor: Colors.transparent,
                dotSize: 4.0,
                images: [
                  Image.asset("assets/table.jpeg",fit: BoxFit.cover,),
                  Image.asset("assets/chairs.jpg",fit: BoxFit.cover,),
                  Image.asset("assets/cupboards1.jpeg",fit: BoxFit.cover,),
                  Image.asset("assets/sofa.jpg",fit: BoxFit.cover,),
                ],
              ),
            ),
            SizedBox(height: 13.0,),
            Expanded(
              child: Container(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  children:[
                    Container(
                        margin: EdgeInsets.fromLTRB(13, 11,5.5,5.5),
                      color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Tables",style: TextStyle(fontSize: 23.0,color: Colors.white,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Icon(Icons.deck,size: 85.0,color: Colors.white,),
                                //  Image.asset("assets/ic_table.png",width: 95.0,height: 95.0,fit: BoxFit.fill,)
                                ],
                              ),
                            ],
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(5.5, 11, 13,5.5),
                      color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.weekend,size: 85.0,color: Colors.white,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Sofas",style: TextStyle(fontSize: 23.0,color: Colors.white,fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                    Container(
                        margin: EdgeInsets.fromLTRB(13.0, 5.5, 5.5, 15),
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Chairs",style: TextStyle(fontSize: 23.0,color: Colors.white,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.event_seat,size: 85.0,color: Colors.white,),
                                ],
                              ),
                            ],
                          ),
                        )),
                      Container(
                        margin: EdgeInsets.fromLTRB(5.5, 5.5, 13, 15),
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.table_rows,size: 85.0,color: Colors.white,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Cupboards",style: TextStyle(fontSize: 23.0,color: Colors.white,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Container(
      color: black,
      child: ListView(
        children :[
        Container(
          child:Column(
                  children: [
                    SizedBox(height: 35.0,),
                    Container(
                      height: 83.0,
                      width: 83.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(height: 18.0,),
                    RichText(
                      text: TextSpan(text : firstName != null ? firstName.toUpperCase() : " ",style: TextStyle(color: Colors.white, fontSize: 23.0,),
                      children:[ TextSpan(text: " "),
                        TextSpan(text : lastName != null ? lastName.toUpperCase() : " ",style: TextStyle(color: Colors.white, fontSize: 23.0),)]
                      ),
                    ),
                    SizedBox(height: 13.0,),
                    Text(email != null ? email : " ", style: TextStyle(color: Colors.white, fontSize: 13.0,
                        ),),
                    SizedBox(height: 13.0,),
                  ],
                ),
          ),
        Divider(thickness: 1.0,),
        ListTile(
              title: Text("My Cart",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.shopping_cart,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Tables",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.deck,color: Colors.white,size: 28.0,),
              onTap:(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductTable()));},
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Sofa",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.weekend,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),    ListTile(
              title: Text("Chair",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
            leading: Icon(Icons.event_seat,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Cupboards",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.table_rows,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("My Account",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.person,color: Colors.white,size: 28.0,),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AccountDetails()));
              },
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Store Locator",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.location_pin,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("My Orders",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.list,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Logout",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
              leading: Icon(Icons.logout,color: Colors.white,size: 28.0,),
              onTap: () async {
               // Navigator.of(context).pop();
                SharedPreferences loginData = await SharedPreferences.getInstance();
                loginData.remove("login");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
            ),
            Divider(thickness: 1.0,),
    ]
    ),
    );
  }


}





