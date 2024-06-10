import 'package:e_commerce/pages/forgot-pass.dart';
import 'package:e_commerce/pages/signup.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ====================================================================================

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

   String email = '', password = '';

   final _formkey = GlobalKey<FormState>();

   void login() async{
    await DatabaseService().loginUser(email, password, context);
   }

   bool isVisible = false;

   void changeVisibility(){
    setState(() {
      isVisible = !isVisible;
    });
   }

  // ====================================================================================
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
                height: MediaQuery.of(context).size.height/1.8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
              ),
        
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.5,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.4),
                decoration: BoxDecoration(
                  color:Colors.green.shade600,
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110))
                ),
              ),
        
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios_new_outlined, size: 20.0, color: Colors.black38,),
                          ),
                          SizedBox(width: 50.0,),
                          Text('Welcome Back!', style: TextStyle(color: Colors.black38, fontSize: 18.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),

                    SizedBox(height: 30.0,),

                    Material(
                      elevation: 50.0,
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Text('Login', style: AppWidget.blackText20(),),
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
                                    controller: _emailController,
                                    validator: (value) {
                                      if(value == null || value == ''){
                                        return 'Please enter email';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14.0),
                                      prefixIcon: Icon(Icons.email, size: 20.0,),
                                      contentPadding: EdgeInsets.all(10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black38)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.5)
                                      )
                                    ),
                                  ),
                                      
                                  SizedBox(height: 40.0,),
                                      
                                  TextFormField(
                                    controller: _passwordController,
                                    validator: (value) {
                                      if(value == null || value == ''){
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                    obscureText: isVisible ? false : true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: AppWidget.blackLightText13(),
                                      prefixIcon: Icon(Icons.password_outlined, size: 20.0,),
                                      suffixIcon: GestureDetector(
                                        onTap: changeVisibility,
                                        child: Icon(
                                          isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20.0,
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
                                      
                                  // SizedBox(height: 80.0,),
                                  SizedBox(height: 20.0,),
                                      
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if(_formkey.currentState!.validate()){
                                          setState(() {
                                            email = _emailController.text;
                                            password = _passwordController.text;
                                          });
                                        }
                                        login();
                                      });
                                    },
                                   child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade600,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Text('LOGIN', style: AppWidget.lightText16()),
                                    ),
                                  ),
                                        
                                  SizedBox(height: 20.0,),
                                      
                                  GestureDetector(
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage())),
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: Text('Forgot Password?', style: TextStyle(fontSize: 14.0, color: Colors.lightBlue)),
                                    ),
                                  ),
                              
                                  SizedBox(height: 10.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Don\'t have an account? ', style: TextStyle(fontSize: 14.0, color: Colors.black45), ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage())),
                                        child: Text('REGISTER', style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold) )
                                      ),
                                    ],
                                  ),
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