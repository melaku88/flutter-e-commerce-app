import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyRowItemsContainer extends StatelessWidget {
  final String image;
  final String itemName;
  final String itemDscription;
  final String itemPrice;
  final void Function()? onTap;
  const MyRowItemsContainer({
    super.key,
    required this.image,
    required this.itemName,
    required this.itemDscription,
    required this.itemPrice,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 15.0, top: 2.0, bottom: 7.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 220.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(image, height: 130, width: 130, fit: BoxFit.cover,),
                SizedBox(height: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemName, style: AppWidget.blackText14(),),
                    SizedBox(height: 5.0,),
                    Text(itemDscription, style: TextStyle(color: Colors.black38, fontSize: 13, overflow: TextOverflow.ellipsis)),
                    SizedBox(height: 5.0,),
                    Text(itemPrice, style: AppWidget.blackText14(),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}