import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/cart_page.dart';
import 'package:flutter_login_app/screens/constants.dart';
import 'package:flutter_login_app/services/fire_services.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  final bool icon;
  CustomActionBar({this.icon,this.hasBackground,this.hasTitle,this.title,this.hasBackArrow});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _userRef = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;
    bool _icon = icon ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0, 0),
          end: Alignment(0, 1),
        ): null
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasBackArrow)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(
                    "assets/images/backLeft.png"
                  ),
                  color: Colors.white,
                  width: 26.0,
                  height: 26.0,
                ),
              ),
            ),
          if(_hasTitle)
          Text(
            title ?? "Action Bar",
          style: Constants.boldHeading,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(),));
            },
            child: Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _userRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots(),
                builder: (context, snapshot){
                  int _totalItems = 0;
                  if(snapshot.connectionState == ConnectionState.active){
                    List _documents = snapshot.data.docs;
                    _totalItems = _documents.length;
                  }

                  return Text( "$_totalItems" ?? "0",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
