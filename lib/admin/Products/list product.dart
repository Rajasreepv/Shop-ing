import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> combinedResults = [];
// int index = 0;
List<bool> isPressedList = [];

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

Color color = Colors.red;
// List<bool> isPressedList = [true];

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
    searchCollection();
  }

  Future<void> searchCollection() async {
    QuerySnapshot<Map<String, dynamic>> collectionQuery =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('VBWY0LBuo4fl9ZWDmsR8')
            .collection('Dress')
            .get();
    print(collectionQuery);
    QuerySnapshot<Map<String, dynamic>> collectionQuery4 =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('VBWY0LBuo4fl9ZWDmsR8')
            .collection('Shirts')
            .get();
    print(collectionQuery4);
    QuerySnapshot<Map<String, dynamic>> collectionQuery5 =
        await FirebaseFirestore.instance
            .collection('category')
            .doc('VBWY0LBuo4fl9ZWDmsR8')
            .collection('Shorts')
            .get();
//
    print(collectionQuery5);
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
    List<Map<String, dynamic>> collectionResults4 =
        collectionQuery4.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> collectionResults5 =
        collectionQuery5.docs.map((doc) => doc.data()).toList();

    setState(() {
      combinedResults.addAll(collectionResults);
      combinedResults.addAll(collectionResults2);
      combinedResults.addAll(collectionResults3);
      combinedResults.addAll(collectionResults4);
      combinedResults.addAll(collectionResults5);
    });
    // print(combinedResults.length);
  }

  @override
  Widget build(BuildContext context) {
    print(combinedResults.length);
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Page'),
        ),
        body: combinedResults.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('SL NO')),
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Stock')),
                    DataColumn(label: Text('Remaining Stock')),
                    DataColumn(label: Text('Visibility')),
                    DataColumn(label: Text('Action')),
                  ],
                  // rows: combinedResults.map((data) {
                  //   int index = combinedResults.indexOf(data) + 1;
                  //   if (isPressedList.length <= index) {
                  //     isPressedList.add(false);
                  //   }
                  rows: List<DataRow>.generate(combinedResults.length, (index) {
                    if (isPressedList.length <= index) {
                      isPressedList.add(false);
                    }
                    Map<String, dynamic> data = combinedResults[index];
                    final isEnabled = data['isEnabled'] ?? false;
                    return DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString())),
                        // DataCell(Text(index.toString())),
                        DataCell(Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.network(data['image'])),
                        )),
                        DataCell(Text(data['name'])),
                        DataCell(Text('${data['stock']}')),
                        DataCell(Text('${data['stock']}')),
                        DataCell(Text(data['isEnabled'] != null
                            ? data['isEnabled'].toString()
                            : 'N/A')), // Update with your field
                        DataCell(
                          ElevatedButton(
                            style: isEnabled
                                ? ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(color))
                                : ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey)),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmation'),
                                    content: Text('Are you sure ?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(
                                              false); // Dismiss the dialog and return false
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(
                                              true); // Dismiss the dialog and return true
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              ).then((value) async {
                                if (value == true) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        content: Row(
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(width: 20),
                                            Text('Loading...'),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  // User clicked Yes, proceed with the action
                                  setState(() {
                                    // !isPressedList[index];
                                    isPressedList[index] =
                                        !isPressedList[index];
                                  });
                                  String productName = data['name'];

                                  QuerySnapshot<Map<String, dynamic>>
                                      Dressnapshot = await FirebaseFirestore
                                          .instance
                                          .collection('category')
                                          .doc('VBWY0LBuo4fl9ZWDmsR8')
                                          .collection('Dress')
                                          .where('name', isEqualTo: productName)
                                          .get();
                                  QuerySnapshot<Map<String, dynamic>>
                                      snapshotShirts = await FirebaseFirestore
                                          .instance
                                          .collection('category')
                                          .doc('VBWY0LBuo4fl9ZWDmsR8')
                                          .collection('Shirts')
                                          .where('name', isEqualTo: productName)
                                          .get();
                                  QuerySnapshot<Map<String, dynamic>>
                                      snapshotshorts = await FirebaseFirestore
                                          .instance
                                          .collection('category')
                                          .doc('VBWY0LBuo4fl9ZWDmsR8')
                                          .collection('Shorts')
                                          .where('name', isEqualTo: productName)
                                          .get();
                                  QuerySnapshot<Map<String, dynamic>> feature =
                                      await FirebaseFirestore.instance
                                          .collection('feature products')
                                          .where('name', isEqualTo: productName)
                                          .get();
                                  QuerySnapshot<Map<String, dynamic>> archives =
                                      await FirebaseFirestore.instance
                                          .collection('newAchives')
                                          .where('name', isEqualTo: productName)
                                          .get();
                                  if (Dressnapshot.docs.isNotEmpty) {
                                    // Update the first found document (you may need additional logic if multiple documents have the same name)
                                    DocumentReference docRef =
                                        Dressnapshot.docs[0].reference;
                                    // Map<String, dynamic> docdata1 =
                                    //     Dressnapshot.docs[0].data();

                                    await docRef.update({
                                      'isEnabled': isPressedList[index],
                                    });
                                    setState(() {
                                      data['isEnabled'] = isPressedList[index];
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  if (snapshotshorts.docs.isNotEmpty) {
                                    // Update the first found document (you may need additional logic if multiple documents have the same name)
                                    DocumentReference docRef =
                                        snapshotshorts.docs[0].reference;
                                    await docRef.update({
                                      'isEnabled': isPressedList[index],
                                    });
                                    setState(() {
                                      data['isEnabled'] = isPressedList[index];
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  if (snapshotShirts.docs.isNotEmpty) {
                                    // Update the first found document (you may need additional logic if multiple documents have the same name)
                                    DocumentReference docRef =
                                        snapshotShirts.docs[0].reference;
                                    await docRef.update({
                                      'isEnabled': isPressedList[index],
                                    });
                                    setState(() {
                                      data['isEnabled'] = isPressedList[index];
                                      ;
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  if (feature.docs.isNotEmpty) {
                                    // Update the first found document (you may need additional logic if multiple documents have the same name)
                                    DocumentReference docRef =
                                        feature.docs[0].reference;
                                    await docRef.update({
                                      'isEnabled': isPressedList[index],
                                    });
                                    setState(() {
                                      data['isEnabled'] = isPressedList[index];
                                      ;
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  if (archives.docs.isNotEmpty) {
                                    // Update the first found document (you may need additional logic if multiple documents have the same name)
                                    DocumentReference docRef =
                                        archives.docs[0].reference;
                                    await docRef.update({
                                      'isEnabled': isPressedList[index],
                                    });
                                    setState(() {
                                      data['isEnabled'] = isPressedList[index];
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  // Add Firestore update logic here
                                }
                              });
                              ;

                              // Add your logic to disable the product here
                            },
                            child: Text(
                              'Disable',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ));
  }
}
