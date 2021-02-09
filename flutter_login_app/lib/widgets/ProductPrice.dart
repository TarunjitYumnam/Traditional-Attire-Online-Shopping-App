import 'package:flutter/material.dart';

class ProductPrice extends StatefulWidget {
  final int productPrice;
  final Function(String) onSelected;
  ProductPrice({this.onSelected,this.productPrice});

  @override
  _ProductPriceState createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
