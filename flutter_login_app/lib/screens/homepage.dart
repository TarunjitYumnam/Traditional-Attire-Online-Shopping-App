import 'package:flutter/material.dart';
import 'package:flutter_login_app/tabs/home_tab.dart';
import 'package:flutter_login_app/tabs/save_tab.dart';
import 'package:flutter_login_app/tabs/search_tab.dart';
import 'package:flutter_login_app/tabs/user_drawer.dart';
import 'package:flutter_login_app/widgets/bottom_tabs.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  PageController _tabPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabPageController = PageController();
    super.initState();
  }


  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFF1C2F0),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabPageController,
              onPageChanged: (num){
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                  HomeTab(),
                SearchTab(),
                SaveTab(),
                DrawerLayout(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num){
                _tabPageController.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
            },
          ),
        ],
        // child: MaterialButton(
        //   onPressed: () async{
        //     await FirebaseAuth.instance.signOut();
        //   },
        //   child: Text("SignOut"),
        // ),
      ),
    );
  }
}
