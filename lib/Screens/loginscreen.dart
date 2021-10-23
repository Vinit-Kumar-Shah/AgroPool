// import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:agropool/Screens/homescreen.dart';
import 'registerScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agropool/main.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  static const String ScreenId = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  displayToast(String mssg, BuildContext context) {
    Fluttertoast.showToast(msg: mssg);
  }

  void loginUser(BuildContext context) async {
    final firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError(
      (errMsg) {
        print(errMsg);
        displayToast("Error: " + errMsg.toString(), context);
      },
    ))
        .user;
    if (firebaseUser != null) {
      UserReference.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.ScreenId, (route) => false);
          displayToast('You\'ve Succesfully Logged In', context);
        } else {
          _firebaseAuth.signOut();
          displayToast('Invalid ID and Password. Please try again', context);
        }
      });
    } else {
      displayToast('Some Error Occured', context);
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            backgroundColor: Colors.black,
          ),
          inAsyncCall: loading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  Image(
                    image: AssetImage('images/logo.png'),
                    alignment: Alignment.center,
                    width: 300.0,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: "BoltRegular",
                        fontWeight: FontWeight.w500,
                        fontSize: 45.0),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Enter Email",
                              labelStyle: TextStyle(
                                  fontSize: 20.0, fontFamily: 'BoltRegular'),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 20.0)),
                        ),
                        TextField(
                          controller: passwordTextEditingController,
                          obscureText: true,
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Enter Password",
                              labelStyle: TextStyle(
                                  fontSize: 20.0, fontFamily: 'BoltRegular'),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 20.0)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  // RaisedButton(
                  //   onPressed: null,
                  //   color: Colors.yellow,
                  //   textColor: Colors.black,
                  //   on
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  //   child: Text(
                  //     'Login',
                  //     style: TextStyle(fontSize: 20.0, fontFamily: "BoltSemiBold"),
                  //   ),
                  // )
                  ElevatedButton(
                    onPressed: () {
                      {
                        setState(() {
                          loading = !loading;
                        });
                        loginUser(context);
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'BoltSemiBold',
                          color: Colors.black),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.yellow),
                    ),
                  ),
                  SizedBox(
                    height: 135.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          RegistrationScreen.ScreenId, (route) => false);
                    },
                    child: Text(
                      "New User? Register Here.",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'BoltSemiBold',
                          color: Colors.black),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.yellow),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
