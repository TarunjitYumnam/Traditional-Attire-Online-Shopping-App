
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/widgets/button_c.dart';
import 'package:flutter_login_app/widgets/textfield_c.dart';
import 'package:image_picker/image_picker.dart';

import 'constants.dart';
import 'loginpage.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _name;
  String _email;
  String _password;
  String _cPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl;
  File file;

  FocusNode _emailFocusNode,_cPasswordFocusNode,_passwordFocusNode ;

  final SnackBar _registerBar = SnackBar(content: Text("Registration Successful"));

  Future<String> _createAccount() async{
    if(file == null){
      return 'Please select an Image';
    }
    else{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      return null;
    }
    on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return'The password provided is too weak.';
      }else if(_password != _cPassword){
        return 'Password and Confirm Password must be same';
      } else if (e.code == 'email-already-in-use') {
        return'The account already exists for that email.';
      }
      return e.message;
    }catch(e){
      return e.toString();
    }
    }
  }
  Future<void> _alertDialogBuilder(String error ) async{    //displaying error
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Error: "),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Close"))
            ],
          );
        });
  }

  void _submitForm() async {
    setState(() {
      _registerFromLoading = true; //loading state Activated
    });
    String _createAccountFeed = await _createAccount(); //createAccount method working
    if(_createAccountFeed != null){
      _alertDialogBuilder(_createAccountFeed);

      setState(() {
        _registerFromLoading = false; //loading state deActivated
      });
    }else{
      Navigator.pop(context);
      //Navigator.push(context, MaterialPageRoute(builder: (context) {return LoginPage();}));
    }
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
   // StorageReference storageReference = FirebaseStorage.instance.ref().child(imageFileName);
  }

  bool _registerFromLoading = false;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _cPasswordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _cPasswordFocusNode.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF1C2F0),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text("Create A New Account",
                      textAlign: TextAlign.center,
                      style: Constants.boldHeading,),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 10.0,),
                      InkWell(
                        onTap: _selectAndPickImage,
                        child: CircleAvatar(
                          radius: _screenWidth= 50.15,
                          backgroundColor: Color(0xFF0050AC),
                          backgroundImage: file== null ? null : FileImage(file),
                          child: file == null ? Icon(Icons.add_photo_alternate, size: _screenWidth= 50.15, color: Colors.white,): null,
                        ),
                      ),
                      SizedBox(height:  8.0,),
                      Form(child: Column(
                        children: [
                          CustomInput(
                            textIcon:  Icons.person,
                            hintText: "Enter your name.....",
                            onChanged: (value){
                              _name = value;
                            },
                            onSubmitted: (value){
                              _emailFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          CustomInput(
                            textIcon: Icons.email,
                            hintText: "Enter an Email.....",
                            onChanged: (value){
                              _email = value;
                            },
                            onSubmitted: (value){
                              _passwordFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          CustomInput(
                            textIcon: Icons.vpn_key,
                            hintText: "Enter a Password...",
                            onChanged: (value){
                              _password = value;
                            },
                            isPassword: true,
                            onSubmitted: (value){
                              _cPasswordFocusNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          CustomInput(
                            textIcon: Icons.vpn_key,
                            hintText: "Confirm Password...",
                            onChanged: (value){
                              _cPassword = value;
                            },
                            focusNode: _cPasswordFocusNode,
                            isPassword: true,
                            onSubmitted: (value){
                              _submitForm();
                            },
                          ),
                          CustomBtn(
                            text: "Register",
                            onPressed: (){
                              uploadFile(file);
                              _submitForm();
                              Scaffold.of(context).showSnackBar(_registerBar);
                            },
                            outlineBtn: false,
                            isLoading: _registerFromLoading,
                          )
                        ],
                      ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0
                    ),
                    child: CustomBtn(
                      text:  "Back to Login Page",
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()),);
                      },
                      outlineBtn: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  _selectAndPickImage() async{
    await ImagePicker.pickImage(source: ImageSource.gallery).then((imageFile){
      setState(() {
        file = imageFile;
      });
    });
  }
  Future uploadFile(mfile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child("images"+DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(mfile);
    await uploadTask.then((res){
      res.ref.getDownloadURL();
    });
    print('File Uploaded');
    ref.getDownloadURL().then((fileURL) {
      setState(() {
        userImageUrl = fileURL;
      });
    });
  }
}

