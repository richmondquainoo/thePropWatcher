import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/model/AppData.dart';
import 'package:elandguard/model/CoordinateModel.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/model/VerifySiteRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ConfirmPolygonScreen extends StatefulWidget {
  final List<Position> positions;

  ConfirmPolygonScreen({this.positions});

  @override
  _ConfirmPolygonScreenState createState() =>
      _ConfirmPolygonScreenState(positions: positions);
}

class _ConfirmPolygonScreenState extends State<ConfirmPolygonScreen> {
  final List<Position> positions;

  _ConfirmPolygonScreenState({this.positions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Confirm Polygon",
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
              zoom: 16,
            ),
            mapType: MapType.hybrid,
            polygons: drawPolygon(),
          )
        ],
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(left: 30),
        child: TextButtonComponent(
          labelColor: kPrimaryTheme,
          textColor: Colors.white,
          label: "Verify Site",
          onTap: () {
            new UtilityService().confirmationBox(
                title: 'Confirm Site Verification',
                message: 'Are you sure you want to verify this site?',
                context: context,
                yesColor: Colors.teal,
                yesLabel: 'Yes, Verify',
                noLabel: 'No, Cancel',
                noColor: Colors.deepOrange,
                buttonHeight: 30,
                buttonWidth: 100,
                onYes: () {
                  Navigator.pop(context);
                  verificationRequest(context);
                },
                onNo: () {
                  Navigator.pop(context);
                });
          },
        ),
      ),
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

      print('RequestModel: ${requestModel.toJson()}');
    } catch (e) {
      print('verificationRequest error: $e');
    }
  }
}
