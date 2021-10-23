import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:agropool/addressmodel.dart';
import 'package:agropool/appdata.dart';
import 'package:agropool/configmap.dart';
import 'getresponse.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class Methods {
  static Future<String> searchAddfromCoor(Position position, context) async {
    String Add = "";
    String url =
        "https://apis.mapmyindia.com/advancedmaps/v1/$MapMyIndiaKey/rev_geocode?lat=${position.latitude}&lng=${position.longitude}&region=IND&lang=en";

    var response = await GetResponse.getRequest(url);
    if (response != "Failed.") {
      Add = response["results"][0]["formatted_address"];
      Address PickupAddress = new Address(
          formattedaddress: Add,
          longitude: position.longitude,
          latitude: position.latitude);
      Provider.of<AppData>(context, listen: false)
          .UpdatePickupLocation(PickupAddress);
    }
    return Add;
  }
}
