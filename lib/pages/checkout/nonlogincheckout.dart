import 'package:flutter/material.dart';
import 'package:weatherapp/authentication/Login.dart';

class nonlogincheckout extends StatelessWidget {
  const nonlogincheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
                "https://cdn.dribbble.com/users/2058104/screenshots/4198771/dribbble.jpg"),
            Text(
              "Missing Cart Items?",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .blue, // Change this color to your desired background color
                  // You can adjust other button styles here, like padding, shape, etc.
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => Login()));
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
