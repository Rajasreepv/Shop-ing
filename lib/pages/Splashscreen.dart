import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/authentication/Login.dart';
import 'package:weatherapp/pages/provider/product_provider.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 10), () async {
      product_provider productProvider =
          Provider.of<product_provider>(context, listen: false);
      productProvider.getproductdata();
      productProvider.getArchivesdata();
      Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon.jpg',
                  height: 600,
                  width: 800,
                ),
                const Text(
                  "Shop-ing",
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
