import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/admin/Products/addproduct.dart';
import 'package:weatherapp/admin/Products/list%20product.dart';
import 'package:weatherapp/admin/listusers.dart';
import 'package:weatherapp/admin/orders/allorders.dart';
import 'package:weatherapp/authentication/Login.dart';
import 'package:weatherapp/authentication/adress.dart';
import 'package:weatherapp/pages/global/global.dart';

late List<String> allUserIDs = [];
late DatabaseReference usersRef;
double totalPriceOfAllProducts = 0.0;
double numberOfOrders = 0;

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

final customStyle = TextStyle(
    fontSize: 16.0,
    fontStyle: FontStyle.italic,
    color: Colors.white,
    fontWeight: FontWeight.bold);

class _dashboardState extends State<dashboard> {
  Future<void> fetchData() async {
    await getAllUserIDs(); // Wait for user IDs to be fetched
    calculateOrderTotals(); // Calculate totals after fetching IDs
  }

  void calculateOrderTotals() async {
    double totalPrice = 0;
    int ordersCount = 0;

    for (String userID in allUserIDs) {
      DatabaseReference userOrdersRef = usersRef.child(userID).child('orders');
      // DataSnapshot snapshot = await userOrdersRef.once() as DataSnapshot;
      DatabaseEvent event = await userOrdersRef.once() as DatabaseEvent;

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? orders =
            event.snapshot.value as Map<dynamic, dynamic>?;

        if (orders != null) {
          orders.forEach((orderId, orderData) {
            if (orderData['totalPrice'] is String) {
              totalPrice += double.tryParse(orderData['totalPrice']) ?? 0;
            } else if (orderData['totalPrice'] is double) {
              totalPrice += orderData['totalPrice'];
            }
            // totalPrice += double.tryParse(orderData['totalPrice'] ?? '0') ?? 0;

            ordersCount++;
          });
          // print(totalPrice);
        }
      }
    }
    if (mounted) {
      setState(() {
        totalPriceOfAllProducts = totalPrice;
        numberOfOrders = ordersCount.toDouble();
      });
    }

    // setState(() {
    //   totalPriceOfAllProducts = totalPrice;
    //   numberOfOrders = ordersCount.toDouble();
    // });
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
  void initState() {
    super.initState();
    usersRef = FirebaseDatabase.instance.ref().child('users');
    fetchData();
    // calculateOrderTotals();
    // getAllUserIDs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Image.asset(
              'assets/images/icon.jpg',
              width: 100.0, // Increase this value to desired size
              height: 100.0, // Increase this value to desired size
              fit: BoxFit.cover,
            ),
          ),
          title: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Shop-ing",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromARGB(255, 91, 29, 25)),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              child: Text(
                "Welcome to Admin Dashboard",
                style: TextStyle(
                    // TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromARGB(255, 91, 29, 25)),
              ),
            ),
            Expanded(
              child: Row(children: [
                SizedBox(
                  height: 20,
                ),
                // Navigation Bar
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: NavigationDrawer(
                      backgroundColor: const Color.fromARGB(255, 83, 26, 5),
                      width: 200.0, // Adjust width
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => dashboard()));
                                // Handle navigation click
                              },
                              child: Text(
                                'HOME',
                                style: customStyle,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => UserManagementPage()));
                                // Handle navigation click
                              },
                              child: Text('ALL USERS', style: customStyle),
                            ),
                            // Add your navigation items
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => productform()));
                                // Handle navigation click
                              },
                              child: Text('ADD PRODUCT', style: customStyle),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => AdminPage()));
                                // Handle navigation click
                              },
                              child: Text('LIST PRODUCTS', style: customStyle),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => adOrdersPage()));
                                // Handle navigation click
                              },
                              child: Text('ALL ORDERS', style: customStyle),
                            ),
                            TextButton(
                              onPressed: () {
                                fAuth.signOut();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (c) => Login()));
                                // Handle navigation click
                              },
                              child: Text('SIGNOUT', style: customStyle),
                            )

                            // ... Add more items
                          ])),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 800.0),
                        child: ListTile(
                          title: Text(
                            "Total Sales ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "\$$totalPriceOfAllProducts",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          leading: Image.asset(
                            'assets/images/sales.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: ListTile(
                          title: Text(
                            "Total Orders ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text("$numberOfOrders",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600)),
                          leading: Image.asset('assets/images/orders.png'),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ));
  }
}

class NavigationDrawer extends StatelessWidget {
  final Color backgroundColor;
  final double width;
  final Widget child;
  const NavigationDrawer({
    Key? key,
    required this.backgroundColor,
    required this.width,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: backgroundColor,
        width: width,
        child: child,
      ),
    );
  }
}

class data extends StatefulWidget {
  const data({super.key});

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
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

                            return SizedBox();
                          });
                    });
              },
            ),
    );
    ;
  }
}
