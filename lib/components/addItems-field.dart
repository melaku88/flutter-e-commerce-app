import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCuprtinoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  const MyCuprtinoTextField({
    super.key,
    required this.title,
    required this.controller,
    this.minLines,
    this.maxLines,
    this.keyboardType
    });

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppWidget.blackText14(),),
          SizedBox(height: 2.0,),
          CupertinoTextField(
            controller: controller,
            minLines: minLines,
            maxLines: maxLines,
            keyboardType: keyboardType,
            cursorWidth: 1.3,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(5.0)
            ),
          )
        ],
      ),
    );
  }
}