import 'package:flutter/material.dart';
import 'package:neostore/Pages/loginPage.dart';

Color myRed1 = Color(0xffe91c1a);
Color black = Color(0xff7f7f7f);

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: myRed1,
        title: Text("NeoSTORE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30.0),),
        centerTitle: true,
        actions: [
          Icon(Icons.search,color: Colors.white,)
        ],
      ),
      drawer: Drawer(
        child: drawer(),
      ),
      body:Column(
        children: [
          Container(
            height: 228.0,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    return Container(
      color: black,
      child: ListView(
        children :[
        Container(
          child: Column(
            children: [
              SizedBox(height: 35.0,),
              SizedBox(
                height: 83.0,
                width: 83.0,
                child: CircleAvatar(),
              ),
              SizedBox(height: 18.0,),
              Text('Mandar Khandagale',style: TextStyle(fontSize: 23.0,color: Colors.white),),
              SizedBox(height: 13.0,),
              Text('mandarkhandagale08@gmail.com',style: TextStyle(color: Colors.white,fontSize: 13.0,letterSpacing: 1.1),),
              SizedBox(height: 13.0,),
            ],
          ),
        ),
          Divider(thickness: 1.0,),
        ListTile(
              title: Text("My Cart",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.shopping_cart,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Tables",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.deck,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Sofa",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.weekend,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),    ListTile(
              title: Text("Chair",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.event_seat,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Cupboards",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.table_rows,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("My Account",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.person,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Store Locator",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.location_pin,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("My Orders",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.list,color: Colors.white,size: 28.0,),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text("Logout",style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
              leading: Icon(Icons.logout,color: Colors.white,size: 28.0,),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
              },
            ),
            Divider(thickness: 1.0,),
    ]
    ),
    );
  }


}




