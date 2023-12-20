import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:weatherapp/firebase_options.dart';
import 'package:weatherapp/pages/Splashscreen.dart';
import 'package:weatherapp/pages/provider/cart_provider.dart';
import 'package:weatherapp/pages/provider/category_provider.dart';
import 'package:weatherapp/pages/provider/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<category_provider>(
            create: (context) => category_provider(),
          ),
          ChangeNotifierProvider<product_provider>(
            create: (context) => product_provider(),
          ),
          ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(),
          )
        ],
        child: MaterialApp(
          
          debugShowCheckedModeBanner: false,
          home: MySplashScreen(),
        ));
  }
}
