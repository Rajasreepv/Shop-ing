import 'package:flutter/material.dart';

class nonloginprofile extends StatelessWidget {
  final String page;
  const nonloginprofile({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Login to view Your $page")),
    );
  }
}
