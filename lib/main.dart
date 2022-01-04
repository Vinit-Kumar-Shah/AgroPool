import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:agropool/Screens/homescreen.dart';
import 'package:agropool/Screens/loginscreen.dart';
import 'package:agropool/Screens/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:agropool/appdata.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'methods.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference UserReference =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.green),
        routes: {
          HomeScreen.ScreenId: (context) => HomeScreen(), // Page for home screen
          LoginScreen.ScreenId: (context) => LoginScreen(), // Page for login screen
          RegistrationScreen.ScreenId: (context) => RegistrationScreen() // Page for registration screen
        },
        debugShowCheckedModeBanner: false,
        title: 'Agro-Pool',
        initialRoute: LoginScreen.ScreenId,
      ),
    );
  }
}
