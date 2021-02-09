import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/loginpage.dart';
import 'package:flutter_login_app/services/fire_services.dart';
import 'package:flutter_login_app/widgets/button_c.dart';
import 'package:flutter_login_app/widgets/textfield_c.dart';

import 'constants.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({Key key,this.productId, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  final String productId;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String name = "";
  String email = "";
  String psw = "";

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

  Future<String> _createAccount() async {
    if (_password != _cPassword) {
      return 'Password and Confirm Password must be same';}
    else{
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email, password: _password);
        return null;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          return 'The account already exists for that email.';
        }
        return e.message;
      } catch (e) {
        return e.toString();
      }
    }
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
  }
  bool _registerFromLoading = false;  //Button Loading state set to default

  String _email ="";
  String _password ="";
  String _cPassword;
  String _name ="";


  FocusNode _emailFocusNode,_cPasswordFocusNode, _passwordFocusNode ;

  final SnackBar _registerBar = SnackBar(content: Text("Registration Successful"));

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1C2F0),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 120.0,
            ),
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
                       _submitForm();
                       Scaffold.of(context).showSnackBar(_registerBar);
                      },
                      outlineBtn: false,
                      isLoading: _registerFromLoading,
                    )
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
    );
  }
}
