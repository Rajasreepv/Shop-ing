import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weatherapp/pages/modals/cartModel.dart';

late DatabaseReference ordersRef;
late Stream<QuerySnapshot> ordersStream;


class OrdersPage extends StatefulWidget {
  final String userID;
  OrdersPage({required this.userID, Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    ordersRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(widget.userID)
        .child('orders');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder(
        stream: ordersRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(
              child: Text('No orders found.'),
            );
          }

          final orders = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final orderIds = orders.keys.toList();
          print(orders);
          return Container(
            height: 900,
            child: ListView.builder(
              itemCount: orderIds.length,
              itemBuilder: (context, index) {
                final orderId = orderIds[index];
                final orderData = orders[orderId];

                final addressDetails = orderData['addressDetails'];
                final productList = orderData['products'];
                final status = orderData['Status'];
                final orderedDateTimestamp = orderData['orderedDate'] as int;
                final orderedDateTime =
                    DateTime.fromMillisecondsSinceEpoch(orderedDateTimestamp);
                String formattedDate =
                    "${orderedDateTime.day}/${orderedDateTime.month}/${orderedDateTime.year}";
                print(productList);
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Order ID: $orderId'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Amount:  ${orderData['totalPrice']}'),
                        SizedBox(height: 4),
                        Text(
                          'Status: $status',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(height: 4),
                        Text("Date of order :$formattedDate"),
                        SizedBox(height: 4),
                        Text('Shipping Details',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Contact: ${addressDetails['phonenumber']}'),
                        Text('${addressDetails['Housename']}'),
                        Text('${addressDetails['street']}'),
                        Text('${addressDetails['city']}'),
                        Text(
                            '${addressDetails['country']} ${addressDetails['postalcode']} '),
                        // Text('${addressDetails['postalcode']}'),
                        SizedBox(height: 8),
                        Text(
                          ' Expected date of delivery : 5 to 6 days',
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(height: 8),
                        Text('Products:'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: productList.map<Widget>((product) {
                            return ListTile(
                              title: Text(product['name']),
                              leading: Image.network(product['imageAddress']),
                              subtitle: Text(
                                'Price: \$${product['itemPrice'].toString()} | Size: ${product['size']}  ',
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


