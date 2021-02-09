import 'package:flutter/material.dart';
import 'file:///C:/Users/tarun/AndroidStudioProjects/flutter_login_app/lib/tabs/user_drawer.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  BottomTabs({this.tabPressed,this.selectedTab});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {

    _selectedTab = widget.selectedTab ?? 0;
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2.0,
            blurRadius: 20.0,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabBtn(
              imagePath: "assets/images/home.png",
              selected: _selectedTab == 0 ? true : false,
              onPressed: (){
                widget.tabPressed(0);
              },
            ),
            BottomTabBtn(
              imagePath: "assets/images/search.png",
              selected:  _selectedTab == 1 ? true : false,
              onPressed: (){
                widget.tabPressed(1);
              },
            ),
            BottomTabBtn(
              imagePath: "assets/images/favorite.png",
              selected: _selectedTab == 2 ? true : false,
              onPressed: (){
                widget.tabPressed(2);

              },
            ),
            BottomTabBtn(
              imagePath: "assets/images/user_icon.png",
              selected:  _selectedTab == 3 ? true : false,
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DrawerLayout()),);
                setState(() {
                  _selectedTab = 3;
                });
              },
            ),

          ],),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabBtn({this.onPressed,this.selected,this.imagePath});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected ? Theme.of(context).accentColor : Colors.transparent,
              width: 3.0,
            ),
          ),
        ),
        child: Image(
          image: AssetImage(
           imagePath ?? "assets/images/home.png"
          ),
          width: 28.0,
          height: 26.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
