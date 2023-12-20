// ignore: unused_import
import 'dart:collection';

import 'package:flutter/material.dart';

class productcard extends StatelessWidget {
  productcard(
      {required this.imageAddress,
      required this.price,
      required this.name,
      this.Description});
  final String imageAddress;
  final String name;
  final double price;
  String? Description;
  @override
  Widget build(BuildContext context) {
    // Return a widget for each item in the productList

    return Container( 
      // decoration: BoxDecoration(
      // border: Border.all(
      //   width: 1.0, // Adjust border width as needed
      //   color: Colors.grey, // Customize border color
      // ),
    // ),
        height: 270,
        width: 170,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 100,
                width: double.infinity,
                child: Image.network(imageAddress)),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        '4.9 | 2336',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        ' \$$price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff2A977D)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}