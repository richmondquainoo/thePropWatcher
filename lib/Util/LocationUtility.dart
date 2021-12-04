import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Utility.dart';

class LocationUtilityService {
  BuildContext context;

  LocationUtilityService({this.context});

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      new UtilityService().confirmationBox(
          title: 'Location Services Disabled',
          message:
              'Location services disabled. Please ensure that you have enabled/turned on your location service.',
          context: context,
          yesColor: Colors.teal,
          yesLabel: 'Okay',
          noLabel: 'Cancel',
          noColor: Colors.deepOrange,
          buttonHeight: 30,
          buttonWidth: 100,
          onYes: () {
            Navigator.pop(context);
          },
          onNo: () {
            Navigator.pop(context);
          });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        displayRationale(context);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      displayRationale(context);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void displayRationale(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Location Permission",
            style: GoogleFonts.quattrocento(
              textStyle: TextStyle(
                fontSize: 11,
                color: Colors.indigo,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          content: Container(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Property Watch needs location access to be able to verify site and generates site plan. This is needed for the app to function properly",
                  style: GoogleFonts.quattrocento(
                    textStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.black26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.quattrocento(
                      textStyle: TextStyle(
                        fontSize: 11,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Okay",
                    style: GoogleFonts.quattrocento(
                      textStyle: TextStyle(
                        fontSize: 11,
                        color: Colors.teal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
