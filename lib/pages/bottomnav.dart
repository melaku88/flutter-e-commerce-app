import 'package:e_commerce/pages/home.dart';
import 'package:e_commerce/pages/order.dart';
import 'package:e_commerce/pages/profile.dart';
import 'package:e_commerce/pages/wallet.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
// ==========================================================================================================
  int currentTapIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePage home;
  late ProfilePage profile;
  late OrderPage order;
  late WalletPage wallet;

  @override
  void initState() {
    home = HomePage();
    order = OrderPage();
    wallet = WalletPage();
    profile = ProfilePage();
    pages = [home, order, wallet, profile];
    super.initState();
  }
// ==========================================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 48.0,
        color: Colors.grey.shade900,
        buttonBackgroundColor: Colors.grey.shade800,
        backgroundColor: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        animationCurve: Curves.linear,
        onTap: (int index) {
          setState(() {
            currentTapIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.grey.shade200, size: 18.0,),
          Icon(Icons.shopping_bag_outlined, color: Colors.grey.shade200, size: 18.0,),
          Icon(Icons.wallet_outlined, color: Colors.grey.shade200, size: 18.0,),
          Icon(Icons.person_outlined, color: Colors.grey.shade200, size: 18.0,),
        ],
      ),
      body: pages[currentTapIndex],
    );
  }
}