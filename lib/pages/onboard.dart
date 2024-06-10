import 'package:e_commerce/admin/admin-login.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/widgets/content-model.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {

  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        toolbarHeight: 10.0,
      ),
      body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i){
                return Padding(padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Image.asset(contents[i].image, height: 320.0, width: MediaQuery.of(context).size.width/1.5,),
              
                    SizedBox(height: 10.0,),
              
                    Center(child: Text(contents[i].title, style: AppWidget.blackText18(),)),
              
                    SizedBox(height: 10.0,),
                    
                    Center(child: Text(contents[i].description, style: AppWidget.blackLightText14(),))
                  ],
                ),
                );
              }),
            ),
        
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(contents.length, (index){
                  return Container(
                    height: 10.0,
                    width: currentIndex == index ? 20.0 : 7.0,
                    margin: EdgeInsets.only(right: 5.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), color: Colors.black38),
                  );
                }
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if(currentIndex == contents.length - 1){
                  showDialog(context: context, 
                    builder: (context)=> AlertDialog(
                      title: Center(child: Text('Login As:', style: AppWidget.blackText20(),)),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminLoginPage())),
                            child: Text('Admin', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
                          ),
                          SizedBox(width: 20.0,),
                          Container(
                            width: 2.0,
                            height: 20.0,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(width: 20.0,),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                            child: Text('User', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                          ),
                        ],
                      ),
                    )
                  );
                }
                _controller.nextPage(duration: Duration(milliseconds: 700), curve: Curves.linearToEaseOut);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/10, right: MediaQuery.of(context).size.width/10, top: 20.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text(currentIndex == contents.length - 1 ? 'Start' : 'Next', style: AppWidget.lightText16()),
              
              ),
            )
          ],
        ),
    );
  }

}