import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/components/categories.dart';
import 'package:e_commerce/components/column-items.dart';
import 'package:e_commerce/components/row-items.dart';
import 'package:e_commerce/pages/details.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!.email!.split('@')[0];
  // ===================================================================================
  bool bag = true;
  bool dress = false;
  bool watch = false;
  bool phone = false;
  bool fshoe = false;
  bool mshoe = false;
  String activeCategory = 'Bag';

  // ====================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 10.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hellow ${currentUser},', style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 15)),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 20.0,),
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Text('Quality Products', style:AppWidget.blackText24() ),
                Text('Discover and Get Great Products', style: AppWidget.blackLightText13()),
          
                SizedBox(height: 20.0,),
                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                  
                      MyCategoryContainer(
                        onTap: () {
                          bag = true; phone = false; dress = false; watch = false; fshoe=false; mshoe = false; activeCategory = 'Bag';
                          setState(() {});
                        },
                        color: bag ? Colors.grey.shade100 : Colors.grey.shade900,
                        bgColor: bag ? Colors.grey.shade900 : Colors.grey.shade200,
                        category: 'Bag', 
                      ),
                         
                      MyCategoryContainer(
                        onTap: () {
                          bag = false; dress = true; watch = false; phone = false; fshoe=false; mshoe = false; activeCategory = 'Dress';
                          setState(() {});
                        },
                        color: dress ? Colors.grey.shade100 : Colors.grey.shade900,
                        bgColor: dress ? Colors.grey.shade900 : Colors.grey.shade200,
                        category: 'Dress',
                      ),
                                  
                      MyCategoryContainer(
                        onTap: () {
                          bag = false; dress = false; watch = true; phone = false; fshoe=false; mshoe = false; activeCategory = 'Watch';
                          setState(() {});
                        },
                        color: watch ? Colors.grey.shade100 : Colors.grey.shade900,
                        bgColor: watch ? Colors.grey.shade900 : Colors.grey.shade200,
                        category: 'Watch',
                      ),
                         
                      MyCategoryContainer(
                        onTap: () {
                          bag = false; dress = false; watch = false; phone = true; fshoe=false; mshoe = false; activeCategory = 'Phone';
                          setState(() {});
                        },
                        color: phone ? Colors.grey.shade100 : Colors.grey.shade900,
                        bgColor: phone ? Colors.grey.shade900 : Colors.grey.shade200,
                        category: 'Phone',
                      ), 
                         
                      MyCategoryContainer(
                        onTap: () {
                          bag = false; dress = false; watch = false; phone = false; fshoe=true; mshoe = false; activeCategory = 'F-Shoe';
                          setState(() {});
                        },
                        color: fshoe ? Colors.grey.shade100 : Colors.grey.shade900,
                        bgColor: fshoe ? Colors.grey.shade900 : Colors.grey.shade200,
                        category: 'F-Shoe',
                      ),
                         
                      MyCategoryContainer(
                        onTap: () {
                          bag = false; dress = false; watch = false; phone = false; fshoe=false; mshoe = true; activeCategory = 'M-Shoe';
                          setState(() {});
                        },
                        color: mshoe ? Colors.grey.shade100 : Colors.grey.shade900,
                        bgColor: mshoe ? Colors.grey.shade900 : Colors.grey.shade200,
                        category: 'M-Shoe',
                      ),            
                     
                    ],
                  ),
                ),
          
                SizedBox(height: 25.0,),
          
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [

                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection(activeCategory).orderBy('timestamp', descending: true).snapshots(), 
                        builder: (context, snapshot){
                          if(snapshot.hasError){
                            return Center(child: Text('Error happen while feaching data', style: TextStyle(color: Colors.red),),);
                          }
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: Text('Loading....', style: TextStyle(color: Colors.blue),),);
                          }
                          return  Row(
                            children: snapshot.data!.docs.map((documnt) {
                              final data =  documnt.data() as Map<String, dynamic>;
                              return   MyRowItemsContainer(
                                image: data['image'], 
                                itemName: data['name'], 
                                itemDscription: data['detail'],  
                                itemPrice: '\$'+data['price'],
                                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailsPage(
                                  image: data['image'], 
                                  name: data['name'], 
                                  detail: data['detail'],
                                  price: data['price'],
                                ))),
                              );
                            }).toList(),
                          );
                        }
                      )
                    ],
                  ),
                ),
          
                SizedBox(height: 15.0,),

                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(activeCategory).orderBy('timestamp', descending: false).snapshots(), 
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(
                        child: Text('Error happen while faching', style: TextStyle(color: Colors.red),),
                      );
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green,),
                      );
                    }
                    return Column(
                      children: snapshot.data!.docs.map((documents){
                        final data = documents.data() as Map<String, dynamic>;

                        return MyColumnItemsContainer(
                          image: data['image'], 
                          itemName: data['name'], 
                          itemDscription: data['detail'],  
                          itemPrice: '\$'+data['price'],
                          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailsPage(
                            image: data['image'], 
                            name: data['name'], 
                            detail: data['detail'],
                            price: data['price'],
                          ))),
                        );
                      }).toList(),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}