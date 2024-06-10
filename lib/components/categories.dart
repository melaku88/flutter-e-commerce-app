import 'package:flutter/material.dart';

class MyCategoryContainer extends StatelessWidget {
  final String category;
  final Color? color;
   final Color? bgColor;
  final void Function()? onTap;
  const MyCategoryContainer({
    super.key, 
    required this.category, 
    this.color, 
    this.onTap,
    this.bgColor
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 5.0, left: 5.0, top: 2.0, bottom: 2.0),
        child: Material(
          elevation: 1.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Text(category, 
              style: TextStyle(color: color, fontSize: 13.0, fontWeight: FontWeight.bold)
            ),
          ),
        ),
      ),
    );
  }
}