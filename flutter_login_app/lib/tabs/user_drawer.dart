import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/cart_page.dart';
import 'package:flutter_login_app/screens/homepage.dart';
import 'package:flutter_login_app/screens/signInWithGoogle.dart';
import 'package:flutter_login_app/tabs/Assam.dart';
import 'package:flutter_login_app/tabs/save_tab.dart';
import 'package:flutter_login_app/widgets/button_c.dart';

class DrawerLayout extends StatefulWidget {
  @override
  _DrawerLayoutState createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Container(
        color: Color(0xFFF1C2F0),
        child: ListView(
          children: [
            new UserAccountsDrawerHeader(
              accountName: Text('User Id: '+ user.uid),
              accountEmail: Text('Email: '+ user.email),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  maxRadius: 25.0,
                  //backgroundImage: NetworkImage(user.photoURL),
                ),
              ),
              decoration: new BoxDecoration(
                color: Color(0xFF0050AC),
              ),
            ),
            // DrawerHeader(
            //   child:
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text("Drawer",
            //     style: TextStyle(color: Colors.grey,fontSize: 14),),
            //   ],
            // ),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/user_icon.png'),
            //   ),
            // ),),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage(),),);
              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.pink,
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('My Account'),
              leading: Icon(
                Icons.person,
                color: Colors.pink,
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AssamProducts(),),);
              },
              child: ListTile(
                title: Text('My Order'),
                leading: Icon(
                  Icons.shopping_bag,
                  color: Colors.pink,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage(),),);
              },
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.pink,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>SaveTab()),);
              },
              child: ListTile(
                title: Text('Favourite'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
              ),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(
                Icons.settings,
                color: Colors.black38,
              ),
            ),
            ListTile(
              title: Text('About'),
              leading: Icon(
                Icons.help,
                color: Colors.black38,
              ),
            ),
            GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('SignOut'),
                leading: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black38,
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 40),
            ListTile(
              title: CustomBtn(
                onPressed: ()async{
                  await googleSignIn.disconnect();
                  Navigator.pop(context);
                },
                text: "Google Sign Out",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
