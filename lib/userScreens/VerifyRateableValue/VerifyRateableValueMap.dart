import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/model/VerifyRateableResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VerifyRateableValueMap extends StatefulWidget {
  final VerifyRateableResponseModel model;

  VerifyRateableValueMap({this.model});

  @override
  _VerifyRateableValueMapState createState() =>
      _VerifyRateableValueMapState(model: model);
}

class _VerifyRateableValueMapState extends State<VerifyRateableValueMap> {
  final VerifyRateableResponseModel model;
  _VerifyRateableValueMapState({this.model});

  double latitude = 0.00;
  double longitude = 0.00;
  Set<Marker> _markers = Set<Marker>();
  List<LatLng> polygonCoordinates = [];

  @override
  void initState() {
    super.initState();
    if (model != null && model.b_centriod != null) {
      String coordinates = model.b_centriod;
      String str1 = coordinates.substring(6);
      String str2 = str1.substring(0, (str1.length - 1));
      List<String> list = str2.split(" ");
      setState(() {
        longitude = double.parse(list[0]);
        latitude = double.parse(list[1]);
        _markers.add(
          Marker(
            markerId: MarkerId('Centroid'),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
    }
    if (model != null && model.polygon != null) {
      String coordinates = model.polygon;
      String str1 = coordinates.substring(9);
      String str2 = str1.substring(0, (str1.length - 2));
      List<String> list = str2.split(",");
      print('polygon list: $list');
      if (list.isNotEmpty) {
        for (String s in list) {
          List<String> items = s.split(" ");
          polygonCoordinates
              .add(new LatLng(double.parse(items[1]), double.parse(items[0])));
        }
      }
      print('polygon coordinates: ${polygonCoordinates.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Map - Rateable Value",
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
              target: LatLng(latitude, longitude),
              zoom: 16,
            ),
            mapType: MapType.hybrid,
            markers: _markers,
            polygons: drawPolygon(),
          )
        ],
      ),
    );
  }

  Set<Polygon> drawPolygon() {
    Set<Polygon> polygonSet = new Set();
    polygonSet.add(
      Polygon(
        polygonId: PolygonId('Polygons'),
        points: polygonCoordinates,
        strokeColor: Colors.orangeAccent,
      ),
    );

    return polygonSet;
  }
}
