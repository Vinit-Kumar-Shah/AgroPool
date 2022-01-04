import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agropool/Screens/searchscreen.dart';
import 'package:agropool/appdata.dart';
import 'package:agropool/methods.dart';
import 'package:provider/provider.dart';
import 'package:agropool/configmap.dart';

import 'dart:async';

class HomeScreen extends StatefulWidget {
  static const String ScreenId = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(37.123, 37.123), zoom: 15);
  late GoogleMapController _googleMapController;
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  late Position currentPosition;
  var geolocator = Geolocator();
  double MapPadding = 0.0;
  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition = position;

    LatLng LatLangPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: LatLangPosition, zoom: 20);
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String Address = await Methods.searchAddfromCoor(position, context);
    print("This is your Address " + Address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 40.0, child: Image.asset("images/user_icon.png")),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Samar Singh',
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: "BoltRegular"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: const Text(
                'Your Bookings',
                style: TextStyle(fontSize: 18.0, fontFamily: "BoltRegular"),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text(
                'Visit Profile',
                style: TextStyle(fontSize: 18.0, fontFamily: "BoltRegular"),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text(
                'About',
                style: TextStyle(fontSize: 18.0, fontFamily: "BoltRegular"),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Agro-Pool',
          style: TextStyle(fontFamily: "BoltSemiBold"),
        ),
        backgroundColor: Colors.green,
      ),
      body: Stack(children: [
        GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (controller) {
              setState(() {
                MapPadding = 290;
              });
              getLocation();
              _googleMapController = controller;
            }),
        Image(
          image: AssetImage('images/map.png'),
          alignment: Alignment.center,
          width: 1000.0,
        ),
        Positioned(
          left: 0.0,
          bottom: 0.0,
          right: 0.0,
          child: Container(
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7))
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Hi There,",
                    style: TextStyle(fontSize: 12.0, fontFamily: "BoltRegular"),
                  ),
                  Text("Where to?",
                      style: TextStyle(
                          fontSize: 20.0, fontFamily: "BoltSemiBold")),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7))
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Search Drop-off",
                            style: TextStyle(fontFamily: "BoltRegular"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home_rounded,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                Provider.of<AppData>(context).PickupLocation !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .PickupLocation
                                        .formattedaddress
                                    : "Add Home",
                                style: TextStyle(
                                  fontFamily: "BoltRegular",
                                )),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text("Home Address",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontFamily: "BoltRegular"))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Work",
                            style: TextStyle(fontFamily: "BoltRegular"),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text("Your Work Address",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontFamily: "BoltRegular"))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                target:
                    LatLng(currentPosition.latitude, currentPosition.longitude),
                zoom: 20))),
        child: const Icon(Icons.center_focus_strong_rounded),
      ),
    );
  }
}
// CameraPosition cameraPosition= new CameraPosition(target: LatLangPosition,zoom: 14);
// _googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
