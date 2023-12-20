// Existing imports and class definition...

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:weatherapp/pages/main_homepage.dart';
import 'package:weatherapp/pages/modals/productmodal.dart';
import 'package:weatherapp/pages/orders/product_card.dart';
import 'package:weatherapp/pages/orders/productdetailing.dart';
import 'package:weatherapp/pages/provider/category_provider.dart';

class apparel extends StatefulWidget {
  apparel({Key? key, required this.value});
  int value;

  @override
  State<apparel> createState() => _apparelState();
}

class _apparelState extends State<apparel> {
  List<product> categoryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value == 1
            ? "Shirts"
            : (widget.value == 2 ? "Dress" : "Shorts")),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<category_provider>(
        builder: (context, categoryProvider, _) {
          if (!categoryProvider.dataLoaded) {
            categoryProvider.fetchData();
            return Center(child: CircularProgressIndicator());
          }

          if (widget.value == 1) {
            categoryList = categoryProvider.getShirtList;
          } else if (widget.value == 2) {
            categoryList = categoryProvider.getDressList;
          } else if (widget.value == 3) {
            categoryList = categoryProvider.getShortList;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (categoryList.length / 2).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  if (secondIndex >= categoryList.length) {
                    return SizedBox();
                  }

                  product firstShirt = categoryList[firstIndex];
                  product secondShirt = categoryList[secondIndex];

                  return Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to details page passing the data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => details(
                                  name: firstShirt.name,
                                  price: firstShirt.price,
                                  imageAddress: firstShirt.image,
                                  Description: firstShirt.Description,
                                ),
                              ),
                            );
                          },
                          child: productcard(
                            imageAddress: firstShirt.image,
                            price: firstShirt.price,
                            name: firstShirt.name,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => details(
                                    name: secondShirt.name,
                                    price: secondShirt.price,
                                    imageAddress: secondShirt.image,
                                    Description: secondShirt.Description),
                              ),
                            );
                          },
                          child: productcard(
                            imageAddress: secondShirt.image,
                            price: secondShirt.price,
                            name: secondShirt.name,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
