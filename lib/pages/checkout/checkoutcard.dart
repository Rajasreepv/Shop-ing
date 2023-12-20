import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/modals/cartModel.dart';
import 'package:weatherapp/pages/orders/cartpage.dart';
import 'package:weatherapp/pages/provider/cart_provider.dart';

class checkoutpage extends StatefulWidget {
  // final Function() onQuantityChanged;required this.onQuantityChanged
  checkoutpage({
    super.key,
  });

  @override
  State<checkoutpage> createState() => _checkoutpageState();
}

int count = 1;
// double amount;
List<cartmodel> cartItems = [];
String uid = fAuth.currentUser!.uid;

class _checkoutpageState extends State<checkoutpage> {
  List<cartmodel> retrievedCartList = [];

  @override
  void initState() {
    super.initState();
    // retrieveCartData();
  }
 

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    cartItems = cartProvider.cartItems;
    return Column(children: [
      Container(
        height: 300,
        width: double.infinity,
        child: Card(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              cartmodel item = cartItems[index];
              if (item.quantity == 0) {
                return SizedBox.shrink();
              }
              return Column(children: [
                ListTile(
                  leading: Image.network(
                      item.imageaddress), // Use proper image source
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Size: ${item.size}'),
                      Text('Price: \$${item.itemprice.toString()}',style: TextStyle(
    fontWeight: FontWeight.bold,
  
  )),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartProvider.decreaseQuantity(index);
                           
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartProvider.increaseQuantity(index);
                          });
                          
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Quantity"),
                    SizedBox(
                      width: 10,
                    ),
                    Text(item.quantity.toString())
                  ],
                )
              ]);
            },
          ),
        ),
      ),
    ]);
  }
}


















//  Card(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 children: [
//                   Container(
//                     height: 170,
//                     width: 120,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             fit: BoxFit.fill, image: NetworkImage(""))),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 38.0),
//                     child: Container(
//                       // height: 200,//recent
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(name),
//                           Text(
//                             "Clothes",
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Text(
//                             "\$ " + itemprice.toString(),
//                             style: TextStyle(color: Colors.red, fontSize: 20),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Quantity :",
//                               ),
//                               Text(count.toString()),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Size :",
//                               ),
//                               Text(size),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.green,
//                             ),
//                             child: Row(
//                               children: [
//                                 IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         count = count - 1;
//                                       });
//                                     },
//                                     icon: Icon(Icons.remove)), // First icon
//                                 SizedBox(
//                                     width:
//                                         8), // Space between first icon and text
//                                 Text(count.toString()), // Text
//                                 SizedBox(
//                                     width:
//                                         8), // Space between text and second icon
//                                 IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         count = count + 1;
//                                         // widget.itemprice = amount * count;
//                                       });
//                                     },
//                                     icon: Icon(Icons.add)),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ]),
//       ),





///////checjout
///
///Widget build(BuildContext context) {
    // CartProvider cartProvider =
    //     Provider.of<CartProvider>(context, listen: false);

    // final cartItems = cartProvider.cartItems;
    // return Column(children: [
    //   Container(
    //     height: 300,
    //     width: double.infinity,
    //     child: Card(
    //       child: ListView.builder(
    //         itemCount: retrievedCartList.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           cartmodel item = retrievedCartList[index];
    //           if (item.quantity == 0) {
    //             return SizedBox.shrink();
    //           }
    //           return Column(children: [
    //             ListTile(
    //               leading: Image.network(
    //                   item.imageaddress), // Use proper image source
    //               title: Text(item.name),
    //               subtitle: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text('Size: ${item.size}'),
    //                   Text('Price: \$${item.itemprice.toString()}'),
    //                 ],
    //               ),
    //               trailing: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   IconButton(
    //                     onPressed: () {
    //                       setState(() {
    //                         if (item.quantity > 0) {
    //                           item.quantity--;
    //                           // calculateprice();
    //                         }
    //                       });
    //                     },
    //                     icon: Icon(Icons.remove),
    //                   ),
    //                   IconButton(
    //                     onPressed: () {
    //                       setState(() {
    //                         if (item.quantity >= 0) {
    //                           item.quantity++;
    //                           // calculateprice();
    //                         }
    //                       });
    //                     },
    //                     icon: Icon(Icons.add),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Row(
    //               children: [
    //                 Text("Quantity"),
    //                 SizedBox(
    //                   width: 10,
    //                 ),
    //                 Text(item.quantity.toString())
    //               ],
    //             )
    //           ]);
    //         },
    //       )