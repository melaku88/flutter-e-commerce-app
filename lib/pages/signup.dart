import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/bottomnav.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/service/shared-pref.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // ========================================================================================

  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPaawordController = new TextEditingController();

   String username = '', email = '', password = '', confirmPassword = '';

  final _formkey = GlobalKey<FormState>();

  Future registration() async{
    if(password == confirmPassword){
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        var id = await randomAlphaNumeric(10);
        
        await FirebaseFirestore.instance.collection('Users').doc(id).set({
          'id': id,
          'usrname': username,
          'email': email,
          'wallet': '0'
        });

        await SharedPreferanceHelper().saveUserId(id);
        await SharedPreferanceHelper().saveUserName(_usernameController.text);
        await SharedPreferanceHelper().saveUserEmail(_emailController.text);
        await SharedPreferanceHelper().saveUserWallet('0');
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade800,
          content: Center(child: Text('Registered Successfully!', style: TextStyle(color: Colors.white),))
          )
        );
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavPage()));
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.deepOrange.shade400,
          content: Center(child: Text(e.toString(), style: TextStyle(color: Colors.white),))
        ));
      } 
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange.shade400,
        content: Center(child: Text('Password is not matched, please try again!', style: TextStyle(color: Colors.white), ))
        )
      );
    }
  }

  bool isPasswordVisible = false;
  bool isConfirmPassVisble = false;

  void changePasswordVisibility(){
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }
  void changeConfirmPasVisibility(){
    setState(() {
      isConfirmPassVisble = !isConfirmPassVisble;
    });
  }
  // ========================================================================================
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade600,
      appBar: AppBar(
        backgroundColor:  Colors.grey.shade200,
        toolbarHeight: 10.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
        
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
              ),
        
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                decoration: BoxDecoration(
                  color:Colors.green.shade600,
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110))
                ),
              ),
        
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 20.0,),
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage())),
                            child: Icon(Icons.arrow_back_ios_new_outlined, size: 20.0, color: Colors.black38,),
                          ),
                          SizedBox(width: 50.0,),
                          Text('Create a new account!', style: TextStyle(color: Colors.black38, fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),

                    SizedBox(height: 30.0,),
        
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Column(
                          children: [
                            Text('Sign Up', style: AppWidget.blackText20(),),
                            SizedBox(height: 5.0,),
                            Container( height: 3.0, width: 40.0,
                              decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10.0)),
                            ),
                                
                            SizedBox(height: 20.0,),
                            Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                      
                                  TextFormField(
                                    controller: _usernameController,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return 'Please enter Username';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                      hintStyle: AppWidget.blackLightText13(),
                                      prefixIcon: Icon(Icons.person_outline, size: 20.0,),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black38)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.5)
                                      )
                                    ),
                                  ),
                                      
                                  SizedBox(height: 20.0,),
                                        
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return 'Please enter E-mail';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: AppWidget.blackLightText13(),
                                      prefixIcon: Icon(Icons.email_outlined, size: 20.0,),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black38)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.5)
                                      )
                                    ),
                                  ),
                                  
                                  SizedBox(height: 20.0,),
                                         
                                  TextFormField(
                                    controller: _passwordController,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return 'Please enter Password';
                                      }
                                      return null;
                                    },
                                    obscureText: isPasswordVisible ? false : true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: AppWidget.blackLightText13(),
                                      prefixIcon: Icon(Icons.password_outlined, size: 20.0,),
                                      suffixIcon: GestureDetector(
                                        onTap: changePasswordVisibility,
                                        child: Icon(
                                          isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20.0,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black38)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.5)
                                      )
                                    ),
                                  ),
                                  
                                  SizedBox(height: 20.0,),
                                         
                                  TextFormField(
                                    controller: _confirmPaawordController,
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                        return 'Please Confirm Your Password ';
                                      }
                                      return null;
                                    },
                                    obscureText: isConfirmPassVisble ? false : true,
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
                                      hintStyle: AppWidget.blackLightText13(),
                                      prefixIcon: Icon(Icons.password_outlined, size: 20.0,),
                                      suffixIcon: GestureDetector(
                                        onTap: changeConfirmPasVisibility,
                                        child: Icon(
                                          isConfirmPassVisble ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20.0,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black38)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.5)
                                      )
                                    ),
                                  ),
                                      
                                  SizedBox(height: 20.0,),
                                      
                                  GestureDetector(
                                    onTap: () async{
                                      if(_formkey.currentState!.validate()){
                                        setState(() {
                                          username = _usernameController.text;
                                          email = _emailController.text;
                                          password = _passwordController.text;
                                          confirmPassword = _confirmPaawordController.text;
                                        });
                                      }
                                      registration();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade600,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Text('REGISTER', style: AppWidget.lightText16()),
                                    ),
                                  ),
                                  SizedBox(height: 20.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Already have an account? ', style: TextStyle(fontSize: 14.0, color: Colors.black45), ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                                        child: Text('LOGIN', style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold) )
                                      ),
                                    ],
                                  )
                                      
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}