import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/pages/modals/productmodal.dart';

class product_provider with ChangeNotifier {
  List<product> Product = [];
  List<product> Achives = [];
  Future getproductdata() async {
    List<product> newList = [];
    QuerySnapshot<Map<String, dynamic>> productsnapshot =
        await FirebaseFirestore.instance.collection('feature products').get();
    productsnapshot.docs.forEach(
      (element) {
        product productdata = product(
            image: element['image'],
            name: element['name'],
            price: element['price']);
        newList.add(productdata);
        print(newList);
      },
    );
    Product = newList;

    notifyListeners();
  }

  Future getArchivesdata() async {
    List<product> newList2 = [];
    QuerySnapshot<Map<String, dynamic>> achivessnapshot =
        await FirebaseFirestore.instance.collection('newAchives').get();
    achivessnapshot.docs.forEach(
      (element) {
        product achivesdata = product(
            image: element['image'],
            name: element['name'],
            price: element['price']);
        newList2.add(achivesdata);
        print(newList2);
      },
    );
    Achives = newList2;

    notifyListeners();
  }

  List<product> get getArchivesList {
    print(Product);
    return Achives;
  }

  List<product> get getproductList {
    print(Achives);
    return Product;
  }
}
