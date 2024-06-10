import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/components/addItems-field.dart';
// import 'package:e_commerce/service/upload-item.dart';
import 'package:e_commerce/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // ===================================================================================
  final TextEditingController _itemeNameController = TextEditingController();
  final TextEditingController _itemePriceController = TextEditingController();
  final TextEditingController _itemeDetailController = TextEditingController();

  String? categoryValue;
  final List<String> categoris = ['Bag', 'Dress', 'F-Shoe', 'M-Shoe', 'Phone', 'Watch'];

  File? selectedImage;

  Future getImage()async{
    var image = await ImagePicker().pickImage(source:ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  Future uploadProduct() async{
    showDialog(
      context: context, 
      builder: (context) => Center(
        child: CircularProgressIndicator(color: Colors.green),
      )
      );

   if(selectedImage != null && _itemeNameController.text.isNotEmpty && _itemePriceController.text.isNotEmpty && _itemeDetailController.text.isNotEmpty){
    String imageName = randomAlphaNumeric(10);
    Reference storageReferance = FirebaseStorage.instance.ref().child('Items-Image').child(imageName);
    UploadTask  task = storageReferance.putFile(selectedImage!);
    var downloadUrl = await(await task).ref.getDownloadURL();

    try {
      await FirebaseFirestore.instance.collection(categoryValue!).add({
        'image': downloadUrl,
        'name': _itemeNameController.text,
        'price': _itemePriceController.text,
        'detail': _itemeDetailController.text,
        'timestamp': Timestamp.now(),
      }).then((value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green.shade800,
          content: Center(child: Text('The Product is added successfully!', style: AppWidget.lightText13(),)),
        ));

        _itemeNameController.clear();
        _itemePriceController.clear();
        _itemeDetailController.clear();
        setState(() {
          selectedImage = null;
          categoryValue = null;
        });
      });

    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepOrange,
        content: Center(child: Text(e.toString(), style: AppWidget.lightText13(),)),
      ));
    }
   }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.deepOrange.shade800,
      content: Center(child: Text('All fields are required, please provide each fields', style: AppWidget.lightText13(),)),
    ));
    Navigator.pop(context);
   }
    
  }

  // ===================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Items', style: AppWidget.blackText20(),),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined, size: 20.0,),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Center(child: Text('Upload the Item Picture', style: AppWidget.blackText14(),)),
              SizedBox(height: 10.0,),
        
              selectedImage == null ? GestureDetector(
                onTap:() {
                  setState(() {
                    getImage();
                  });
                },
                child: Center(
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey.shade800)
                    ),
                    child: Icon(Icons.camera_alt_outlined, size: 30.0, color: Colors.lightBlue,),
                  ),
                ),
              ):Center(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade800)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(selectedImage!, width: 120.0, height: 120.0, fit: BoxFit.fill,)
                  ),
                ),
              ),
              
              SizedBox(height: 20.0,),
        
              MyCuprtinoTextField(
                title: 'Item Name: ', 
                controller: _itemeNameController
              ),
              
              MyCuprtinoTextField(
                title: 'Item Price: ', 
                controller: _itemePriceController
              ),
              
              MyCuprtinoTextField(
                title: 'Item Details: ', 
                controller: _itemeDetailController,
                minLines: 4,
              ),

              Text('Select product\'s category:', style: AppWidget.blackText14(),),
              SizedBox(height: 2.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: categoris.map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category,style: TextStyle(color: Colors.lightBlue, fontSize: 14.0), ))).toList(), 
                    onChanged:(element) {
                      setState(() {
                        categoryValue = element;
                      });
                    },
                    dropdownColor: Colors.white,
                    hint: Text('Select Category', style: TextStyle(color: Colors.black26, fontSize: 14.0),),
                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25.0, color: Colors.lightBlue,),
                    value: categoryValue,
                  ),
                ),
              ),

              Center(
                child: GestureDetector(
                  onTap: uploadProduct,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 150.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6.0)
                      ),
                      child: Text('Add', style: AppWidget.lightText14(),),
                    )
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}