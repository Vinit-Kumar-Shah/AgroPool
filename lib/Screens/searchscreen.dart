import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agropool/appdata.dart';
import 'package:http/http.dart' as http;
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickupcontroller = TextEditingController();
  TextEditingController dropoffcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String Add =
        Provider.of<AppData>(context).PickupLocation.formattedaddress ?? "";
    pickupcontroller.text = Add;
    void FindPlace(String place) async {
      if (place != null) {
        String URL =
            "https://api.foursquare.com/v2/venues/explore?client_id=KQVHC5QUVBH4DX0CPRUMGI5AUYSDQQSTQ5HEMLKJLIPXG4FZ&client_secret=G4QI52HOC0WD5RWI0O0GSRZ413LJQ1BRBTYGCNR4XPQXGEBN&v=20180323&limit=1&ll=27.2057821,77.9698279&query=$place";
        var res = await http.get(Uri.parse(URL));
        if (res == null) {
          return;
        } else {
          print(res.body);
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                height: 500,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, top: 20.0, right: 25.0, bottom: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_rounded)),
                          Center(
                              child: Text(
                            "Set Drop Location",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "BoltSemiBold"),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/pickicon.png",
                            height: 16.0,
                            width: 16.0,
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: TextField(
                                  controller: pickupcontroller,
                                  decoration: InputDecoration(
                                      hintText: "Pickup Location",
                                      fillColor: Colors.grey[400],
                                      filled: true,
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 11.0, top: 8.0, bottom: 8.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/desticon.png",
                            height: 16.0,
                            width: 16.0,
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: TextField(
                                  onChanged: (value) {
                                    FindPlace(value);
                                  },
                                  controller: dropoffcontroller,
                                  decoration: InputDecoration(
                                      hintText: "Drop Location",
                                      fillColor: Colors.grey[400],
                                      filled: true,
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 11.0, top: 8.0, bottom: 8.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
