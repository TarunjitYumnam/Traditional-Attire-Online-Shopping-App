import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/screens/constants.dart';
import 'package:flutter_login_app/services/fire_services.dart';
import 'package:flutter_login_app/widgets/custom_actionbar.dart';
import 'package:flutter_login_app/widgets/product_size.dart';
import 'package:flutter_login_app/widgets/swipe_image.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String quantity = "1";
  String _selectedProductSize = "0";

  Future _addToSaved() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved Product")
        .doc(widget.productId)
        .set({"size": _selectedProductSize,"quantity": quantity});
  }

  Future _addToCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize,"quantity": quantity});
  }

  final SnackBar _snackBar = SnackBar(content: Text("Product Added",));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
            future: _firebaseServices.productRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //Firebase Doc Data Map
                Map<String, dynamic> documentData = snapshot.data.data();
                //List of images from Firebase
                List imageList = documentData['images'];
                List productSize = documentData['Size'];

                //Setting the initial Size
                _selectedProductSize = productSize[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "${documentData['name']}" ?? "Name",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "Rs.${documentData['Price']}" ?? "Price",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "${documentData['Description']}" ?? "Description",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "Select Size",
                        style: Constants.regularHeading,
                      ),
                    ),
                    ProductSize(
                      productSize: productSize,
                      onSelected: (size){
                        _selectedProductSize = size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Quantity:",
                            style: Constants.regularHeading,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            value: quantity,
                            items: <String>["1", "2", "3", "4", "5"]
                                .map((String value) =>
                                DropdownMenuItem<String>(
                                    value: value, child: Text(value)))
                                .toList(),
                            onChanged: (_value) {
                              setState(() {
                                quantity = _value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap:() async {
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage("assets/images/favorite.png"),
                                width: 25.0,
                                height: 25.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage("assets/images/add_cart.png"),
                                width: 25.0,
                                height: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ProductPrice(
                    //   productPrice: productPrice,
                    //   onSelected: (price){
                    //     _ProductPrices = price;
                    //   },
                    // ),
                  ],
                );
              }

              //Loading Page
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
        CustomActionBar(
          hasBackArrow: true,
          hasTitle: false,
          hasBackground: false,
        )
      ],
    ));
  }
}
