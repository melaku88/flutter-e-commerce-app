import 'package:e_commerce/admin/admin-login.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width,100))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle
                            ),
                          child: Container(
                            padding: EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                            ),
                            child: Image.asset('images/logoo.png', height: 60.0, width: 60.0,)
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('E-', style: TextStyle(color: Colors.amber.shade900, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'IndieFlower'),),
                            Text('COMMERCE', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'IndieFlower'),),
                          ],
                        ),
                        SizedBox(height: 30.0,),
                        GestureDetector(
                          onTap: () {
                          showDialog(context: context, 
                            builder: (context)=> AlertDialog(
                              title: Center(child: Text('Login As:', style: AppWidget.blackText20(),)),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminLoginPage())),
                                    child: Text('Admin', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
                                  ),
                                  SizedBox(width: 20.0,),
                                  Container(
                                    width: 2.0,
                                    height: 20.0,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(width: 20.0,),
                                  GestureDetector(
                                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                                    child: Text('User', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                                  ),
                                ],
                              ),
                            )
                          );
                          },
                          child: Container(
                            width: 150.0,
                            margin: EdgeInsets.symmetric(horizontal: 70.0),
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.white, width: 3.0),
                              gradient: LinearGradient(
                                colors: [Colors.green, Colors.grey.shade900],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Login As', style: AppWidget.lightText18()),
                                Icon(Icons.arrow_forward_ios_outlined, size: 22, color: Colors.white,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Image.asset('images/nockdoor.png', width: MediaQuery.of(context).size.width/1, fit: BoxFit.fill,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}