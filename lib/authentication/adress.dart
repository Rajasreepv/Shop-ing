import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:weatherapp/pages/Splashscreen.dart';
import 'package:weatherapp/pages/orders/cartpage.dart';
import 'package:weatherapp/pages/modals/adressmodal.dart';
import 'package:weatherapp/pages/modals/cartModel.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/main_homepage.dart';
import 'package:weatherapp/pages/orders/orders.dart';
import 'package:weatherapp/pages/orders/upipayment.dart';
import 'package:weatherapp/pages/provider/cart_provider.dart';

_normalProgress(context) async {
  ProgressDialog pf = ProgressDialog(context: context);
  pf.show(
      msg: 'Saving please wait...',
      progressBgColor: Colors.transparent,
      backgroundColor: Colors.white,
      msgColor: Color.fromARGB(255, 5, 71, 65),
      progressValueColor: Colors.purple);
}

// List<cartmodel> orderlist = [];
String status = "Processing";

class adressScreen extends StatefulWidget {
  adressScreen({required this.prolist, required this.totalPrice});
  final List<cartmodel> prolist;
  final double totalPrice;
  @override
  State<adressScreen> createState() => _adressScreenState();
}

class _adressScreenState extends State<adressScreen> {
  TextEditingController housenameEditingcontroller = TextEditingController();
  TextEditingController streetEditingcontroller = TextEditingController();
  TextEditingController cityEditingcontrolller = TextEditingController();
  TextEditingController postalcodetEditingcontroller = TextEditingController();
  TextEditingController countryEditingcontroller = TextEditingController();
  TextEditingController phoneEditingcontroller = TextEditingController();
  adressValidation() {
    if (streetEditingcontroller.text.isEmpty &&
        cityEditingcontrolller.text.isEmpty &&
        postalcodetEditingcontroller.text.isEmpty) {
      Fluttertoast.showToast(msg: "fields Cant be Empty");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => payment(
            totalPrice: widget.totalPrice,
          ),
        ),
      ).then((result) {
        if (result == true) {
          // Payment successful
          // Save address information and place order
          saveadressInfo();
        } else {
          // Payment failed
          Fluttertoast.showToast(msg: "Payment Failed! Please try again.");
        }
      });
      // saveadressInfo();
    }
  }

  saveadressInfo() async {
    _normalProgress(context);

    DateTime orderTime = DateTime.now();
    adressmodal newadressItem = adressmodal(
      phonenumber: phoneEditingcontroller.text,
      housename: housenameEditingcontroller.text,
      street: streetEditingcontroller.text,
      city: cityEditingcontrolller.text,
      country: countryEditingcontroller.text,
      postalcode: postalcodetEditingcontroller.text,
    );

    Map<String, dynamic> usersadressInfoMap = {
      "phonenumber": phoneEditingcontroller.text.trim(),
      "Housename": housenameEditingcontroller.text.trim(),
      "street": streetEditingcontroller.text.trim(),
      "city": cityEditingcontrolller.text.trim(),
      "country": countryEditingcontroller.text.trim(),
      "postalcode": postalcodetEditingcontroller.text.trim(),
    };

    DatabaseReference userssref =
        FirebaseDatabase.instance.ref().child("users");
//

//
    DatabaseReference userOrdersRef =
        userssref.child(currentFirebaseUser!.uid).child("orders");
//
    var orderId = userOrdersRef.push().key;
//
    print("prolist is + $prolist");
    Map<String, dynamic> orderDetails = {
      "addressDetails": usersadressInfoMap,
      "totalPrice": widget.totalPrice,
      "Status": status,
      "orderedDate": orderTime.millisecondsSinceEpoch,
      "products": widget.prolist.map((cartItem) {
        return {
          "name": cartItem.name,
          "imageAddress": cartItem.imageaddress,
          "itemPrice": cartItem.itemprice,
          "size": cartItem.size,
        };
      }).toList(),
    };
//
    userOrdersRef.child(orderId!).set(orderDetails).then((_) {
      String userId = currentFirebaseUser!.uid;
      Fluttertoast.showToast(msg: "Order placed successfully!!");
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);
      cartProvider.clearCart();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => main_homepage()),
        ModalRoute.withName('/'),
      );
      //
    }).catchError((error) {
      print("Failed to save address: $error");
      Fluttertoast.showToast(msg: "Failed to place order. Please try again.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image.asset("images/cardetails.png"),
                const Text(
                  "Enter Adress Details",
                  style: TextStyle(
                      color: Color.fromARGB(255, 5, 71, 65),
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneEditingcontroller,
                  decoration: const InputDecoration(
                      labelText: "Phone Number",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: housenameEditingcontroller,
                  decoration: const InputDecoration(
                      labelText: "House/Building name",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: streetEditingcontroller,
                  decoration: const InputDecoration(
                      labelText: "street",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: cityEditingcontrolller,
                  decoration: const InputDecoration(
                      labelText: "city",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: postalcodetEditingcontroller,
                  decoration: const InputDecoration(
                      labelText: "postal code",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: countryEditingcontroller,
                  decoration: const InputDecoration(
                      labelText: "State",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 98, 25, 3))),
                      onPressed: () {
                        adressValidation();
                      },
                      child: Text("Place Order", style: const TextStyle(color:Colors.white))
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
