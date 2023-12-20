import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/authentication/Login.dart';
import 'package:weatherapp/pages/checkout/nonlogincheckout.dart';
import 'package:weatherapp/pages/coupons.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/helpcenter.dart';
import 'package:weatherapp/pages/main_homepage.dart';
import 'package:weatherapp/pages/nonloginprofile.dart';
import 'package:weatherapp/pages/orders/orders.dart';
import 'package:weatherapp/pages/rateus.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

String userName = '';

class _profileState extends State<profile> {
  bool isBlocked = false;
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("NULLLLLLLLL");

        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => Login()),
        //   (route) => false,
        // );
      } else {
        // String userId = currentFirebaseUser!.uid;
        // retrieveUserName(userId);
        retrieveUserData(user);
      }
    });
  }

  Future<void> retrieveUserData(User user) async {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
    try {
      DataSnapshot snapshot = await usersRef.child(user.uid).get();
      if (snapshot.value != null) {
        Map<dynamic, dynamic> userData =
            snapshot.value as Map<dynamic, dynamic>;
        bool blocked = userData['blocked'] ?? false;
        setState(() {
          isBlocked = blocked;
        });
        retrieveUserName(user.uid);
      } else {
        print('User data not found');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }
 

  Future<void> retrieveUserName(String userId) async {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
    try {
      DataSnapshot snapshot = await usersRef.child(userId).get();
      if (snapshot.value != null) {
        Map<dynamic, dynamic> userData =
            snapshot.value as Map<dynamic, dynamic>;

        String? name = userData['name'];
        setState(() {
          userName = name ?? '';
        });
      } else {
        print('User does not exist');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: isBlocked
          ? Center(
              child: Text(
                "You are blocked. Cannot access this feature.",
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 246, 246, 198),
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        height: 100,
                        child: Container(
                          // Adjust radius as needed

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 246, 246, 198),
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                                radius: 50,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Hey!  ${userName.length > 7 ? userName.substring(0, 6) : userName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(width: 15),
                              TextButton(
                                  onPressed: () async {
                                    await fAuth.signOut();Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => Login()),
  (Route<dynamic> route) => false,
);
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //   MaterialPageRoute(
                                    //       builder: (c) => Login()),
                                    //   (route) => false,
                                    // );
                                  },
                                  child: Text(
                                    "Signout",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ]),
                          ),
                        ),
                      )),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10, // Spacing between columns
                        mainAxisSpacing: 10, // Spacing between rows
                        // childAspectRatio: 0.9, // Width / Height ratio for each item
                      ),
                      itemCount:
                          4, // Replace 'itemCount' with the actual number of items
                      itemBuilder: (BuildContext context, int index) {
                        // Your custom text for each box based on the index
                        List<Map<String, dynamic>> iconTextList = [
                          {"icon": Icons.add_box_outlined, "text": "Orders"},
                          {"icon": Icons.gif_box_outlined, "text": "Coupons"},
                          {
                            "icon": Icons.headphones_outlined,
                            "text": "Help Center"
                          },
                          {"icon": Icons.reviews_outlined, "text": "Rate Us"},
                        ];
                        // String userId = currentFirebaseUser!.uid;
                        IconData iconData = iconTextList[index]['icon'];
                        String labelText = iconTextList[index]['text'];
                        return SizedBox(
                            child: Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 2, color: Colors.grey)),
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 80,
                                    child: ListTile(
                                      onTap: () {
                                        FirebaseAuth.instance
                                            .authStateChanges()
                                            .listen((User? user) {
                                          if (user == null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        nonloginprofile(
                                                          page: "Orders",
                                                        )));
                                            print('User is signed out.');
                                            // Redirect to login or perform actions for non-logged-in user
                                          } else {
                                            if (index == 0) {
                                              // Navigate to OrdersPage
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrdersPage(
                                                          userID: user.uid,
                                                        )),
                                              );
                                            } else if (index == 1) {
                                              // Navigate to CouponsPage
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CouponsPage()),
                                              );
                                            } else if (index == 2) {
                                              // Navigate to CouponsPage
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HelpCenterPage()),
                                              );
                                            } else if (index == 3) {
                                              // Navigate to CouponsPage
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RateUsPage()),
                                              );
                                            }
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (c) => OrdersPage(
                                            //             userID: user.uid)));
                                            // // User is signed in
                                            print(
                                                'User is signed in: ${user.uid}');
                                            // Perform actions for logged-in user
                                          }
                                        });
                                      },
                                      leading: Icon(
                                        iconData,
                                        color: const Color.fromARGB(
                                            255, 186, 78, 39),
                                      ),
                                      title: Text(
                                        labelText,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))));

                        // Other content or styling for each grid item
                      },
                    ),
                  )
                ],
              ),
            ),
    ));
  }
}
// onPressed: () {
//                   String userId = currentFirebaseUser!.uid;
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (c) => OrdersPage(userID: userId)));
//                 }
// onPressed: () {
//           fAuth.signOut();
//           Navigator.push(context,
//               MaterialPageRoute(builder: (c) => main_homepage()

// class _profileState extends State<profile> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(28.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   width: double.infinity,
//                   height: 150,
//                   child: Row(
//                     children: [],
//                   ),
//                 ),
//               ),
//               CircleAvatar(
//                 child: Icon(
//                   Icons.person,
//                   size: 50,
//                 ),
//                 radius: 50,
//               ),
//               SizedBox(height: 5),
//               Text("Username"),
//               TextButton(child: Text("Help"), onPressed: () {}),
//               TextButton(
//                 onPressed: () {
//                   // Your onPressed logic for orders button
//                 },
//                 child: Text("Orders"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// //
// , Container(
//       alignment: Alignment.topLeft,
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 150,
//             child: Row(
//               children: [],
//             ),
//           ),
//           CircleAvatar(
//             child: Icon(
//               Icons.person,
//               size: 50,
//             ),
//             radius: 50,
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text("Username"),
//           TextButton(child: Text("Help"), onPressed: () {}),
//           TextButton(
//               onPressed: () {
//                 FirebaseAuth.instance.authStateChanges().listen((User? user) {
//                   if (user == null) {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (c) => nonlogincheckout()));
//                     print('User is signed out.');
//                     // Redirect to login or perform actions for non-logged-in user
//                   } else {
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (c) => cartpage()));

//                     String userId = currentFirebaseUser!.uid;
//                     print(userId);
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (c) => OrdersPage(userID: userId)));
//                   }
//                 });
//               },
//               child: Text("Orders")),
//         ],
//       ),
//     )
