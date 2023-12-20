// // class _checkoutpageState extends State<checkoutpage> {
// //   List<cartmodel> retrievedCartList = [];

// //   @override
// //   void initState() {
// //     retrieveCartData();
// //   }

// //   Future<void> retrieveCartData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? cartListJson = prefs.getString("cartList");
// //     if (cartListJson != null) {
// //       List<dynamic> cartListDecoded = json.decode(cartListJson);

// //       for (var itemJson in cartListDecoded) {
// //         cartmodel item = cartmodel(
// //           name: itemJson['name'],
// //           imageaddress: itemJson['imageaddress'],
// //           itemprice: itemJson['itemprice'],
// //           size: itemJson['size'],
// //           quantity: itemJson['quantity'],
// //         );
// //         retrievedCartList.add(item);
// //       }

// //       setState(() {});
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 230,
// //       width: double.infinity,
// //       child: Card(
// //         child: ListView.builder(
// //           itemCount: retrievedCartList.length,
// //           itemBuilder: (BuildContext context, int index) {
// //             cartmodel item = retrievedCartList[index];
// //             return ListTile(
// //               leading:
// //                   Image.network(item.imageaddress), // Use proper image source
// //               title: Text(item.name),
// //               subtitle: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('Size: ${item.size}'),
// //                   Text('Price: \$${item.itemprice.toString()}'),
// //                 ],
// //               ),
// //               trailing: Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   IconButton(
// //                     onPressed: () {
// //                       setState(() {
// //                         count = count - 1;
// //                       });
// //                     },
// //                     icon: Icon(Icons.remove),
// //                   ),
// //                   Text(count.toString()),
// //                   IconButton(
// //                     onPressed: () {
// //                       setState(() {
// //                         count = count + 1;
// //                       });
// //                     },
// //                     icon: Icon(Icons.add),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// class MainHomepage extends StatefulWidget {
//   const MainHomepage({Key? key}) : super(key: key);

//   @override
//   State<MainHomepage> createState() => _MainHomepageState();
// }

// class _MainHomepageState extends State<MainHomepage> {
//   List<Map<String, dynamic>> searchResults = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // ... Existing code remains unchanged ...

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               // ... Existing code remains unchanged ...

//               // Search input field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.search,
//                       size: 40,
//                       color: Colors.grey,
//                     ),
//                     hintText: 'Search..',
//                     hintStyle: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     searchProductByName(value);
//                     setState(() {}); // Trigger a rebuild to display results
//                   },
//                 ),
//               ),

//               // Search suggestions based on searchResults
//               if (searchResults.isNotEmpty)
//                 Container(
//                   height: 200, // Adjust height as needed
//                   child: ListView.builder(
//                     itemCount: searchResults.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(searchResults[index]['name']),
//                         onTap: () {
//                           // Perform actions when a suggestion is tapped
//                         },
//                       );
//                     },
//                   ),
//                 ),

//               // ... Other parts of your UI ...
//             ],
//           ),
//         ),
//         // ... Other parts of your Scaffold ...
//       ),
//     );
//   }
// class MainHomepage extends StatefulWidget {
//   const MainHomepage({Key? key}) : super(key: key);

//   @override
//   State<MainHomepage> createState() => _MainHomepageState();
// }

// class _MainHomepageState extends State<MainHomepage> {
//   List<Map<String, dynamic>> searchResults = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // ... Existing code remains unchanged ...

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               // ... Existing code remains unchanged ...

//               // Search input field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.search,
//                       size: 40,
//                       color: Colors.grey,
//                     ),
//                     hintText: 'Search..',
//                     hintStyle: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     searchProductByName(value);
//                     setState(() {}); // Trigger a rebuild to display results
//                   },
//                 ),
//               ),

//               // Search suggestions based on searchResults
//               if (searchResults.isNotEmpty)
//                 Container(
//                   height: 200, // Adjust height as needed
//                   child: ListView.builder(
//                     itemCount: searchResults.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(searchResults[index]['name']),
//                         onTap: () {
//                           // Perform actions when a suggestion is tapped
//                         },
//                       );
//                     },
//                   ),
//                 ),

//               // ... Other parts of your UI ...

//             ],
//           ),
//         ),
//         // ... Other parts of your Scaffold ...
//       ),
//     );
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     // ... Existing code remains unchanged ...

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               // ... Existing code remains unchanged ...

//               // Search input field
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.search,
//                       size: 40,
//                       color: Colors.grey,
//                     ),
//                     hintText: 'Search..',
//                     hintStyle: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     searchProductByName(value);
//                     setState(() {}); // Trigger a rebuild to display results
//                   },
//                 ),
//               ),

//               // Search suggestions based on searchResults
//               if (searchResults.isNotEmpty)
//                 Container(
//                   height: 200, // Adjust height as needed
//                   child: ListView.builder(
//                     itemCount: searchResults.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(searchResults[index]['name']),
//                         onTap: () {
//                           // Perform actions when a suggestion is tapped
//                         },
//                       );
//                     },
//                   ),
//                 ),

//               // ... Other parts of your UI ...

//             ],
//           ),
//         ),
//         // ... Other parts of your Scaffold ...
//       ),
//     );
//   }

  