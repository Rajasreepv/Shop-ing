import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/authentication/adress.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/modals/cartModel.dart';
import 'package:weatherapp/pages/checkout/checkoutcard.dart';
import 'package:weatherapp/pages/provider/cart_provider.dart';

// final checkoutpagevar = checkoutpage();

class cartpage extends StatefulWidget {
  cartpage({super.key});
// required this.list
  @override
  State<cartpage> createState() => _cartpageState();
}

List<cartmodel> prolist = [];
String uid = fAuth.currentUser!.uid;

class _cartpageState extends State<cartpage> {
  List<cartmodel> retrievedCartList = [];
  @override
  void initState() {
    super.initState();

    // retrieveCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      double productsPrice = cartProvider.calculateProductPrice();
      double totalPrice = cartProvider.calculateFinalPrice();
      List<cartmodel> cartItems = cartProvider.cartItems;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 98, 25, 3),
          leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(Icons.arrow_back),
    ),
          title: Text("Checkout",  style: const TextStyle(
              
              color:Colors.white
            )),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 300,
                child: checkoutpage(),
              ),
            ),
            Column(
              children: <Widget>[
                _buildBottomdetails(
                    startname: "Your price", endname: productsPrice.toString()),
                _buildBottomdetails(startname: "Discount", endname: " - \$10"),
                _buildBottomdetails(startname: "Shipping", endname: " +   \$5"),
                _buildBottomdetails(
                    startname: "Total", endname: totalPrice.toString())
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 98, 25, 3))),
                  onPressed: () {
                    if (cartItems.isEmpty) {
                      Fluttertoast.showToast(msg: "Add items to Cart");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => adressScreen(
                                    prolist: cartItems,
                                    totalPrice: totalPrice,
                                  )));
                    }
                  },
                  child: Text("Add Address ", style: const TextStyle(
              
              color:Colors.white
            ))),
            )
          ],
        ),
      );
    });
  }
}

Widget _buildBottomdetails(
    {required String startname, required String endname}) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startname,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(endname,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ))
      ],
    ),
  );
}
