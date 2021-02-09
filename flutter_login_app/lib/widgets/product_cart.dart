import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/constants.dart';
import 'package:flutter_login_app/screens/product_page.dart';

class ProductCart extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  ProductCart({this.productId,this.title,this.onPressed,this.imageUrl,this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            ProductPage(productId: productId,)),);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "$imageUrl",
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              bottom: 0.18,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 30.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                      style: Constants.regularHeading,),
                    Text(price,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                      ),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
