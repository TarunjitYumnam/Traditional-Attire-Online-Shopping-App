import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/loginpage.dart';
import 'package:flutter_login_app/widgets/button_c.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  var _backgroundColor = Color(0xFFF1C2F0);
  double _heading = 100;
  var _headingColor = Color(0xFF812027B);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: _backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: _heading,
                      ),
                      child: Text(
                        "Traditional Attire Online Shopping App",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _headingColor,
                            fontSize: 25.0,
                            fontFamily: "Nunito-ExtraBold"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Welcome to the North Eastern India Traditional Attire Online Shopping App",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _headingColor,
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Image.asset("assets/images/lgo.jpg"),
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  LoginPage();
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      //color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: CustomBtn(
                          text:  "Get Started",
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()),);
                          },
                          outlineBtn: false,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
