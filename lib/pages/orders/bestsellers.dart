import 'package:flutter/material.dart';

class bestsellers extends StatefulWidget {
  const bestsellers({super.key});

  @override
  State<bestsellers> createState() => _bestsellersState();
}

class _bestsellersState extends State<bestsellers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Updating Soon")),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:weatherapp/pages/product_card.dart';
// import 'package:weatherapp/pages/productdetailing.dart';

// import 'dart:ffi';

// class main_homepage extends StatefulWidget {
//   const main_homepage({Key? key}) : super(key: key);

//   @override
//   State<main_homepage> createState() => _main_homepageState();
// }

// class _main_homepageState extends State<main_homepage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: [
//                       Container(
//                         height: 50,
//                         width: 300,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8.0, top: 8),
//                           child: TextField(
//                             decoration: InputDecoration(
//                               prefixIcon: const Icon(
//                                 Icons.search,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                               hintText: 'Search..',
//                               hintStyle: const TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       const Badge(
//                         label: Text('1'),
//                         child: Image(
//                           height: 30,
//                           width: 30,
//                           image: AssetImage(
//                             'assets/icons/img.png',
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       const Badge(
//                         label: Text('9+'),
//                         child: Image(
//                           height: 30,
//                           width: 30,
//                           image: AssetImage(
//                             'assets/icons/chat.png',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Image.asset("assets/images/main.jpg"),
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         "Best Sale Products",
//                         style: TextStyle(
//                             fontSize: 25, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "Show More",
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   // Fetch and Display Firestore Data
//                   FutureBuilder<QuerySnapshot>(
//                     future: FirebaseFirestore.instance
//                         .collection('feature products')
//                         .get(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       } else if (!snapshot.hasData ||
//                           snapshot.data!.docs.isEmpty) {
//                         return Center(child: Text('No data available'));
//                       } else {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: (snapshot.data!.docs.length / 2).ceil(),
//                           itemBuilder: (BuildContext context, int index) {
//                             int firstIndex = index * 2;
//                             int secondIndex = firstIndex + 1;
//                             // Check if the second index is out of bounds
//                             if (secondIndex >= snapshot.data!.docs.length) {
//                               return SizedBox(); // Return an empty container if out of bounds
//                             }
//                             DocumentSnapshot firstDocument =
//                                 snapshot.data!.docs[firstIndex];
//                             DocumentSnapshot secondDocument =
//                                 snapshot.data!.docs[secondIndex];

//                             // Build the layout with two cards in each row
//                             return Row(
//                               children: [
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (c) => details(),
//                                         ),
//                                       );
//                                     },
//                                     child: productcard(
//                                       imageAddress: firstDocument['image'],
//                                       price: firstDocument['price'],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10.0), // Space between cards
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (c) => details(),
//                                         ),
//                                       );
//                                     },
//                                     child: productcard(
//                                       imageAddress: secondDocument['image'],
//                                       price: secondDocument['price'],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'Profile',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.settings),
//                   label: 'Settings',
//                 ),
//               ],
//             )) // Your bottom navigation bar code...
//         );
//   }
// }
