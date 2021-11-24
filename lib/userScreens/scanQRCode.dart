import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
 
 final String posturl = "http://41.66.204.146:9293/gelis_online_service_live/rest/";
 String qrCodeResult = "Not Yet Scanned";

  String convertedwgs84 = "Not Yet Scanned";
      double final_lng, final_lat;
//var send=[];  
        var  result_coor =[];
    var new_coordinates =[] ;


    List<String> myList = List<String>();

    List<Polygon> mypolygonList = [];
      //List<LatLng> mypointList = const[];

    //var myList = List(); // var myList = [];


MapController mapController;
   bool isMapRead = false;


var pointsGradient = <LatLng>[
      LatLng(5.58637793984754794, -0.17734150718964611),
      LatLng(5.58672105149502851, -0.17722462300204295),
      LatLng( 5.58672105149502851, -0.17722462300204295),
      LatLng(5.58676252652933858, -0.17711905018743365),
      LatLng(5.58676252652933858, -0.17684757723558114),
      LatLng(5.58660416730742515, -0.1764856132997778),
      LatLng(5.58637039893221843, -0.17623299263624839),
      LatLng(5.58620072833731118, -0.17623676309391301),
      LatLng(5.5860649918613845, -0.17651577696109474),
      LatLng(5.58597450087743397, -0.17708888652611671),
      LatLng(5.58637793984754794, -0.17734150718964611)
    ];



Future<String> sendconvertGNGtoWGS84(String jsonRequest) async {
      String codeSannernew = await BarcodeScanner.scan();    //barcode scanner
//sendconvertGNGtoWGS84(codeSanner);
    
    
    final response = await http.post(Uri.parse(posturl+"maps_service/select_convert_from_agg_to_wgs84"),
      headers: {
        "Accept": "application/json"
      },
      body: codeSannernew
    );

    if(response.statusCode == 200){
    final String responseString = response.body;
    convertedwgs84 =responseString;
    setState(() {
            qrCodeResult = convertedwgs84;
          });

String formattedValues ='';
  formattedValues = formattedValues.replaceAll("MULTIPOLYGON(((", "");
                formattedValues = formattedValues.replaceAll(")))", "");
            formattedValues = responseString.replaceAll("POLYGON ((", "");
                formattedValues = formattedValues.replaceAll("POLYGON((", "");
                formattedValues = formattedValues.replaceAll("))", "");
                formattedValues = formattedValues.replaceAll("), (", ", ");
                formattedValues = formattedValues.replaceAll("(", ", ");
                formattedValues = formattedValues.replaceAll("(", ", ");
                formattedValues = formattedValues.replaceAll(") ", "");
               formattedValues = formattedValues.replaceAll(")", "");
                

              
             formattedValues = formattedValues.replaceAll("MULTI,", "");
                
                
                //rectOptions_4 = null;

               // PolygonLayerOptions polyOptions = new PolygonLayerOptions();
                myList = formattedValues.split(",");

               // myList[0] = 'one';
// myList.add('four'); 


                  var polygonpoints = <LatLng>[];

                  // simple for-each
                  for (var item in myList) {
                    new_coordinates = null;
                    String new_point;
                    new_point = item;
                  if (new_point=="") {



                    //System.Double lat= System.Double.Parse(new_coordinates[0]);
                    //System.Double lng = System.Double.Parse(new_coordinates[1]);

                  } else {
                        new_point = new_point.trim();
                        new_coordinates = new_point.split(" ");
                      double lng = double.parse(new_coordinates[0]);
                      double lat = double.parse(new_coordinates[1]);


                      polygonpoints.add(new LatLng(lat, lng));
                      final_lat = lat;
                      final_lng = lng;
                }


                    print(item);

                    /* polyOptions.polygons.add(
                       Polygon(
                        points: polygonpoints,
                        holePointsList:null,
                        color: Colors.red,
                        borderStrokeWidth:4.0,
                        borderColor:   Color(0xffFEED00),
                        disableHolesBorder: false,
                        isDotted:false,
                        
                      )
                    ); */

        
                  }

mypolygonList.clear();
                    mypolygonList.add(  Polygon(
                        points: polygonpoints,
                        holePointsList:null,
                        color: Colors.red,
                        borderStrokeWidth:4.0,
                        borderColor:   Color(0xffFEED00),
                        disableHolesBorder: false,
                        isDotted:false,
                        
                      ));

                  //mapController.addPolygon();
                  mapController.move(LatLng(final_lat, final_lng),  18.0);


                  // for loop with item index
                 /*  for (var i = 0; i < myList.length; i++) {
                    print(myList[i]);
                  } */


             
    return responseString;
  }else{
    return null;
  }

  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();

     mapController = MapController();

 if(mapController == null) {
      mapController = MapController();
    }
    
    // after onReady, flag local control variable
    mapController.onReady.then((v) {
      isMapRead = mapController.ready;
    });

    
  }

  

 void _onMapTypeButtonPressed() {
    setState(() {
     // _currentMapType = _currentMapType == MapType.normal
    /*       ? MapType.satellite
          : MapType.normal; */
    });
  }



 void _scanQRCodeButtonPressed() {
    setState(() async {
  //  String codeSanner = await BarcodeScanner.scan();    //barcode scanner
sendconvertGNGtoWGS84('');

    });
  }



  void _onAddMarkerButtonPressed() {
    setState(() async {
     /*  _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      )); */

        //await this.handler.getUserData();

     //await this.handler.backupDatabase();

    });
  }




   void _onBackupButtonPressed() {
    setState(() {

    });
  }

   void _gotoLocation(double lat,double long) {
    //check if map is ready to move camera...
    if(this.isMapRead) {
      mapController.move(LatLng(lat, long), mapController?.zoom);
    }
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code'),
        ),
        body: new Stack(
          children: <Widget>[
           
           new FlutterMap(
              mapController: mapController,
    options: MapOptions(center: LatLng(5.585, -0.176 ), zoom: 18.0),
    // onTap: (_, __) => setState(() {}),
    layers: [
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(5.585, -0.176 ),
            builder: (ctx) =>
            Container(
              child: Icon(Icons.my_location, size: 28, color: Colors.red,), 
            ),
          ),
        ],
      ),
    
                  PolygonLayerOptions(
                    polygons: mypolygonList,
                  ),
                   /*       TileLayerOptions(
                    wmsOptions: WMSTileLayerOptions(
                      baseUrl: 'http://dlrev.org:8080/geoserver/dlrev/wms',
                      layers: ['dlrev:kml_from_lupmis'],
                      format: 'image/png',
                      transparent: true
                    ),
                    subdomains: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
                  ),  */
                 /*  TileLayerOptions(
                    wmsOptions: WMSTileLayerOptions(
                      baseUrl: 'https://{s}.s2maps-tiles.eu/wms/?',
                      layers: ['s2cloudless-2018_3857'],
                    ),
                    subdomains: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
                  ) */
    ],
    children: <Widget>[
    
      
       TileLayerWidget(options: TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']
      )),
       TileLayerWidget(options: TileLayerOptions(
        urlTemplate: "http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga",
        subdomains: ['a', 'b', 'c']
      )), 
    ],
  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget> [
                     /* Text(
                        qrCodeResult,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0), */
                    FloatingActionButton(
                      onPressed: _scanQRCodeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.qr_code, size: 36.0),
                    ),
                      SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
             Text(qrCodeResult,
             overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
          ],
        ),);
  }
}

