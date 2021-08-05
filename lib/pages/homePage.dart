import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neostore/Pages/account_details.dart';
import 'package:neostore/Pages/loginPage.dart';
import 'package:neostore/bloc/my_cart_bloc.dart';
import 'package:neostore/pages/my_cart_page.dart';
import 'package:neostore/pages/my_order_page.dart';
import 'package:neostore/pages/store_locator_page.dart';
import 'package:neostore/pages/table_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';





class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}



class _HomePageScreenState extends State<HomePageScreen> {

  final drawerObj = MyCartBloc();
  String firstName, lastName, email,accessToken,profilePic;
  int count = 0;


 @override
  void initState() {
     getData();
    super.initState();
  }

  getData() async{
    SharedPreferences perf =  await SharedPreferences.getInstance();
    setState(() {
      firstName= perf.getString("firstName");
      lastName= perf.getString("lastName");
      email= perf.getString("email");
      profilePic = perf.getString("profilePic");
      accessToken = perf.getString("accessToken");
    });
    print("adbadb:- $accessToken");
    /// Stream Listener
    drawerObj.myCartStream.listen((myCart) {
      if(myCart.data != null){
        setState(() {
          count = myCart.data.length;
          print("Mandar Count here:- $count");
        });
      }
      else{
        setState(() {
          count = 0;
          print("Mandar Count here null:- $count");
        });
      }
    });
    drawerObj.getCart(accessToken);

  }
  getRefresh() async{
   getData();
  }

  @override
  void dispose() {
    drawerObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height-kToolbarHeight-kBottomNavigationBarHeight;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text("NeoSTORE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30.0),),
        centerTitle: true,
        // actions: [
        //   Icon(Icons.search,color: Colors.white,size: 30.0,)
        // ],
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
                  Image.asset("assets/table1.jpg",fit: BoxFit.cover,),
                  Image.asset("assets/chair1.jpg",fit: BoxFit.cover,),
                  Image.asset("assets/cupboards1.jpg",fit: BoxFit.cover,),
                  Image.asset("assets/sofa1.jpg",fit: BoxFit.cover,),
                ],
              ),
            ),
            SizedBox(height: 13.0,),
            Expanded(
              child: Container(
                height: itemHeight * 0.6,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  children:[
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductTable())).then((value) => value ? getRefresh() : null)  ;
                      },
                      child: Container(
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
                                  children: [
                                    Image.asset('assets/table.png',fit: BoxFit.fill,),
                                  //  Image.asset("assets/ic_table.png",width: 95.0,height: 95.0,fit: BoxFit.fill,)
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
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
                                 Image.asset('assets/sofa.png',fit: BoxFit.fill,),
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
                                  Image.asset('assets/chair.png',fit: BoxFit.fill,),
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
                                    Image.asset('assets/cupboard.png',fit: BoxFit.fill,),
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
                            shape: BoxShape.circle,
                            // image: DecorationImage(image: profilePic != null ? NetworkImage(profilePic):NetworkImage('https://www.pngitem.com/pimgs/m/4-40070_user-staff-man-profile-user-account-icon-jpg.png'),
                            //     fit:BoxFit.fill ),
                          ),
                          child: profilePic != null ?
                          Container(decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image:NetworkImage(profilePic),fit: BoxFit.fill),),):
                          Container(child: Center(child: Text(firstName != null ? firstName[0]+lastName[0] : "",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),),),),
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
              title: Text("My Cart", style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),),
              leading: Icon(Icons.shopping_cart, color: Colors.white, size: 28.0,),
              trailing: count != 0 ? Container(height: 30.0, width: 30.0,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Center(child: Text(count.toString(),style: TextStyle(color: Colors.white,fontSize: 15.0),),),
                    ) : Text(""),
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyCartPage()))
                    .then((value) => value ? getRefresh() : null);
              },
            ),
                Divider(thickness: 1.0,),
                ListTile(
                  title: Text("Tables",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
                  leading:  Container(width: 28.0,height: 28.0,
                      child: Image.asset('assets/table.png')),
                  onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductTable())).then((value) => value ? getRefresh() : null);
                    },
                ),
                Divider(thickness: 1.0,),
                ListTile(
                  title: Text("Sofa",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
                  leading:Container(width: 28.0,height: 28.0,
                      child: Image.asset('assets/sofa.png')),
                ),
                Divider(thickness: 1.0,),    ListTile(
                  title: Text("Chair",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
                leading: Container(width: 28.0,height: 28.0,
                    child: Image.asset('assets/chair.png')),
                ),
                Divider(thickness: 1.0,),
                ListTile(
                  title: Text("Cupboards",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
                  leading: Container(width: 28.0,height: 28.0,
                      child: Image.asset('assets/cupboard.png')),
                ),
                Divider(thickness: 1.0,),
                ListTile(
                  title: Text("My Account",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
                  leading: Icon(Icons.person,color: Colors.white,size: 28.0,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountDetails())).then((value) => value ? getRefresh() : null);
                  },
                ),
                Divider(thickness: 1.0,),
                ListTile(
                  title: Text("Store Locator",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
                  leading: Icon(Icons.location_pin,color: Colors.white,size: 28.0,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreLocatorPage()));
                  },
                ),
                Divider(thickness: 1.0,),
                ListTile(
                  title: Text("My Orders",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w500),),
                  leading: Icon(Icons.list,color: Colors.white,size: 28.0,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrderPage()));
                  },
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





