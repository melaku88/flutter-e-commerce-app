import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/checkout.dart';
import 'package:e_commerce/service/shared-pref.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  String? id;
  int total = 0;

  getId()async{
    id = await SharedPreferanceHelper().getUserId();
    setState(() {});
  }

  void startTimer(){
    Timer(Duration(seconds: 3), () {setState(() {
      
    }); });
  }

  @override
  void initState() {
    getId();
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Column(
              children: [
                Material(
                  elevation: 2.0,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Your Cart', style: AppWidget.blackText24(),)
                  )
                ),
          
                SizedBox(height: 20.0,),
          
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),


                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Users').doc(id).collection('Cart').snapshots(), 
                    builder: (context, snapshot){
                      if(snapshot.hasError){return Center(child: Text('Something Went Wrong!!', style: TextStyle(color: Colors.red),),);}
                      if(snapshot.connectionState == ConnectionState.waiting){return CircularProgressIndicator(color: Colors.green,);}
                      return Column(
                        children: snapshot.data!.docs.map((document){

                          var data = document.data() as Map<String, dynamic>;

                             total += int.parse(data['total']);

                          return  Container(
                            margin: EdgeInsets.only(bottom: 5.0),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(data['quantity'], style: AppWidget.blackText14(),),
                                    ),
                              
                                    SizedBox(width: 20.0,),
                              
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(data['image'], width: 60.0, height: 60.0, fit: BoxFit.fill,)
                                    ),
                                    SizedBox(width: 20.0,),
                                    Column(
                                      children: [
                                        Text(data['name'], style: AppWidget.blackText13(),),
                                        Text('\$'+data['total'], style: AppWidget.blackText14(),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  )

                ),
                Divider(),
                SizedBox(height: 5.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price', style: TextStyle(color: Colors.lightBlue.shade900, fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text('\$${total.toString()}', style: TextStyle(color: Colors.lightBlue.shade900, fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                  },
                  child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Text('Checkout', style: AppWidget.lightText14(),),
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}