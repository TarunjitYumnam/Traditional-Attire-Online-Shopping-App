import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;
  final bool context;


  CustomBtn({this.context,this.text, this.onPressed, this.outlineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55.0,
        decoration:  BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Color(0xFF819207d),
          border: Border.all(
            color: Color(0xFF819207d),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 14.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text Field",
                style: TextStyle(
                  fontSize: 16.0,
                  color: _outlineBtn ? Color(0xFF819207d) : Colors.white,
                  fontWeight: FontWeight.w800,
                ),),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
