import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/bottomnav.dart';
import 'package:e_commerce/service/shared-pref.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsPage extends StatefulWidget {
  final String image, name, detail, price;
  const DetailsPage({
    super.key, required this.image, required this.name, required this.detail, required this.price });
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // ================================================================================================
  int i = 1;
  int total = 0;
  String? id;

  getSharedId()async{
    id = await SharedPreferanceHelper().getUserId();
    setState(() {});
  }

  @override
  void initState() {
    total = int.parse(widget.price);
    getSharedId();
    super.initState();
  }

  void increament(){
    setState(() {
      i++;
     total+=int.parse(widget.price);
    });
  }

  void decreament(){
    setState(() {
      if(i > 1){
        i--;
        total-=int.parse(widget.price);
      }
    });
  }

  // Add to cart

  void addToCart() async{
    showDialog(
      context: context, 
      builder: (context)=>Center(
        child: CircularProgressIndicator(color: Colors.green,),
      )
    );

    await FirebaseFirestore.instance.collection('Users').doc(id!).collection('Cart').add({
      'name': widget.name,
      'quantity': i.toString(),
      'total': total.toString(),
      'image': widget.image
    }).then((value){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text('Th item added to the cart successfully!', style: TextStyle(color: Colors.white),)
      ));
    });
  }
  // ================================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavPage())),
                child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,)
              ),
              Container(
                alignment: Alignment.center,
                child: Image.network(widget.image,
                  width: MediaQuery.of(context).size.width/1.3,
                  height: MediaQuery.of(context).size.height/2.3,
                  fit: BoxFit.fill,
                ),
              ),
        
              SizedBox(height: 10.0,),
        
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name, style: AppWidget.blackText14(),),
                    ],
                  ),
        
                  Spacer(),
        
                  GestureDetector(
                    onTap: decreament,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(7)),
                      child: Icon(Icons.remove, color: Colors.grey.shade200, size: 20.0,),
                    ),
                  ),
                  SizedBox(width: 20.0,),
        
                  Text(i.toString(), style: AppWidget.blackText16()),
        
                  SizedBox(width: 20.0,),
                  GestureDetector(
                    onTap: increament,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(7)),
                      child: Icon(Icons.add, color: Colors.grey.shade200, size: 20.0,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              
              Text(widget.detail,
                style: AppWidget.blackLightText13(),
              ),

              SizedBox(height: 20.0,),

              Row(
                children: [
                  Text('Delivery Time', style: AppWidget.blackText13(),),
                  SizedBox(width: 50.0,),
                  Icon(Icons.alarm, color: Colors.black54, size: 20.0,),
                  SizedBox(width: 3.0,),
                  Text('30 min', style: AppWidget.blackText13(),)
                ],
              ),

              SizedBox(height: 50.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Price', style: AppWidget.blackText14(),),
                      Text('\$${total.toString()}', style: AppWidget.blackText18(),)
                    ],
                  ),
                  GestureDetector(
                    onTap: addToCart,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Row(
                        children: [
                          Text('Add to cart', style: AppWidget.lightText13()),
                          SizedBox(width: 30.0,),
                          Icon(Icons.shopping_cart_outlined, color: Colors.grey.shade200, size: 20.0,)
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}