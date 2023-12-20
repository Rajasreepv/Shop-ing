import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/pages/orders/list_product.dart';
import 'package:weatherapp/pages/modals/productmodal.dart';
import 'package:weatherapp/pages/provider/product_provider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    product_provider productProvider =
        Provider.of<product_provider>(context, listen: false);
    productProvider.getproductdata();

    List<product> snapshot = productProvider.getproductList;
    print("product data us $snapshot");
    return ListProduct(
      name: "gyss",
      snapShot: snapshot,
    );
  }
}
