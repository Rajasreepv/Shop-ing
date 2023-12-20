import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/modals/cartModel.dart';
import 'package:weatherapp/pages/main_homepage.dart';
import 'package:weatherapp/pages/provider/cart_provider.dart';

int quantity = 1;

// ignore: must_be_immutable
class details extends StatefulWidget {
  final String imageAddress;
  final String name;
  double price;
  final String? Description;
  details({
    required this.name,
    required this.price,
    required this.imageAddress,
    this.Description,
  });

  @override
  State<details> createState() => _detailsState();
}

String selectedstate = "M";

List<cartmodel> cartlist = [];

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => main_homepage()));
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Image.network(widget.imageAddress),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(widget.name),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('\$ '+
                              widget.price.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Description"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(widget.Description ??
                                'No description available'),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Size"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              children: [
                                buildElevatedButton("S"),
                                SizedBox(width: 6),
                                buildElevatedButton("M"),
                                SizedBox(width: 6),
                                SizedBox(width: 6),
                                buildElevatedButton("L"),
                                SizedBox(width: 6),
                                buildElevatedButton("XL"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user == null) {
                              Fluttertoast.showToast(
                                  msg: "Please Login to add items to Cart");
                            } else {
                              cartmodel newItem = cartmodel(
                                name: widget.name,
                                imageaddress: widget.imageAddress,
                                itemprice: widget.price,
                                quantity:
                                    quantity, // Set the initial quantity to 1 or as needed
                                size: selectedstate,
                              );

                              // Add the new item to the cartlist
                              cartlist.add(newItem);

                              String uid = fAuth.currentUser!.uid;
                              CartProvider cartProvider =
                                  Provider.of<CartProvider>(context,
                                      listen: false);
                              cartProvider.addToCart(newItem);

                              Fluttertoast.showToast(msg: "Added to cart");
                            }
                          });
                        },
                        child: Text("Add to cart")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(String size) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedstate = size;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedstate == size
            ? Color.fromARGB(255, 182, 178, 138)
            : Color.fromARGB(222, 222, 222, 222),
      ),
      child: Text(size),
    );
  }
}
