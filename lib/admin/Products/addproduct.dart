import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class productform extends StatefulWidget {
  const productform({super.key});

  @override
  State<productform> createState() => _productformState();
}

String _selectedCategory = 'Dress';

class _productformState extends State<productform> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Future<void> addProductToFirestore(String productName, double price,
        String description, String image, int stock) async {
      try {
        await firestore
            .collection('category')
            .doc('VBWY0LBuo4fl9ZWDmsR8')
            .collection(_selectedCategory)
            .add({
          'name': productName,
          'price': price, "image": image, "stock": stock,
          'Description': description,
          // Add more fields as needed
        });
        print('Product added to Firestore!');
        print(_selectedCategory);
        Fluttertoast.showToast(msg: "Product Added Successfully");
      } catch (e) {
        print('Error adding product: $e');
      }
    }

    TextEditingController productname = TextEditingController();
    TextEditingController productprice = TextEditingController();
    TextEditingController productdesc = TextEditingController();
    TextEditingController productimage = TextEditingController();
    TextEditingController productsize = TextEditingController();
    TextEditingController productstockquantity = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product Name:'),
              TextFormField(
                controller: productname,
                decoration: InputDecoration(
                  hintText: 'Enter product name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Price:'),
              TextFormField(
                controller: productprice,
                decoration: InputDecoration(
                  hintText: 'Enter price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Description:'),
              TextFormField(
                controller: productdesc,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Upload Image:'),
              TextFormField(
                controller: productimage,
                decoration: InputDecoration(
                  hintText: 'Enter Image Link',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: productstockquantity,
                decoration: InputDecoration(
                  hintText: 'Enter Stock Quantity',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: productsize,
                decoration: InputDecoration(
                  hintText: 'Enter size',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                Text("Select Category"),
                SizedBox(
                  width: 40,
                ),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: const [
                    DropdownMenuItem(
                      value: 'Dress',
                      child: Text('Dress'),
                    ),
                    DropdownMenuItem(
                      value: 'Shorts',
                      child: Text('Shorts'),
                    ),
                    DropdownMenuItem(
                      value: 'Shirts',
                      child: Text('Shirts'),
                    ),
                    DropdownMenuItem(
                      value: 'Pants',
                      child: Text('Pants'),
                    ),
                  ],
                  onChanged: (category) {
                    setState(() {
                      _selectedCategory = category!;
                      // Pass selected category to parent widget
                    });
                  },
                  icon: const Icon(Icons.arrow_downward),
                  // hint: const Text('Select Category'),
                  // underline: const SizedBox(),
                )
              ]),
              ElevatedButton(
                  onPressed: () async {
                    addProductToFirestore(
                      productname.text,
                      double.parse(productprice.text),
                      productdesc.text,
                      productimage.text,
                      int.parse(productstockquantity.text),
                    );
                    await Future.delayed(Duration(milliseconds: 500));

                    // Navigate to a different route and then return to this route
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => productform()),
                    );
                  },
                  child: Text("Add Product"))
              // Text(pickedFile!.name),///////

              ///
            ],
          ),
        ),
      ),
    );
  }
}
