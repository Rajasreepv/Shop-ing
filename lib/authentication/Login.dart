// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:weatherapp/admin/dashboard.dart';

import 'package:weatherapp/authentication/Signup.dart';
import 'package:weatherapp/pages/Splashscreen.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/main_homepage.dart';

_normalProgress(context) async {
  ProgressDialog pd = ProgressDialog(context: context);
  pd.show(
      msg: 'Processing please wait...',
      progressBgColor: Colors.transparent,
      backgroundColor: Colors.white,
      msgColor: Color.fromARGB(255, 5, 71, 65),
      progressValueColor: Colors.purple);
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController EmailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  loginvalidation() {
    if ((EmailEditingController.text == "admin") &&
        (passwordEditingController.text == "123456")) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => dashboard()));
    } else {
      if (!EmailEditingController.text.contains("@")) {
        Fluttertoast.showToast(msg: "email format wrong!!");
      } else if (passwordEditingController.text.length < 5) {
        Fluttertoast.showToast(
            msg: "password must be atleast 6 characters long");
      } else {
        loginCheck();
        // Navigator.push(context, MaterialPageRoute(builder: (c) => Home()));
      }
    }
  }

  loginCheck() async {
    // _normalProgress(context);
    try {
      final User? firebaseUser = (await fAuth.signInWithEmailAndPassword(
              email: EmailEditingController.text,
              password: passwordEditingController.text))
          .user;
      if (firebaseUser != null) {
        DatabaseEvent event = await FirebaseDatabase.instance
            .ref()
            .child('users')
            .orderByChild('email')
            .equalTo(EmailEditingController.text)
            .once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          Map<dynamic, dynamic> userData =
              snapshot.value as Map<dynamic, dynamic>;

          if (userData.isNotEmpty) {
            var userKey = userData.keys.first;
            var user = userData[userKey];

            bool isBlocked = user['blocked'] ?? false;

            if (isBlocked) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => MySplashScreen()));

              Fluttertoast.showToast(msg: "You are blocked. Cannot log in.");
            } else {
              currentFirebaseUser = firebaseUser;
              Fluttertoast.showToast(msg: "Login Successfull");

              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => main_homepage()));
            }
            return;
          }
        }
      } else {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Error Login!",
        );
      }
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
      Fluttertoast.showToast(msg: "Error Login!");
    }
  }

// Color.fromRGBO(208, 191, 255, 1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Login  ",
                  style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 5, 71, 65),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: EmailEditingController,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                TextFormField(
                  controller: passwordEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 127, 37, 4))),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4), fontSize: 10),
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 127, 37, 4),
                          fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 106, 19, 13))),
                      onPressed: () {
                        loginvalidation();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => signupscreen()));
                    },
                    child: const Text(
                      "Dont have an Account ? Register Here",
                      style: TextStyle(color: Colors.brown),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => main_homepage()));
                    },
                    child: Text("Skip"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
