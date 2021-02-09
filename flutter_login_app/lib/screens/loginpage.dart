import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/adminLogin.dart';
import 'package:flutter_login_app/screens/constants.dart';
import 'package:flutter_login_app/screens/homepage.dart';
import 'package:flutter_login_app/screens/register.dart';
import 'package:flutter_login_app/screens/signInWithGoogle.dart';
import 'package:flutter_login_app/screens/signupPage.dart';
import 'package:flutter_login_app/widgets/button_c.dart';
import 'package:flutter_login_app/widgets/textfield_c.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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

  Future<String> _Login()async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _loginEmail, password: _loginPassword);
      print("Uesr: $userCredential");
    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        return'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return'Wrong password provided for that user.';
      }
      return e.message;
    }catch(e){
      return e.toString();
    }
  }
  void _submitForm() async {
    setState(() {
      _loginFromLoading = true; //loading state Activated
    });
    String _createAccountFeed = await _Login(); //createAccount method working
    if(_createAccountFeed != null){
      _alertDialogBuilder(_createAccountFeed);

      setState(() {
        _loginFromLoading = false; //loading state deActivated
      });
    }
  }
  bool _loginFromLoading = false;//Button Loading state set to default

  String _loginEmail ="";
  String _loginPassword ="";

  FocusNode _passwordFocusNode ;

  final SnackBar _snackBar = SnackBar(content: Text("Login Successful"));

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

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: (){
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  //return HomePage();
                  return Homepage();
                },
              ),
            );
          }
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Text('Login with Google',
            style: Constants.regularHeading,
            textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSocialBtn(
                    () => print('Login with Google'),
                AssetImage(
                  'assets/images/google_logo.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1C2F0),
      drawer: new Drawer(

      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          //width: double.infinity,
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
                child: Text("Welcome to NE traditional Attire shopping app \n Login to your Account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,),
              ),
              Column(
                children: [
                  CustomInput(
                    textIcon: Icons.email,
                    hintText: "Enter an Email.....",
                    onChanged: (value){
                      _loginEmail = value;
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
                      _loginPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPassword: true,
                    onSubmitted: (value){
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Login",
                    onPressed: (){
                      _submitForm();
                      //Scaffold.of(context).showSnackBar(_snackBar);
                    },
                    outlineBtn: false,
                    isLoading: _loginFromLoading,
                  ),
                  _buildSocialBtnRow(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 14.0
                ),
                child: CustomBtn(
                  text:  "Register",
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()),);
                  },
                  outlineBtn: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 14.0
                ),
                child: CustomBtn(
                  text:  "I'm Admin ?",
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminLogin()),);
                  },
                  outlineBtn: true,
                ),
              ),
            ],
            ),
          ),
      ),
    ));
  }
}
