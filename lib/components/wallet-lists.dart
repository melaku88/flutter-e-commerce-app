import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

class MyWallets extends StatelessWidget {
  final String text;
  const MyWallets({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE9E2E2)),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Text(text, style: AppWidget.blackText16()),
    );
  }
}