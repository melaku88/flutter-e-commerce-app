import 'package:e_commerce/pages/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavPage()));
          },
          child: Icon(Icons.arrow_back_ios_new_outlined)
        ),
      ),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SpinKitThreeBounce(itemBuilder:(context, index) => DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(20.0)
            )
            ),
          ),
        ),
      ),
    );
  }
}