import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/bottomnav.dart';
import 'package:e_commerce/service/shared-pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class DatabaseService{

  // registeration
  Future registerUser(String username, String email, String password, String confirmPassword, BuildContext context) async{
    if(password == confirmPassword){
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );

        String id = randomAlphaNumeric(10);
        await FirebaseFirestore.instance.collection('Users').doc(id).set({
          'id': id,
          'username': username,
          'email': email,
          'wallet': '0',
        });

        await SharedPreferanceHelper().saveUserId(id);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade800,
          content: Center(child: Text('Registered Successfully!', style: TextStyle(color: Colors.white),))
          )
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavPage()));

      } on FirebaseAuthException catch (e) {
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange.shade400,
            content: Center(child: Text('Password provided is too weak, try to make strong!', style: TextStyle(color: Colors.white),))
           )
          );
        }else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange.shade400,
            content: Center(child: Text('This email is already exists!,', style: TextStyle(color: Colors.white),))
            )
          );
        }
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange.shade400,
        content: Center(child: Text('Password is not matched, please try again!', style: TextStyle(color: Colors.white), ))
        )
      );
    }
  }

  // login =================================================
  Future loginUser(String email, String password, BuildContext context) async{

    showDialog(
      context: context, 
      builder: (context) => Center(
        child: CircularProgressIndicator(color: Colors.green),
      )
      );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade800,
        content: Center(child: Text('Login Successfully!', style: TextStyle(color: Colors.white),))
      ));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavPage()));

    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange.shade400,
        content: Center(child: Text(e.toString(), style: TextStyle(color: Colors.white),))
      ));
    }

  }

  //  Fetch products ========================================================================
  Future<Stream<QuerySnapshot>> getProducts(String category) async{
    return await FirebaseFirestore.instance.collection(category).snapshots();
  }
}