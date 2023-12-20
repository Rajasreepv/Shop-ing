import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/pages/main_homepage.dart';
import 'package:weatherapp/pages/modals/productmodal.dart';
import 'package:weatherapp/pages/orders/product_card.dart';
import 'package:weatherapp/pages/orders/productdetailing.dart';
import 'package:weatherapp/pages/provider/category_provider.dart';
import 'package:weatherapp/pages/provider/product_provider.dart';

class ListProduct extends StatelessWidget {
  final String name;
  bool? isCategory = true;
  List<product> snapShot;
  ListProduct({
    required this.name,
    this.isCategory,
    required this.snapShot,
  });
  Widget _buildTopName() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMyGridView(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: 300,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: orientation == Orientation.portrait ? 0.8 : 0.9,
        scrollDirection: Axis.vertical,
        children: snapShot
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => details(
                            imageAddress: e.image,
                            name: e.name,
                            price: e.price,
                            Description: e.Description,
                          )));
                },
                child: productcard(
                  price: e.price,
                  imageAddress: e.image,
                  name: e.name,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  late category_provider categoryProvider;
  late product_provider productProvider;
  // Widget _buildSearchBar(context) {
  //   return isCategory == true
  //       ? IconButton(
  //           icon: Icon(
  //             Icons.search,
  //             color: Colors.black,
  //           ),
  //           onPressed: () {
  //             // categoryProvider.getSearchList(list: snapShot);
  //             // showSearch(context: context, delegate: SearchCategory());
  //           },
  //         )
  //       : IconButton(
  //           icon: Icon(
  //             Icons.search,
  //             color: Colors.black,
  //           ),
  //           onPressed: () {
  //             // productProvider.getSearchList(list: snapShot);
  //             // showSearch(context: context, delegate: SearchProduct());
  //           },
  //         );
  // }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<category_provider>(context);
    productProvider = Provider.of<product_provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => main_homepage(),
                ),
              );
            }),
        actions: <Widget>[],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            _buildTopName(),
            SizedBox(
              height: 10,
            ),
            _buildMyGridView(context),
          ],
        ),
      ),
    );
  }
}
