import 'package:flutter/cupertino.dart';
import 'package:agropool/addressmodel.dart';

class AppData extends ChangeNotifier {
  Address PickupLocation =
      Address(formattedaddress: "", latitude: 0.0, longitude: 0.0);
  void UpdatePickupLocation(Address NewLocation) {
    PickupLocation = NewLocation;
    notifyListeners();
  }
}
