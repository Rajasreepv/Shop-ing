import 'package:flutter/material.dart';

class cartmodel {
  int quantity;
  final String name;
  double itemprice;
  final String imageaddress;
  final String size;

  cartmodel({
    required this.name,
    required this.imageaddress,
    required this.itemprice,
    required this.quantity,
    required this.size,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageaddress': imageaddress,
      'itemprice': itemprice,
      'quantity': quantity,
      'size': size,
    };
  }

  factory cartmodel.fromJson(Map<String, dynamic> json) {
    return cartmodel(
        name: json['name'],
        itemprice: json['itemPrice'],
        imageaddress: json['imageAddress'],
        size: json['size'],
        quantity: 1);
  }
}
