import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/authentication/Login.dart';
import 'package:weatherapp/pages/modals/cartModel.dart';
import 'package:weatherapp/pages/nonloginprofile.dart';
import 'package:weatherapp/pages/notification.dart';
import 'package:weatherapp/pages/orders/cartpage.dart';
import 'package:weatherapp/pages/apparelcategory.dart';
import 'package:weatherapp/pages/checkout/nonlogincheckout.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/modals/productmodal.dart';
import 'package:weatherapp/pages/orders/orders.dart';
import 'package:weatherapp/pages/orders/product_card.dart';
import 'package:weatherapp/pages/orders/productdetailing.dart';
import 'package:weatherapp/pages/profile.dart';
import 'package:weatherapp/pages/provider/cart_provider.dart';

import 'package:weatherapp/pages/provider/product_provider.dart';
import 'package:weatherapp/pages/searchitems.dart';

class main_homepage extends StatefulWidget {
  const main_homepage({Key? key}) : super(key: key);

  @override
  State<main_homepage> createState() => _main_homepageState();
}

int count = 0;

List<cartmodel> cartItems = [];
// TextEditingController searchcontroller = TextEditingController();
bool isLoggedIn = false;

class _main_homepageState extends State<main_homepage> {
  @override
  void initState() {
    super.initState();
    checkAuthState();
    getcartcount();
    // retrieveCartData();
  }

  void checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("YES");
        isLoggedIn = false;
        // Navigate to the login page if the user is not logged in
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Login()),
        // );
      } else {
        setState(() {
          isLoggedIn = true;
          // isLoggedIn = user != null;
        });
      }
      
    });
  }

  void getcartcount() async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);

    setState(() {
      count = cartProvider.cartItems.length;
      print(count);
   
    });
  }

  @override
  Widget build(BuildContext context) {
    product_provider productProvider =
        Provider.of<product_provider>(context, listen: false);
    productProvider.getproductdata();
    productProvider.getArchivesdata();
    List<product> featureproduct = productProvider.getproductList;
    List<product> Achivesproduct = productProvider.getArchivesList;
    List<product> snapshot = productProvider.getproductList;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: 220,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => searchpage()));
                              },
                              child: Text(
                                "Search",
                                style: TextStyle(),
                              )),
                        ),
                      ),
                      Visibility(
                        visible: !isLoggedIn,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (c) => Login()));
                              print("CLICKED");
                            },
                            icon: Icon(Icons.login_outlined)),
                      ),
                      Visibility(
                        visible: isLoggedIn,
                        child: IconButton(
                            onPressed: () {
                              fAuth.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => main_homepage()));
                              print("CLICKED");
                             
                            },
                            icon: Icon(Icons.logout)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user == null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => nonlogincheckout()));
                              print('User is signed out.');
                              // Redirect to login or perform actions for non-logged-in user
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => cartpage()));
                              // User is signed in
                              print('User is signed in: ${user.uid}');
                              // Perform actions for logged-in user
                            }
                          });
                          print("checkouticon");
                        },
                        child: Container(
                          child: Badge(
                            label: Text(count.toString()),
                            child: Image(
                              height: 30,
                              width: 30,
                              image: AssetImage(
                                'assets/icons/img.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => notifications()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Badge(
                            label: Text('0+'),
                            child: Image(
                              height: 30,
                              width: 30,
                              image: AssetImage(
                                'assets/icons/chat.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset("assets/images/main.jpg"),
                  ),
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _category(context),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Best Sale Products",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 2.0,
                        ),
                        child: Container(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Two tiles per row
                              // crossAxisSpacing: 2.0,
                              // mainAxisSpacing: 2.0,
                            ),
                            itemCount: featureproduct.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => details(
                                                name:
                                                    featureproduct[index].name,
                                                price:
                                                    featureproduct[index].price,
                                                imageAddress:
                                                    featureproduct[index].image,
                                               Description:
                                                    featureproduct[index].Description,
                                              )));
                                },
                                child: productcard(
                                    imageAddress: featureproduct[index].image,
                                    price: featureproduct[index].price,
                                    name: featureproduct[index].name),
                              );
                              
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "New Archives",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                 Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Container(height:450,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Two tiles per row
                              // crossAxisSpacing: .0,
                              // mainAxisSpacing: 2.0,
                            ),
                            itemCount: Achivesproduct.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => details(
                                                name:
                                                    Achivesproduct[index].name,
                                                price:
                                                    Achivesproduct[index].price,
                                                imageAddress:
                                                    Achivesproduct[index].image,
                                                Description:
                                                    Achivesproduct[index]
                                                        .Description,
                                              )));
                                },
                                child: productcard(
                                    imageAddress: Achivesproduct[index].image,
                                    price: Achivesproduct[index].price,
                                    name: Achivesproduct[index].name),
                              );
                             
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () async {
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) {
                          if (user == null) {
                            print("NULL USER");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) =>
                                        nonloginprofile(page: "Profile")));
                            print('User is signed out.');
                            // Redirect to login or perform actions for non-logged-in user
                          } else {
                            // String userId = currentFirebaseUser!.uid;
                            // print(userId);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) => profile()));
                          }
                        });
                      }
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (c) => profile()));
                      ,
                      child: Icon(Icons.person)),
                  label: 'Profile',
                ),
               
              ],
            )) 
        );
  }
}

Widget _category(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => apparel(value: 1)));
            },
            icon: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 227, 227, 178),
                child: Image.asset("assets/icons/shirt.png"))),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => apparel(value: 2)));
            },
            icon: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 227, 227, 178),
                child: Image.asset(
                  "assets/icons/dress.png",
                ))),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => apparel(value: 3)));
            },
            icon: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 227, 227, 178),
                child: Image.asset("assets/icons/pants.png"))),
      ],
    ),
  );
}

