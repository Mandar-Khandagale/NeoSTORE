import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore/bloc/add_address_bloc.dart';
import 'package:neostore/constants.dart';
import 'package:neostore/model_class/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  final formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  String accessToken;
  bool isLoading = false;
  final addAddressObj = AddAddressBloc();

  getToken() async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    accessToken = perf.getString("accessToken");
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }
  @override
  void dispose() {
    addAddressObj.dispose();
    addressController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: myRed1,
          title: Text("Add Address",style: TextStyle(fontSize: 25.0),),
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
        ),
        backgroundColor: Colors.grey[300],
         body: SingleChildScrollView(
           child: Container(
             child: Form(
               key: formKey,
               autovalidateMode: AutovalidateMode.onUserInteraction,
               child: Padding(
                 padding: const EdgeInsets.only(left:15.0, right:15.0, top: 30.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("ADDRESS",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
                     Padding(
                       padding: const EdgeInsets.only(top:10.0,bottom: 26.0),
                       child: TextFormField(
                         controller: addressController,
                         maxLines: 5,
                         decoration: InputDecoration(
                           fillColor: Colors.white,filled: true,
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.white),),
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.white),),
                           errorBorder:OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.white,),),
                           focusedErrorBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.white,),),
                           errorStyle: TextStyle(color: Colors.red),
                         ),
                         validator: (val){
                           if(val.isEmpty){
                             return "Required";
                           }else{
                             return null;
                           }
                         },
                       ),
                     ),
                     Text("LANDMARK",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
                     Padding(
                       padding: const EdgeInsets.only(top:16.0,bottom: 26.0),
                       child: Container(
                         height: 40.0,
                         child: TextFormField(
                           controller: landmarkController,
                           decoration: InputDecoration(
                             fillColor: Colors.white,filled: true,
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white),),
                             enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white),),
                             errorBorder:OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             focusedErrorBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: Colors.white,),),
                             errorStyle: TextStyle(color: Colors.red),
                           ),
                         ),
                       ),
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("CITY",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
                             Padding(
                               padding: const EdgeInsets.only(top:16.0,bottom: 26.0),
                               child: Container(
                                 height: 40.0,
                                 width: 150.0,
                                 child: TextFormField(
                                   controller: cityController,
                                   decoration: InputDecoration(
                                     fillColor: Colors.white,filled: true,
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     errorBorder:OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     focusedErrorBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     errorStyle: TextStyle(color: Colors.red),
                                   ),
                                 ),
                               ),
                             ),
                             Text("ZIP CODE",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
                             Padding(
                               padding: const EdgeInsets.only(top:16.0,bottom: 26.0),
                               child: Container(
                                 height: 40.0,
                                 width: 150.0,
                                 child: TextFormField(
                                   controller: zipCodeController,
                                   decoration: InputDecoration(
                                     fillColor: Colors.white,filled: true,
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     errorBorder:OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     focusedErrorBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     errorStyle: TextStyle(color: Colors.red),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("STATE",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
                             Padding(
                               padding: const EdgeInsets.only(top:16.0,bottom: 26.0),
                               child: Container(
                                 height: 40.0,
                                 width: 150.0,
                                 child: TextFormField(
                                   controller: stateController,
                                   decoration: InputDecoration(
                                     fillColor: Colors.white,filled: true,
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     errorBorder:OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     focusedErrorBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     errorStyle: TextStyle(color: Colors.red),
                                   ),
                                 ),
                               ),
                             ),
                             Text("COUNTRY",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
                             Padding(
                               padding: const EdgeInsets.only(top:16.0,bottom: 26.0),
                               child: Container(
                                 height: 40.0,
                                 width: 150.0,
                                 child: TextFormField(
                                   controller: countryController,
                                   decoration: InputDecoration(
                                     fillColor: Colors.white,filled: true,
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white),),
                                     errorBorder:OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     focusedErrorBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.white,),),
                                     errorStyle: TextStyle(color: Colors.red),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top:26.0),
                       child: isLoading == false ? Container(
                         width: double.infinity,
                         height: 55.0,
                         child: FlatButton(
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10.0),
                               side: BorderSide(color: Colors.red)),
                           onPressed: (){
                             if(formKey.currentState.validate()){
                               setState(() {
                                 isLoading = true;
                               });
                               final String address = addressController.text;
                               addAddressObj.addAddress(accessToken, address);
                             }
                           },
                           color: Colors.red,
                           child: Text("PLACE ORDER",style: TextStyle(fontSize: 25.0, color: Colors.white,fontWeight: FontWeight.w400)),
                         ),
                       ) : CircularProgressIndicator(),
                     ),
                     StreamBuilder<SuccessModel>(
                       stream: addAddressObj.addAddressStream,
                       builder: (context, snapshot){
                         if(snapshot.data != null){
                           Fluttertoast.showToast(
                               msg: snapshot.data.userMsg,
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.BOTTOM,
                               backgroundColor: Colors.red,
                               textColor: Colors.white
                           );
                           if(addAddressObj.responseStatus == 200){
                             isLoading = false;
                             Future.delayed(Duration(seconds: 1), (){
                               Navigator.pop(context,true);
                             });
                           }
                         }
                         return Container();
                       },),
                   ],
                 ),
               ),
             ),
           ),
         ),
      ),
    );
  }

  Future<bool> _onWillPop() {
  Navigator.pop(context,true);
  return null;
  }
}
