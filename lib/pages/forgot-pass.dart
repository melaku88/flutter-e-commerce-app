import 'package:e_commerce/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // ====================================================================
  final TextEditingController _passwordRsetEmailController = TextEditingController();

  String email = '';

  final _formkey = GlobalKey<FormState>();

  Future resetPassword() async{
    try {

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade900,
        content: Center(child: Text('Password reset email has just sent succssfully!', style: TextStyle(color: Colors.white),))
      )
    );
    }on FirebaseAuthException catch (e) {
      if(e.code.isNotEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber.shade900,
          content: Center(child: Text('No User found for this email', style: TextStyle(color: Colors.white),))
        )
      );
      }
    }
  }
  // ====================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined, size: 22.0, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
            child: Column(
              children: [
          
                SizedBox(height: 0.0,),
                Text(
                  'Password Recovery',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
          
                SizedBox(height: 20.0,),
                     
                Text(
                  'Enter Your Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
          
                SizedBox(height: 20.0,),
          
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _passwordRsetEmailController,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Please Enter Your Email';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.white, size: 30.0,),
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0)
                        ),
                      ),
                            
                      SizedBox(height: 40.0,),
          
                      GestureDetector(
                        onTap: () {
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              email = _passwordRsetEmailController.text;
                            });
                          }
                          resetPassword();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200.0,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Text('Send Email', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  )
                ),
          
                SizedBox(height: 50.0,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? ', style: TextStyle(color: Colors.white, fontSize: 15.0 ),),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage())),
                      child: Text('CREATE', style: TextStyle(color: Colors.amber, fontSize: 15.0, fontWeight:FontWeight.bold  ),)
                    ),
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