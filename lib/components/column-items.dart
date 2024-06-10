import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyColumnItemsContainer extends StatelessWidget {
  final String image;
  final String itemName;
  final String itemDscription;
  final String itemPrice;
  final void Function()? onTap;
  const MyColumnItemsContainer({
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
        margin: EdgeInsets.only(left: 0.0, right: 10.0, top: 2.0, bottom: 20.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(image, height: 110, width: 110, fit: BoxFit.cover,),
                SizedBox(width: 15.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(itemName, style: AppWidget.blackText14(),)
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(itemDscription, style: AppWidget.blackLightText13())
                    ),
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