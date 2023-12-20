import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// late double totalPriceOfAllProducts = 0;
// late int numberOfOrders = 0;
double totalPriceOfAllProducts = 0;
int numberOfOrders = 0;

class adOrdersPage extends StatefulWidget {
  @override
  State<adOrdersPage> createState() => _adOrdersPageState();
}

class _adOrdersPageState extends State<adOrdersPage> {
  late List<String> allUserIDs = [];
  late DatabaseReference usersRef;

  @override
  void initState() {
    super.initState();
    usersRef = FirebaseDatabase.instance.ref().child('users');
    getAllUserIDs();
  }

  Future<void> getAllUserIDs() async {
    try {
      DatabaseEvent dataSnapshot = await usersRef.once();

      if (dataSnapshot.snapshot != null) {
        Map<dynamic, dynamic> usersData =
            dataSnapshot.snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          allUserIDs = usersData.keys.cast<String>().toList();
        });
      }
    } catch (error) {
      print('Error fetching user IDs: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: allUserIDs == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allUserIDs.length,
              itemBuilder: (context, index) {
                String userID = allUserIDs[index];
                DatabaseReference userOrdersRef =
                    usersRef.child(userID).child('orders');
                return FutureBuilder(
                    future: usersRef.child(userID).once(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (!snapshot.hasData ||
                          snapshot.data!.snapshot.value == null) {
                        return Center(
                          child: Text('No orders found for $userID'),
                        );
                      }

                      final userData = snapshot.data!.snapshot.value
                          as Map<dynamic, dynamic>;
                      final userName = userData['name'] ?? 'Unknown';
                      return StreamBuilder(
                        stream: userOrdersRef.onValue,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.snapshot.value == null) {
                            return Center(
                              child: Text('No orders found for $userID'),
                            );
                          }

                          final orders = snapshot.data!.snapshot.value
                              as Map<dynamic, dynamic>;
                          final orderIds = orders.keys.toList();

                          return Column(
                            children: orderIds.map((orderId) {
                              final orderData = orders[orderId];
                              final addressDetails =
                                  orderData['addressDetails'];
                              final productList = orderData['products'];
                              final status = orderData['Status'];
                              void updateOrderStatus(String newStatus) {
                                setState(() {
                                  userOrdersRef
                                      .child(orderId)
                                      .update({'Status': newStatus});
                                });
                                // Update the order status in Firebase for the specific orderId
                              }

                              return Card(
                                margin: EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    'Order ID: $orderId',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'User : $userName',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(' STATUS: $status',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.red)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'UserId :  $userID',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 45, 16, 6)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Total Price: \$${orderData['totalPrice']}'),
                                      SizedBox(height: 4),
                                      Text('Address:'),
                                      Text(
                                          'PhoneNumber: ${addressDetails['phonenumber']}'),
                                      Text(
                                          'House/Building: ${addressDetails['Housename']}'),
                                      Text(
                                          'Street: ${addressDetails['street']}'),
                                      Text('City: ${addressDetails['city']}'),
                                      Text(
                                          'Country: ${addressDetails['country']}'),
                                      Text(
                                          'Postal Code: ${addressDetails['postalcode']}'),
                                      SizedBox(height: 8),
                                      Text(
                                        "Change Status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              updateOrderStatus('Ordered');
                                            },
                                            child: Text('Ordered'),
                                          ),
                                          SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              updateOrderStatus('Shipped');
                                            },
                                            child: Text('Shipped'),
                                          ),
                                          SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              updateOrderStatus('Delivered');
                                            },
                                            child: Text('Delivered'),
                                          ),
                                        ],
                                      ),
                                      Text('Products:'),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            productList.map<Widget>((product) {
                                          return ListTile(
                                            title: Text(product['name']),
                                            leading: Image.network(
                                                product['imageAddress']),
                                            subtitle: Text(
                                              'Price: \$${product['itemPrice'].toString()} | Size: ${product['size']}',
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      );
                    });
              },
            ),
    );
  }
}
