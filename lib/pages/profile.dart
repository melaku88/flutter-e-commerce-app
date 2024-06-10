import 'dart:io';

import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/service/auth.dart';
import 'package:e_commerce/service/shared-pref.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

// ================================================================================
  String? profile, name, email;
  File? selectedImage;

  // Get the shared preferan
getTheSharedPref() async{
  name = await SharedPreferanceHelper().getUserName();
  email = await SharedPreferanceHelper().getUserEmail();
  profile = await SharedPreferanceHelper().getUserProfile();
  setState(() {
    
  });
}

ontheloading() async{
  await getTheSharedPref();
  setState(() {
    
  });
}

@override
  void initState() {
    ontheloading();
    super.initState();
  }
  
  Future pickProfileImag() async{
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {
      uploadProfile();
    });
  }

  uploadProfile() async{
    if(selectedImage != null){
    String imageName = randomAlphaNumeric(10);
    Reference storageReferance = FirebaseStorage.instance.ref().child('Items-Image').child(imageName);
    final UploadTask task = storageReferance.putFile(selectedImage!);
    var downloadUrl = await(await task).ref.getDownloadURL();

    await SharedPreferanceHelper().saveUserProfile(downloadUrl);
    setState(() {

    });
    }
  }


  // ================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 10.0,
      ),
      body: SingleChildScrollView(

        child: name == null ? CircularProgressIndicator() :  Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170.0,
                    padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 110)),
                    ),
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 100.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(60.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60.0),
                          child: selectedImage == null ? GestureDetector(
                            onTap: () {
                              pickProfileImag();
                            },
                            child: profile == null ? Image.asset('images/profile.png', height: 100.0, width: 100.0, fit: BoxFit.cover,) : Image.network(profile!, height: 100.0, width: 100.0, fit: BoxFit.cover,)
                          ) : Image.file(selectedImage!, height: 100.0, width: 100.0, fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: Text(name!, style: AppWidget.lightText20(),),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0,),
        
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person, size: 25.0, color: Colors.black,),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name', style: AppWidget.blackText13(),),
                            SizedBox(height: 5.0,),
                            Text(name!, style: AppWidget.blackText13(),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
                       
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.email, size: 20.0, color: Colors.black,),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email', style: AppWidget.blackText13(),),
                            SizedBox(height: 5.0,),
                            Text(email!, style: AppWidget.blackText13(),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
                       
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.description, size: 20.0, color: Colors.black,),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Terms and Condtions', style: AppWidget.blackText16(),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
                            
              GestureDetector(
                onTap: () {
                  AuthModel().deleteUser();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20.0, color: Colors.black,),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Delete Account', style: AppWidget.blackText16(),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                            
              GestureDetector(
                onTap: () {
                  AuthModel().logOut().then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 20.0, color: Colors.black,),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Logout', style: AppWidget.blackText16(),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}