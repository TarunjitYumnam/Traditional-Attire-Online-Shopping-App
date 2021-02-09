import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSize;
  final Function(String) onSelected;
  ProductSize({this.onSelected,this.productSize});
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {

  int _seiected =0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
          children: [
            for(var i=0; i < widget.productSize.length; i++)
              GestureDetector(
                onTap: (){
                  widget.onSelected("${widget.productSize[i]}");
                  setState(() {
                    _seiected = i;
                  });
                },
                child: Container(
                  width: 42.0,
                   height: 42.0,
                  decoration: BoxDecoration(
                    color: _seiected == i ? Theme.of(context).accentColor : Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.0
                  ),
                  child: Text("${widget.productSize[i]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: _seiected == i ? Colors.white : Colors.black,
                        fontSize: 16.0,
                      )),
                ),
              )
          ],
        ),
    );
  }
}
