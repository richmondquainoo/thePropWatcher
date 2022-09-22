import 'dart:collection';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/LocationUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/userScreens/VerifySite/ConfirmPolygonScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VerifySiteScreen extends StatefulWidget {
  // final ServiceChargeModel serviceChargeModel;

  VerifySiteScreen();

  @override
  _VerifySiteScreenState createState() => _VerifySiteScreenState();
}

class _VerifySiteScreenState extends State<VerifySiteScreen> {
  // final ServiceChargeModel serviceChargeModel;

  _VerifySiteScreenState();

  List<Position> positions = [];
  Set<Marker> _markers = HashSet<Marker>();
  // Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> polygonLatLng = [];

  @override
  Widget build(BuildContext context) {
    // UserProfileModel user = Provider.of<AppData>(context, listen: false).userData;
    return Scaffold(
      backgroundColor: kBackgroundTheme,
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Plot Site Boundaries",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'To plot site boundaries, please take note of the following:'
                      '\n1. Please pick the GPS coordinates of the site. '
                      '\n2. Please ensure location access permission is granted. '
                      '\n3. Please ensure your location is turned on.'
                      '\n4. Please ensure you are precisely '
                      'at the location where you want to verify.',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'To record the boundaries, go to each boundary point(typically, the corner of the boundary) then click on the plus '
                      'sign to add that point to the list of coordinates for the boundary, then proceed to the next point and do same until '
                      'you have plotted all the corners of your plot. You need to add at lease 4 different coordinates.',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "List of Coordinates",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Expanded(
                          child: Tooltip(
                            message: 'Add location coordinates',
                            child: GestureDetector(
                              onTap: () async {
                                addLocation(context);
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: displayPositions(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButtonComponent(
                      labelColor: kPrimaryTheme,
                      textColor: Colors.white,
                      label: "Proceed",
                      onTap: () {
                        if (positions.isNotEmpty && positions.length > 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmPolygonScreen(
                                      positions: positions,
                                    )),
                          );
                        } else {
                          new UtilityService().showMessage(
                            message: 'Please add location coordinates',
                            icon: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                            context: context,
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> getJobDetails(
  //     {BuildContext context, TrackJobModel trackJobModel}) async {
  //   try {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return ProgressDialog(displayMessage: 'Please wait...');
  //       },
  //     );
  //
  //     var jsonBody = jsonEncode(trackJobModel);
  //     NetworkUtility networkUtility = NetworkUtility();
  //     Response response = await networkUtility.postData(
  //       url: TRACK_JOB_URL,
  //       body: jsonBody,
  //     );
  //
  //     Navigator.of(context, rootNavigator: true).pop();
  //     print(response.body);
  //     if (response == null) {
  //       //error handling
  //       new UtilityService().showMessage(
  //         context: context,
  //         message: 'An error has occurred. Please try again',
  //         icon: Icon(
  //           Icons.error_outline,
  //           color: Colors.red,
  //         ),
  //       );
  //     } else {
  //       // //when there is a response to handle
  //       // int status = response.statusCode;
  //       var data = jsonDecode(response.body);
  //
  //       bool status = data['success'];
  //
  //       // Handle network error
  //       if (!status) {
  //         new UtilityService().showMessage(
  //           message: 'An error has occurred. Please try again',
  //           icon: Icon(
  //             Icons.error_outline,
  //             color: Colors.red,
  //           ),
  //           context: context,
  //         );
  //       } else {
  //         ApplicationDetailsModel details = ApplicationDetailsModel(
  //           client_name:
  //               data['application_details'][0]['client_name'].toString(),
  //           case_number:
  //               data['application_details'][0]['case_number'].toString(),
  //           job_status: data['application_details'][0]['job_status'].toString(),
  //           created_date:
  //               data['application_details'][0]['created_date'].toString(),
  //           modified_date:
  //               data['application_details'][0]['modified_date'].toString(),
  //           business_process_name: data['application_details'][0]
  //                   ['business_process_name']
  //               .toString(),
  //           business_process_sub_name: data['application_details'][0]
  //                   ['business_process_sub_name']
  //               .toString(),
  //           application_stage:
  //               data['application_details'][0]['application_stage'].toString(),
  //         );
  //         List<MilestoneModel> mod = [];
  //         var milestones = data['milestones'] as List;
  //         if (milestones.isNotEmpty) {
  //           for (int i = 0; i < milestones.length; i++) {
  //             MilestoneModel m = MilestoneModel(
  //               // ms_id: data['milestones'][i]['ms_id'],
  //               mile_stone_status: data['milestones'][i]['mile_stone_status'],
  //               milestone_description: data['milestones'][i]
  //                   ['milestone_description'],
  //               // working_day_required: data['milestones'][i]['working_day_required'],
  //               // milestone_remaining: data['milestones'][i]['milestone_remaining'],
  //             );
  //             mod.add(m);
  //           }
  //         }
  //         details.milestones = mod;
  //
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(
  //         //     builder: (context) => JobDetailsScreen(
  //         //       data: details,
  //         //     ),
  //         //   ),
  //         // );
  //       }
  //     }
  //   } catch (e) {
  //     print('getJobDetails error: $e');
  //     new UtilityService().showMessage(
  //       context: context,
  //       message: 'An error has occurred. Please try again',
  //       icon: Icon(
  //         Icons.error_outline,
  //         color: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> addLocation(BuildContext context) async {
    try {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Obtaining coordinates...');
        },
      );

      Position position =
          await new LocationUtilityService().getCurrentLocation();
      Navigator.of(context, rootNavigator: true).pop();
      if (position == null) {
        new UtilityService().confirmationBox(
            title: 'GPS not found',
            message:
                'An attempt to obtain GPS coordinates for this location failed. Please ensure that you have granted the required location-access permissions. Also ensure that '
                'your GPS is turned on. To improve accuracy, please stand in an open space and try again.',
            context: context,
            yesColor: Colors.teal,
            yesLabel: 'Try Again',
            noLabel: 'Cancel',
            noColor: Colors.deepOrange,
            buttonHeight: 30,
            buttonWidth: 100,
            onYes: () {
              Navigator.pop(context);
              addLocation(context);
            },
            onNo: () {
              Navigator.pop(context);
            });
      }
      // else if (position.accuracy > 10) {
      //   while (position.accuracy > 10) {
      //     position = await new LocationUtilityService().getCurrentLocation();
      //   }
      // } else {
      //   setState(() {
      //     positions.add(position);
      //   });
      // }
      if (position.accuracy > 100) {
        new UtilityService().confirmationBox(
            title: 'Location Accuracy High',
            message:
                'The Accuracy Level for this GPS reading is high. Please ensure that you are in an open space and try again. View Location Details below:'
                '\nLatitude: ${position.latitude}'
                '\nLongitude: ${position.longitude}'
                '\nAccuracy: ${position.accuracy}'
                '\nAccuracy MUST be less than 6 meters',
            context: context,
            yesColor: Colors.teal,
            yesLabel: 'Try Again',
            noLabel: 'Cancel',
            noColor: Colors.deepOrange,
            buttonHeight: 30,
            buttonWidth: 100,
            onYes: () {
              Navigator.pop(context);
              addLocation(context);
            },
            onNo: () {
              Navigator.pop(context);
            });
      } else {
        setState(() {
          positions.add(position);
        });
      }
    } catch (e) {
      print('add location error: $e');
    }
  }

  List<Widget> displayPositions() {
    List<ListTile> list = [];
    try {
      if (positions.isNotEmpty) {
        int index = 0;
        int counter = 0;
        for (Position pos in positions) {
          list.add(
            new ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Center(
                  child: Text(
                    '${++counter}',
                    style: GoogleFonts.lato(color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                'Latitude: ${pos.latitude}'
                '\nLongitude: ${pos.longitude}',
                style: GoogleFonts.montserrat(fontSize: 12),
              ),
              subtitle: Text(
                'Accuracy: ${pos.accuracy} meters',
                style: GoogleFonts.montserrat(fontSize: 11),
              ),
              trailing: GestureDetector(
                onTap: () {
                  new UtilityService().confirmationBox(
                      title: 'Remove Coordinates',
                      message:
                          'Are you sure you want to remove this coordinate?',
                      context: context,
                      yesColor: Colors.teal,
                      yesLabel: 'Remove',
                      noLabel: 'Cancel',
                      noColor: Colors.deepOrange,
                      buttonHeight: 30,
                      buttonWidth: 100,
                      onYes: () {
                        Navigator.pop(context);
                        setState(() {
                          positions.removeAt(index);
                        });
                        index++;
                      },
                      onNo: () {
                        Navigator.pop(context);
                      });
                },
                child: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.deepOrangeAccent,
                  // size: 20,
                ),
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('displayPositions err: $e');
    }
    return list;
  }

  void showPolygon(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0.5),
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            positions[0].latitude,
                            positions[0].longitude,
                          ),
                          zoom: 16,
                        ),
                        markers: _markers,
                        polygons: myPolygon(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoordinates = [];
    polygonCoordinates.add(LatLng(37.43296265331129, -122.08832357078792));
    polygonCoordinates.add(LatLng(37.43006265331129, -122.08832357078792));
    polygonCoordinates.add(LatLng(37.43006265331129, -122.08332357078792));
    polygonCoordinates.add(LatLng(37.43296265331129, -122.08832357078792));

    Set<Polygon> polygonSet = new Set();
    polygonSet.add(Polygon(
        polygonId: PolygonId('test'),
        points: polygonCoordinates,
        strokeColor: Colors.red));

    return polygonSet;
  }
}
