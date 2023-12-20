import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/pages/modals/productmodal.dart';

class category_provider with ChangeNotifier {
  List<product> shirt = [];
  List<product> dress = [];

  List<product> shorts = [];

  List<product> pant = [];
  bool _dataLoaded = false;
  bool get dataLoaded => _dataLoaded;
  Future<void> fetchData() async {
    await getshirtdata();
    await getdressdata();
    await getshortsdata();
    await getpantdata();
    _dataLoaded = true;
    notifyListeners();
  }

  Future getshirtdata() async {
    List<product> newList = [];
    QuerySnapshot<Map<String, dynamic>> shirtsnapshop = await FirebaseFirestore
        .instance
        .collection('category')
        .doc('VBWY0LBuo4fl9ZWDmsR8')
        .collection('Shirts')
        .where('isEnabled', isEqualTo: true)
        .get();

    shirtsnapshop.docs.forEach(
      (element) {
        product Shirtdata = product(
            image: element['image'],
            name: element['name'],
            price: element['price'],
            Description: element['Description']);
        newList.add(Shirtdata);
        print(newList);
      },
    );
    shirt = newList;

    notifyListeners();
  }

  Future getdressdata() async {
    List<product> newList = [];
    QuerySnapshot<Map<String, dynamic>> dresssnapshop = await FirebaseFirestore
        .instance
        .collection('category')
        .doc('VBWY0LBuo4fl9ZWDmsR8')
        .collection('Dress')
        .where('isEnabled', isEqualTo: true)
        .get();

    dresssnapshop.docs.forEach(
      (element) {
        product dressdata = product(
            image: element['image'],
            name: element['name'],
            price: element['price'],
            Description: element['Description']);
        newList.add(dressdata);
        print(newList);
      },
    );
    dress = newList;

    notifyListeners();
  }

  Future getpantdata() async {
    List<product> newList = [];
    QuerySnapshot<Map<String, dynamic>> pantsnapshop = await FirebaseFirestore
        .instance
        .collection('category')
        .doc('VBWY0LBuo4fl9ZWDmsR8')
        .collection('Pants')
        .where('isEnabled', isEqualTo: true)
        .get();

    pantsnapshop.docs.forEach(
      (element) {
        product pantdata = product(
            image: element['image'],
            name: element['name'],
            price: element['price'],
            Description: element['Description']);
        newList.add(pantdata);
        print(newList);
      },
    );
    pant = newList;

    notifyListeners();
  }

  Future getshortsdata() async {
    List<product> newList = [];
    QuerySnapshot<Map<String, dynamic>> shortssnapshop = await FirebaseFirestore
        .instance
        .collection('category')
        .doc('VBWY0LBuo4fl9ZWDmsR8')
        .collection('Shorts')
        .where('isEnabled', isEqualTo: true)
        .get();

    shortssnapshop.docs.forEach(
      (element) {
        product Shortdata = product(
            image: element['image'],
            name: element['name'],
            price: element['price'],
            Description: element['Description']);
        newList.add(Shortdata);
        print(newList);
      },
    );
    shorts = newList;

    notifyListeners();
  }

  ///////////
  List<product> get getShirtList {
    // getshirtdata();

    return shirt;
  }

  List<product> get getDressList {
    // getdressdata();

    return dress;
  }

  List<product> get getShortList {
    // getshortsdata();

    return shorts;
  }

  List<product> get getpantList {
    // getpantdata();

    return pant;
  }
}
