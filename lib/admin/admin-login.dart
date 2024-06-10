import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/admin/admin-home.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  // =======================================================================
  String username = '', password = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future loginAddmin() async{
  showDialog(
    context: context, 
    builder: (context) => Center(
      child: CircularProgressIndicator(color: Colors.green),
    )
  );
  if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty){
    try {
       await FirebaseFirestore.instance.collection('Admin').get().then((snapshots){
      snapshots.docs.map((snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        if(data['username'] == _usernameController.text.trim() && data['password'] == _passwordController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green.shade800,
            content: Center(child: Text('You login successfully!', style: TextStyle(color: Colors.white), )),
          ));

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage()));
        }else{
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Center(child: Text('Wrong Email or Password, try again!', style: TextStyle(color: Colors.white), )),
          ));
        }
      }).toString();
    });
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange,
        content: Center(child: Text(e.toString(), style: TextStyle(color: Colors.white), )),
      ));
    }

  }
}

bool isVisible = false;

void changeVisibility(){
  setState(() {
    isVisible = !isVisible;
  });
}

// =======================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        toolbarHeight: 10.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Stack(
              children: [
        
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.8,
                  decoration: BoxDecoration(
                     color: Colors.grey.shade200
                  ),
                ),
                   
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.5,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.4),
                  decoration: BoxDecoration(
                     color:Color.fromARGB(255, 0, 0, 0),
                     borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110))
                  ),
                ),
        
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back_ios_new_outlined, size: 22.0, color: Colors.black38,)
                            ),
                            SizedBox(width: 50.0,),
                            Text('Admin Page', style: TextStyle(color: Colors.black38, fontSize: 20.0, fontWeight: FontWeight.bold), ),
                          ],
                        ),
                      ),
        
                      SizedBox(height: 30.0,),

                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Column(
                            children: [
                              
                              Text('Login', style: AppWidget.blackText18(),),
                                      
                              SizedBox(height: 20.0,),
                                      
                              Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                      
                                    TextFormField(
                                      controller: _usernameController,
                                      validator: (value) {
                                        if(value == null || value.isEmpty){
                                          return 'Please enter username';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                      decoration: InputDecoration(
                                        hintText: 'Username',
                                        hintStyle: TextStyle(color: Colors.black54, fontSize: 14.0),
                                        prefixIcon: Icon(Icons.person, size: 22.0, color: Colors.black,),
                                        contentPadding: EdgeInsets.all(0.0),
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
                                      obscureText: isVisible ? false : true,
                                      validator: (value) {
                                        if(value == null || value.isEmpty){
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle: TextStyle(color: Colors.black54, ),
                                        prefixIcon: Icon(Icons.password, size: 22.0, color: Colors.black,),
                                        suffixIcon: 
                                          GestureDetector(
                                            onTap: changeVisibility,
                                            child: Icon(
                                              isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined , size: 22.0, color: Colors.black54,
                                            ),
                                          ),
                                        contentPadding: EdgeInsets.all(0.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black38)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 1.5)
                                        )
                                      ),
                                    ),
                        
                                    SizedBox(height: 30.0,),
                        
                                    GestureDetector(
                                      onTap: () {
                                        if(_formkey.currentState!.validate()){
                                          setState(() {
                                            username = _usernameController.text;
                                            password = _passwordController.text;
                                          });
                                        }
                                        loginAddmin();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Text('LOGIN', style: AppWidget.lightText16()),
                                      ),
                                    )
                                      
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}