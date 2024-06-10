import 'package:e_commerce/components/wallet-lists.dart';
import 'package:e_commerce/pages/checkout.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2.0,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Wallet', style: AppWidget.blackText24(),)
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 30.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                ),
                child: Row(
                  children: [
                    Image.asset('images/wallet.png', height: 60.0, width: 60.0, fit: BoxFit.cover,),

                    SizedBox(width: 40.0,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Wallet', style: AppWidget.blackLightText14(),),
                        SizedBox(height: 5.0,),
                        Text('\$100', style: AppWidget.blackText20())
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Text('Add money', style: AppWidget.blackText16(),),
              ),

              SizedBox(height: 10.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyWallets(text: '\$100'),
                  MyWallets(text: '\$500'),
                  MyWallets(text: '\$1000'),
                  MyWallets(text: '\$2000'),
                ],
              ),

              SizedBox(height: 50.0,),

              GestureDetector(
                onTap:() {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF008080),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Text('Add Money', style: AppWidget.lightText14(),),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}