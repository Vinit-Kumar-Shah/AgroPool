// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:agropool/main.dart';
import 'loginscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class RegistrationScreen extends StatefulWidget {
  static const String ScreenId = "RegScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool loading = false;
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    displayToast(String mssg, BuildContext context) {
      Fluttertoast.showToast(msg: mssg);
    }

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    void registerNewUser(BuildContext context) async {
      final firebaseUser = (await _firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailTextEditingController.text,
                  password: passwordTextEditingController.text)
              .catchError(
        (errMsg) {
          displayToast("Error: " + errMsg.toString(), context);
        },
      ))
          .user;
      if (firebaseUser == null) {
        displayToast("New user Account has not been created", context);
      } else {
        UserReference.child(firebaseUser.uid);
        Map UserData = {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
        };
        UserReference.child(firebaseUser.uid).set(UserData);
        displayToast(
            'Congrats! Your account has been created succesfully', context);
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.ScreenId, (route) => false);
      }
    }

    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
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
                    'Register',
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
                          style: TextStyle(fontSize: 20.0),
                          keyboardType: TextInputType.name,
                          controller: nameTextEditingController,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Your Name",
                              labelStyle: TextStyle(
                                  fontSize: 20.0, fontFamily: 'BoltRegular'),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 20.0)),
                        ),
                        TextField(
                          controller: phoneTextEditingController,
                          style: TextStyle(fontSize: 20.0),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                  fontSize: 20.0, fontFamily: 'BoltRegular'),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 20.0)),
                        ),
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
                      setState(() {
                        loading = !loading;
                      });

                      if (nameTextEditingController.text.length < 5) {
                        displayToast(
                            "Name must be Atleast 5 Characters Long", context);
                      } else if (!emailTextEditingController.text
                          .contains("@")) {
                        displayToast("Email must contain @ symbol", context);
                      } else if (phoneTextEditingController.text.length < 10) {
                        displayToast(
                            "Phone Number must be 10 digits long", context);
                      } else if (passwordTextEditingController.text.length <
                          6) {
                        displayToast(
                            "Password must be more than 6 Characters", context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                    child: Text(
                      "Register",
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
                    height: 50.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.ScreenId, (route) => false);
                    },
                    child: Text(
                      "Already a User? Login Here",
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
