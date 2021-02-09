import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/loginpage.dart';
import 'package:flutter_login_app/widgets/button_c.dart';
import 'package:flutter_login_app/widgets/loadingProgress.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String uploadImageUrl;
  File file;
  TextEditingController _desTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortTextEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool upload = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? AdminHomePage() : AdminUpload();}
  AdminHomePage(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        leading: IconButton(
          icon: Icon(Icons.library_add),
          onPressed: (){

          },
        ),
        actions: [
          FlatButton(child: Text('LogOut',style: TextStyle(color: Colors.greenAccent,fontSize: 16.0),),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(),));
          },)
        ],
      ), //AppBar
        body: AdminHome(),
    );
  }

  AdminHome() {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload_sharp,size: 200.0,color: Colors.blueGrey,),
          Padding(padding: EdgeInsets.only(top: 20.0),
          child: CustomBtn(
            text: "Upload Products",
            onPressed: ()=> takeImage(context),
          ),),
        ],
      ),
    ),
  );
  }
  takeImage(mContext){
    return showDialog(context: mContext,
    builder: (con){
      return SimpleDialog(
        title: Text("Item Image", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
        children: [
          SimpleDialogOption(
            child: Text("Capture with Camera",style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w800),),
            onPressed: capturePicWithCamera,
          ),
          SimpleDialogOption(
            child: Text("Select from Gallery",style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w800),),
            onPressed: selectFromGallery,
          ),
          SimpleDialogOption(
            child: Text("Cancel",style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w800),),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }
  capturePicWithCamera() async{
    Navigator.pop(context);
   File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
   setState(() {
     file = imageFile;
   });
  }
  selectFromGallery() async{
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = imageFile;
    });
  }
  AdminUpload(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload New Products'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: clearFormInfo,
        ),
        actions: [
          FlatButton(child: Text('Add',style: TextStyle(color: Colors.greenAccent,fontSize: 16.0),),
            onPressed: upload ? null :()=> uploadImageAndSaveInfo(),)
        ],
      ),
      body: ListView(
        children: [
          upload ? linerProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top:12.0)),
          ListTile(
            leading: Icon(Icons.perm_device_info_sharp,color: Colors.blueGrey,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _shortTextEditingController,
                decoration: InputDecoration(
                  hintText: "Short Info",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.blue,),

          ListTile(
            leading: Icon(Icons.app_registration,color: Colors.blueGrey,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _titleTextEditingController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.blue,),

          ListTile(
            leading: Icon(Icons.description_outlined,color: Colors.blueGrey,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _desTextEditingController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.blue,),

          ListTile(
            leading: Icon(Icons.create_sharp,color: Colors.blueGrey,),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _priceTextEditingController,
                decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.blue,),
        ],
      ),
    );
  }
  clearFormInfo(){
  setState(() {
    file = null;
    _desTextEditingController.clear();
    _priceTextEditingController.clear();
    _shortTextEditingController.clear();
    _titleTextEditingController.clear();
  });
  }

  uploadImageAndSaveInfo() async{
    setState(() {
      upload = true;
    });
  String imageUrl = await uploadItemImage(file);
  saveItemInfo(imageUrl);
  }
  Future <String> uploadItemImage(mFileImage) async{
    FirebaseStorage storage = FirebaseStorage.instance;
    final Reference ref = storage.ref().child("items");
    UploadTask uploadTask = ref.child("product_$productId.jpg").putFile(mFileImage);
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
    print('File Uploaded');
    ref.getDownloadURL().then((fileURL) {
      setState(() {
        uploadImageUrl = fileURL;
      });
    });
    return uploadImageUrl;
  }
  saveItemInfo(String uploadImageUrl){
    final itemsRef = FirebaseFirestore.instance.collection("items");
    itemsRef.doc(productId).set({
      "shortInfo":_shortTextEditingController.text.trim(),
      "longDes":_desTextEditingController.text.trim(),
      "price":_priceTextEditingController.text.trim(),
      "publishedDate":DateTime.now(),
      "status":"Available",
      "thumbnailUrl": uploadImageUrl,
      "title":_titleTextEditingController.text.trim(),
    });
    setState(() {
      file = null;
      upload = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _desTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortTextEditingController.clear();
      _priceTextEditingController.clear();
    });
  }
}
