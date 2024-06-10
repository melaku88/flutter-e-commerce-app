import 'package:e_commerce/admin/add-product.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_new_outlined, size: 22.0,)
                    ),
                    SizedBox(width: 50.0,),
                    Text('Home Admin', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),

              SizedBox(height: 30.0,),

              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage())),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Row(
                        children: [
                          Image.asset('images/add-cart.png', height: 70.0, width: 70.0,),
                            
                          SizedBox(width: 30.0,),
                            
                          Text('Add Shop Items', style: AppWidget.lightText16(),)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}