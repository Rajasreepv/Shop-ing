import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/pages/orders/productdetailing.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  List<Map<String, dynamic>> searchResults = [];
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: TextField(
                  controller: searchcontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 40,
                      color: Colors.grey,
                    ),
                    hintText: 'Search..',
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    searchProductByName(value);
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(searchResults[index]
                                    ['image'] ??
                                'No image available'),
                            title: Column(children: [
                              Text(searchResults[index]['name'] ??
                                  'No Name Available'),
                              // Text(searchResults[index]['name']),
                              Text(
                                searchResults[index]['Description'] ??
                                    'No Desc Available',
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ]),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => details(
                                            name: searchResults[index]['name'],
                                            price: searchResults[index]
                                                ['price'],
                                            imageAddress: searchResults[index]
                                                ['image'],
                                            Description: searchResults[index]
                                                ['Description'],
                                          )));
                            },
                          );
                        },
                      )
                    : SizedBox(
                        height: 2,
                      ))
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> searchProductByName(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return searchResults;
    }
    searchResults.clear();

    print(query);
    List<Future<void>> queries = [
      searchCollection('Dress', query, searchResults),
      searchCollection('Shorts', query, searchResults),
      searchCollection('Shirts', query, searchResults),
      // Add more collections if needed
    ];

    // Wait for all queries to complete
    await Future.wait(queries);

    return searchResults;
  }

  Future<void> searchCollection(String collectionName, String query,
      List<Map<String, dynamic>> searchResults) async {
    QuerySnapshot<Map<String, dynamic>> collectionQuery =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('VBWY0LBuo4fl9ZWDmsR8')
            .collection(collectionName)
            .get();
//
    List<Map<String, dynamic>> combinedResults = [];
    QuerySnapshot<Map<String, dynamic>> collectionQuery2 =
        await FirebaseFirestore.instance.collection('feature products').get();
    QuerySnapshot<Map<String, dynamic>> collectionQuery3 =
        await FirebaseFirestore.instance.collection('newAchives').get();

//

    List<Map<String, dynamic>> collectionResults =
        collectionQuery.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> collectionResults2 =
        collectionQuery2.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> collectionResults3 =
        collectionQuery3.docs.map((doc) => doc.data()).toList();

    combinedResults.addAll(collectionResults);
    combinedResults.addAll(collectionResults2);
    combinedResults.addAll(collectionResults3);
    // Filter results based on the query
    List<Map<String, dynamic>> filteredResults = combinedResults
        .where((result) => result['name'].toString().contains(query))
        .toList();
    for (var result in filteredResults) {
      bool isDuplicate =
          searchResults.any((item) => item['name'] == result['name']);
      if (!isDuplicate) {
        searchResults.add(result);
      }
    }
    if (searchResults.length > 4) {
      searchResults = searchResults.sublist(0, 5);
    }
    setState(() {
      searchResults.clear();
      searchResults.addAll(filteredResults);
    });
  }
  // Perform queries for each collection separately
  // QuerySnapshot<Map<String, dynamic>> collection1Query =
  //     await FirebaseFirestore.instance
  //         .collection('category')
  //         .doc('VBWY0LBuo4fl9ZWDmsR8')
  //         .collection('Dress')
  //         .get();
  // searchResults.addAll(collection1Query.docs.map((doc) => doc.data()));
  // searchResults = searchResults
  //     .where((result) => result['name'].toString().contains(query))
  //     .toList();

  // print(searchResults);

  // return searchResults;
}
