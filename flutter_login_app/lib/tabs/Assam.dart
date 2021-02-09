import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/widgets/custom_actionbar.dart';
import 'package:flutter_login_app/widgets/product_cart.dart';

class AssamProducts extends StatelessWidget {
  final CollectionReference _productRef =
  FirebaseFirestore.instance.collection("Festive");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _productRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                //Data from Firebase are ready to display
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 100.0,
                      bottom: 16.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductCart(
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: "Rs.${document.data()['Price']}",

                        productId: document.id,
                      );
                    }).toList(),
                  );
                }

                //Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            title: "Recent Products",
            //hasTitle: false,
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
