import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/AppData.dart';
import 'package:elandguard/model/CoordinateModel.dart';
import 'package:elandguard/model/ServiceCharge.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/model/VerifySiteRequestModel.dart';
import 'package:elandguard/userScreens/Invoice/InvoiceScreen.dart';
import 'package:elandguard/userScreens/WebViewerScreen/WebViewerScreen.dart';
import 'package:elandguard/userScreens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SitePlanPolygon extends StatefulWidget {
  final List<Position> positions;

  SitePlanPolygon({this.positions});

  @override
  _SitePlanPolygonState createState() =>
      _SitePlanPolygonState(positions: positions);
}

class _SitePlanPolygonState extends State<SitePlanPolygon> {
  final List<Position> positions;

  _SitePlanPolygonState({this.positions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Site Plan Verification",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kPrimaryTheme),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 23,
            color: kPrimaryTheme,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(positions[0].latitude, positions[0].longitude),
              zoom: 14,
            ),
            mapType: MapType.hybrid,
            polygons: drawPolygon(),
          )
        ],
      ),
      persistentFooterButtons: [
        Column(
          children: [
            Text(
              "The red polygon on the map indicates the boundaries of this site plan.",
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kPrimaryTheme,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Return To Home Page',
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewerScreen(
                            title: 'Lands Commission Portal',
                            path: 'https://onlineservices.lc.gov.gh/',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kPrimaryTheme,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Go To Lands Commission Portal',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Set<Polygon> drawPolygon() {
    List<LatLng> polygonCoordinates = [];
    for (Position pos in positions) {
      polygonCoordinates.add(LatLng(pos.latitude, pos.longitude));
    }
    Set<Polygon> polygonSet = new Set();
    polygonSet.add(
      Polygon(
          fillColor: Colors.transparent,
          polygonId: PolygonId('test'),
          points: polygonCoordinates,
          strokeColor: Colors.red),
    );

    return polygonSet;
  }

  Future<void> verificationRequest(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );
      UserProfileModel user =
          Provider.of<AppData>(context, listen: false).userData;
      VerifySiteRequestModel requestModel = VerifySiteRequestModel(
          applicant_name: user.name, ref_number: '12345678');
      List<CoordinateModel> wkt = [];
      if (positions.isNotEmpty) {
        for (Position pos in positions) {
          wkt.add(new CoordinateModel(
              latitude: pos.latitude,
              longitude: pos.longitude,
              accuracy: pos.accuracy));
        }
      }
      requestModel.wkt = wkt;
      var jsonBody = jsonEncode(requestModel);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postData(
        url: VERIFY_SITE_LOCATION_PDF_URL,
        body: jsonBody,
      );

      print('verify site pdf: ${response.body}');
      // List<String> fileContents = [response.body];
      // Blob blob = new Blob(fileContents, 'text/plain', 'native');
      // FileSystem _filesystem =
      //     await window.requestFileSystem(1024 * 1024, persistent: false);
      // FileEntry fileEntry = await _filesystem.root.createFile('dart_test.csv');
      // FileWriter fw = await fileEntry.createWriter();
      // fw.write(blob);
      // File file = await fileEntry.file();
      // print("File info: ${file.name} - ${file.relativePath}");
      Navigator.of(context, rootNavigator: true).pop();

      print('RequestModel: ${requestModel.toJson()}');
    } catch (e) {
      print('verificationRequest error: $e');
    }
  }

  void getServiceCharge(
      {String serviceCode, BuildContext context, var requestObject}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );
      String url = '$SERVICE_CHARGE_URL/$serviceCode';
      // print('URL: $url');
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.getDataWithAuth(
          url: url, auth: 'Bearer $ACCESS_TOKEN');

      // print('service charge response: ${response.body}');

      Navigator.of(context, rootNavigator: true).pop();
      if (response == null) {
        //error handling
        new UtilityService().showMessage(
          context: context,
          message: 'An error has occurred. Please try again',
          icon: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
        );
      } else {
        var data = jsonDecode(response.body);

        int status = data['status'];
        // print('Status: $status');
        // Handle network error
        if (status == 500 || status == 404 || status == 403) {
          new UtilityService().showMessage(
            message: 'An error has occurred. Please try again',
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            context: context,
          );
        } else if (status == 200) {
          ServiceChargeModel model = ServiceChargeModel(
            serviceCode: data['data']['serviceCode'],
            serviceName: data['data']['serviceName'],
            amount: data['data']['amount'],
            tax: data['data']['tax'],
            levy: data['data']['levy'],
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvoiceScreen(
                serviceChargeModel: model,
                requestObject: requestObject,
              ),
            ),
          );
        } else {
          new UtilityService().showMessage(
            context: context,
            message: data['message'],
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('get bill error: $e');
    }
  }
}
