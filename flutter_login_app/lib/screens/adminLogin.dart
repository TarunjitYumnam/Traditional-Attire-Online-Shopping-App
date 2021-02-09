import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/services/adminPage.dart';
import 'package:flutter_login_app/widgets/button_c.dart';
import 'package:flutter_login_app/widgets/textfield_c.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';
import 'loginpage.dart';
final SnackBar _snackBar = SnackBar(content: Text("Login Successful"));

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
  bool _loginFromLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adminId =TextEditingController();
  final TextEditingController _adminPassword =TextEditingController();

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
                    child: Text("Welcome Admin to NE traditional Attire shopping app \n Login as Admin",
                      textAlign: TextAlign.center,
                      style: Constants.boldHeading,),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInput(
                          textIcon: Icons.lock_open,
                          hintText: "Enter Admin Id.....",
                          // onChanged: (value){
                          //   _adminId = value;
                          // },
                          controller: _adminId,
                          onSubmitted: (value){
                            _passwordFocusNode.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          textIcon: Icons.vpn_key,
                          hintText: "Enter a Password...",
                          // onChanged: (value){
                          //   _adminPassword = value;
                          // },
                          controller: _adminPassword,
                          focusNode: _passwordFocusNode,
                          isPassword: true,
                          onSubmitted: (value){
                          },
                        ),
                        RaisedButton(
                          onPressed: (){
                            _adminId.text.isNotEmpty && _adminPassword.text.isNotEmpty
                            ?
                            _submitAdmin() : showDialog(context: context,
                            builder: (c)
                            {
                              return Text('Please Enter Email and Password',style: TextStyle(color: Colors.blueGrey,fontSize: 20.0,fontWeight: FontWeight.bold),);
                            });
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminPage(),));

                            //Scaffold.of(context).showSnackBar(_snackBar);
                          },
                          color: Colors.blue,
                          child: Text("Admin Login", style: TextStyle(color: Colors.white),),
                          // outlineBtn: false,
                          // isLoading: _loginFromLoading,
                        ),
                        SizedBox(height: 54.0,),
                        Container(height: 4.0,
                        width: 18.0,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 11.0,
                        ),
                        FlatButton.icon(
                            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPage())),
                            icon: (Icon(Icons.nature_people_sharp)),
                            label: Text("I'm not Admin",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ));
  }
  _submitAdmin() async{
    try {
        await FirebaseFirestore.instance.collection("admins").get().then((snapshot) {
        snapshot.docs.forEach((result) {
          if (result.data()["id"] != _adminId.text.trim()) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Invalid Id"),));
          }
          else if (result.data()["password"] != _adminPassword.text.trim()) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Invalid Password"),));
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Admin, "+result.data()["name"]),));
            setState(() {
              _adminId.text   = "";
              _adminPassword.text = "";
            });
            Route route = MaterialPageRoute(builder: (context)=>AdminPage());
            Navigator.pushReplacement(context, route);
          }
        });
      });
/*      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );*/
    }catch(e) {
      return e.toString();
    }
  }
}

