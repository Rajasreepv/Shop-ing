// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:weatherapp/authentication/Login.dart';
import 'package:weatherapp/pages/global/global.dart';
import 'package:weatherapp/pages/orders/bestsellers.dart';
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

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  //   progress dialog

  TextEditingController nameEditingController = TextEditingController();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

//formvalidation

  validation() {
    if (nameEditingController.text.length <= 2 ||
        nameEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Name should be atleast 3 characters");
    } else if (!emailEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email format wrong!!");
    } else if (passwordEditingController.text.length < 5) {
      Fluttertoast.showToast(msg: "password must be atleast 6 characters long");
    } else {
      saveUserInfo();
    }
  }

//storing driverInfo
  saveUserInfo() async {
    _normalProgress(context);
    try{
    final User? firebaseUser = (await fAuth.createUserWithEmailAndPassword(
            email: emailEditingController.text.trim(),
            password: passwordEditingController.text.trim()))
        .user;

    if (firebaseUser != null) {
      Map usersMap = {
        "id": firebaseUser.uid,
        "name": nameEditingController.text.trim(),
        "email": emailEditingController.text.trim(),
      };
      DatabaseReference userssref =
          FirebaseDatabase.instance.ref().child("users");
      userssref.child(firebaseUser.uid).set(usersMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account created Successfully");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => main_homepage()));
    }
    ///////

    else {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Account not created!");
    }
    }on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') { Fluttertoast.showToast(msg: "This email address is already registered! ");
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => Login()));
      
    } 
  }
  }
 
  ///
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
                  "Register  ",
                  style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 5, 71, 65),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameEditingController,
                  decoration: const InputDecoration(
                      labelText: "Name",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 106, 19, 13))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 106, 19, 13))),
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 106, 19, 13),
                          fontSize: 10),
                      labelStyle: TextStyle(
                          color: const Color.fromARGB(255, 106, 19, 13),
                          fontSize: 14)),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailEditingController,
                  decoration: const InputDecoration(
                      hintText: "abc@gmail.com",
                      labelText: "Email",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 106, 19, 13))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 106, 19, 13))),
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 106, 19, 13),
                          fontSize: 10),
                      labelStyle: TextStyle(
                          color: const Color.fromARGB(255, 106, 19, 13),
                          fontSize: 14)),
                ),
                TextFormField(
                  controller: passwordEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 106, 19, 13))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 106, 19, 13))),
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 106, 19, 13),
                          fontSize: 10),
                      labelStyle: TextStyle(
                          color: const Color.fromARGB(255, 106, 19, 13),
                          fontSize: 14)),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 106, 19, 13))),
                      onPressed: () {
                        validation();
                      },
                      child: const Text("Create Account",
                          style: TextStyle(color: Colors.white))),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (c) => Login()));
                    },
                    child: const Text(
                      "Already have an Account ? Login Here",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 106, 19, 13)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
