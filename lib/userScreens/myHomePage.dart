//import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';
import 'dart:io';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/Constants.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/constants.dart';
import 'package:elandguard/databaseTools/UserDB.dart';
import 'package:elandguard/databaseTools/UserDBImp.dart';
import 'package:elandguard/model/AppData.dart';
import 'package:elandguard/model/InvoiceModel.dart';
import 'package:elandguard/model/ServiceCharge.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/userScreens/Invoice/InvoiceScreen.dart';
import 'package:elandguard/userScreens/Notifications/NotificationScreen.dart';
import 'package:elandguard/userScreens/Payment/PaymentHistoryScreen.dart';
import 'package:elandguard/userScreens/SitePlanLocation/ScanSiteCoordinates.dart';
import 'package:elandguard/userScreens/TitleCertificate/TitleCertificateScreen.dart';
import 'package:elandguard/userScreens/TrackJob/TrackJobScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'FAQs/FAQScreen.dart';
import 'Login/login.dart';
import 'VerifyRateableValue/VerifyRateableValue.dart';
import 'VerifySite/VerifySiteScreen.dart';
import 'WebViewerScreen/WebViewerScreen.dart';
import 'aboutUs.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserDBImplementation dbImplementation = UserDBImplementation();
  UserDB userDB = UserDB();
  UserProfileModel user;

  BuildContext context;
  String acctName = "";
  String acctEmail = "";
  String acctPhotoURL = "";
  bool isLoggedIn;

  File imageFile;

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
  }

  void setProfilePicture() async {
    try {
      if (user.picture != null) {
        final decodedBytes = base64Decode(user.picture);
        final directory = await getApplicationDocumentsDirectory();
        var file = File("${directory.path}/profile.png");
        file.writeAsBytesSync(decodedBytes);
        setState(() {
          imageFile = file;
        });
      }
    } catch (e) {
      print('setProfilePicture err: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppData>(context, listen: false).userData;
    setProfilePicture();

    // print('User from home page: $user');
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: kPrimaryTheme,
        title: GestureDetector(
          // onLongPress: openAdmin,
          child: new Text(
            "PropertyWatch",
            style: GoogleFonts.lato(),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              new IconButton(
                icon: new Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  goToNotifications(context);
                },
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              (user != null && user.name != null)
                  ? "Welcome back, ${user.name}."
                  : "Welcome back.",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                // decoration: TextDecoration.underline
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "QUICK MENU",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                // decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 5.0,
            ),
            //View location of site plan
            GestureDetector(
              onTap: () {
                // getServiceCharge(serviceCode: 'VP', context: context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanSiteCoordinates(),
                  ),
                );
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.1,
                      color: Colors.black38,
                      spreadRadius: 0.1,
                      offset: Offset(0.1, 0.3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 30,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/location-pin.png"),
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Tooltip(
                                    message: SERVICE_1_TOOLTIP,
                                    child: Text(
                                      SERVICE_1,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            new UtilityService().notificationMessageWithButton(
                              title: SERVICE_1,
                              message: SERVICE_1_INFO,
                              context: context,
                              buttonText: 'OK',
                              color: kPrimaryTheme,
                              proceed: () {
                                Navigator.of(context).pop();
                              },
                              backgroundColor: Colors.white,
                              textColor: Colors.black54,
                            );
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.info_outline,
                              color: kPrimaryTheme,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //Plot site boundaries
            GestureDetector(
              onTap: () {
                // getServiceCharge(serviceCode: 'VSL', context: context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifySiteScreen(),
                  ),
                );
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.1,
                      color: Colors.black38,
                      spreadRadius: 0.1,
                      offset: Offset(0.1, 0.3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 30,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/location-pin.png"),
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Tooltip(
                                    message: SERVICE_2_TOOLTIP,
                                    child: Text(
                                      SERVICE_2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            new UtilityService().notificationMessageWithButton(
                              title: SERVICE_2,
                              message: SERVICE_2_INFO,
                              context: context,
                              buttonText: 'OK',
                              color: kPrimaryTheme,
                              proceed: () {
                                Navigator.of(context).pop();
                              },
                              backgroundColor: Colors.white,
                              textColor: Colors.black54,
                            );
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.info_outline,
                              color: kPrimaryTheme,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //Verify rateable value
            GestureDetector(
              onTap: () {
                // getServiceCharge(serviceCode: 'VSL', context: context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyRateableValue(),
                  ),
                );
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.1,
                      color: Colors.black38,
                      spreadRadius: 0.1,
                      offset: Offset(0.1, 0.3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 25,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/circleCheck.png"),
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Tooltip(
                                    message: SERVICE_3_TOOLTIP,
                                    child: Text(
                                      SERVICE_3,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            new UtilityService().notificationMessageWithButton(
                              title: SERVICE_3,
                              message: SERVICE_3_INFO,
                              context: context,
                              buttonText: 'OK',
                              color: kPrimaryTheme,
                              proceed: () {
                                Navigator.of(context).pop();
                              },
                              backgroundColor: Colors.white,
                              textColor: Colors.black54,
                            );
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.info_outline,
                              color: kPrimaryTheme,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Verify title certificate
            GestureDetector(
              onTap: () {
                // getServiceCharge(serviceCode: 'VSL', context: context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TitleCertificateScreen(),
                  ),
                );
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.1,
                      color: Colors.black38,
                      spreadRadius: 0.1,
                      offset: Offset(0.1, 0.3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/verified.png"),
                                    color: Colors.cyan,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Tooltip(
                                    message: SERVICE_4_TOOLTIP,
                                    child: Text(
                                      SERVICE_4,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            new UtilityService().notificationMessageWithButton(
                              title: SERVICE_4,
                              message: SERVICE_4_INFO,
                              context: context,
                              buttonText: 'OK',
                              color: kPrimaryTheme,
                              proceed: () {
                                Navigator.of(context).pop();
                              },
                              backgroundColor: Colors.white,
                              textColor: Colors.black54,
                            );
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.info_outline,
                              color: kPrimaryTheme,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Track Job
            GestureDetector(
              onTap: () {
                // getServiceCharge(serviceCode: 'VSL', context: context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackJobScreen(),
                  ),
                );
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.1,
                      color: Colors.black38,
                      spreadRadius: 0.1,
                      offset: Offset(0.1, 0.3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 25,
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/search.png"),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Tooltip(
                                    message: SERVICE_5_TOOLTIP,
                                    child: Text(
                                      SERVICE_5,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            new UtilityService().notificationMessageWithButton(
                              title: SERVICE_5,
                              message: SERVICE_5_INFO,
                              context: context,
                              buttonText: 'OK',
                              color: kPrimaryTheme,
                              proceed: () {
                                Navigator.of(context).pop();
                              },
                              backgroundColor: Colors.white,
                              textColor: Colors.black54,
                            );
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.info_outline,
                              color: kPrimaryTheme,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black38,
            ),
            Text(
              "Misc",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                // decoration: TextDecoration.underline,
              ),
            ),
            Divider(
              color: Colors.black38,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.1,
                          color: Colors.black38,
                          spreadRadius: 0.1,
                          offset: Offset(0.1, 0.3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              child: Icon(
                                Icons.notifications_none_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "My Notifications",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "0",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                goToNotifications(context);
                              },
                              child: Text(
                                "View",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.1,
                          color: Colors.black38,
                          spreadRadius: 0.1,
                          offset: Offset(0.1, 0.3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundColor: Colors.cyan,
                              child: Icon(
                                Icons.payment_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "My Payments",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${(Provider.of<AppData>(context, listen: false).paymentHistory)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                getPaymentHistory(
                                    email: user.email, context: context);
                              },
                              child: Text(
                                "View",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12),
            //           boxShadow: [
            //             BoxShadow(
            //               blurRadius: 0.1,
            //               color: Colors.black38,
            //               spreadRadius: 0.1,
            //               offset: Offset(0.1, 0.3),
            //             ),
            //           ],
            //           color: Colors.white,
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                 flex: 1,
            //                 child: CircleAvatar(
            //                   backgroundColor: Colors.orange,
            //                   child: Icon(
            //                     Icons.history_outlined,
            //                     size: 25,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Expanded(
            //                 flex: 3,
            //                 child: Text(
            //                   "My Recent Transactions",
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: GoogleFonts.lato(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w400,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Expanded(
            //                 child: Text(
            //                   '${(Provider.of<AppData>(context, listen: false).paymentHistory)}',
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: GoogleFonts.lato(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Expanded(
            //                 child: GestureDetector(
            //                   onTap: () {
            //                     getPaymentHistory(
            //                         email: user.email, context: context);
            //                   },
            //                   child: Text(
            //                     "View",
            //                     maxLines: 1,
            //                     overflow: TextOverflow.ellipsis,
            //                     style: GoogleFonts.montserrat(
            //                       fontSize: 13,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Version: $VERSION",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Material(
          color: Colors.black12,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            kPrimaryTheme,
                            Colors.teal,
                          ],
                        ),
                      ),
                      child: Container(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: imageFile == null
                                  ? AssetImage('assets/images/no_user.jpg')
                                  : FileImage(imageFile),
                              radius: 25,
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (user != null && user.name != null)
                                      ? "${user.name}"
                                      : "User",
                                  style: GoogleFonts.lato(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.pink,
                        child: new Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("App Notifications"),
                      onTap: () {
                        goToNotifications(context);
                      },
                    ),
                    new Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black38,
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.teal,
                        child: new Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("History"),
                      onTap: () {
                        getPaymentHistory(
                          email: user.email,
                          context: context,
                        );
                      },
                    ),

                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.cyan,
                        child: new Icon(
                          Icons.help,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("About App"),
                      onTap: () {
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                new GirliesAboutUs()));
                      },
                      //
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.orange,
                        child: new Icon(
                          Icons.policy,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("Terms & Conditions"),
                      onTap: () {
                        Navigator.of(context).push(
                          new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                new WebViewerScreen(
                              title: 'Terms & Conditions',
                              path: TERMS_URL,
                            ),
                          ),
                        );
                      },
                      //
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.cyan,
                        child: new Icon(
                          Icons.policy,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("Privacy Policy"),
                      onTap: () {
                        Navigator.of(context).push(
                          new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                new WebViewerScreen(
                              title: 'Privacy Policy',
                              path: PRIVACY_URL,
                            ),
                          ),
                        );
                      },
                      //
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.lightBlue,
                        child: new Icon(
                          Icons.help_outline,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("FAQs"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FAQScreen(),
                          ),
                        );
                      },
                      //
                    ),
                    new Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black38,
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.red,
                        child: new Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("Logout"),
                      onTap: () {
                        new UtilityService().confirmationBox(
                            title: 'Confirm Logout',
                            message: 'Are you sure you want to logout?',
                            context: context,
                            yesColor: Colors.teal,
                            yesLabel: 'Logout',
                            noLabel: 'Cancel',
                            noColor: Colors.deepOrange,
                            buttonHeight: 30,
                            buttonWidth: 100,
                            onYes: () {
                              Navigator.pop(context);
                              clearUserDB(context);
                            },
                            onNo: () {
                              Navigator.pop(context);
                            });
                      },
                    ),
                    new Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black38,
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    // ListTileMenuComponent(
                    //   icon: Icons.format_paint_rounded,
                    //   label: 'Themes',
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      child: Column(
                        children: [
                          Divider(
                            thickness: 0.3,
                            color: Colors.teal,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Center(
                            child: Container(
                              child: Text(
                                'Version $VERSION',
                                style: GoogleFonts.lato(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.teal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationScreen(),
      ),
    );
  }

  void getServiceCharge({String serviceCode, BuildContext context}) async {
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

  void getPaymentHistory({String email, BuildContext context}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );
      String url = '$PAYMENT_HISTORY_URL/$email';
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
          var list = data['data'] as List;
          List<InvoiceModel> paymentList = [];
          if (list.isNotEmpty) {
            for (int i = 0; i < list.length; i++) {
              print(data['data'][i]['status']);
              if (data['data'][i]['status'] != null ||
                  data['data'][i]['status'] != "null") {
                InvoiceModel model = InvoiceModel(
                  serviceCode: data['data'][i]['serviceCode'],
                  serviceName: data['data'][i]['serviceName'],
                  amount: data['data'][i]['amount'],
                  tax: data['data'][i]['tax'],
                  paymentAmount: data['data'][i]['paymentAmount'],
                  paymentDate: data['data'][i]['paymentDate'],
                  paymentMode: data['data'][i]['paymentMode'],
                  clientReference: data['data'][i]['clientReference'],
                  invoiceNo: data['data'][i]['invoiceNo'],
                  status: data['data'][i]['status'],
                  name: data['data'][i]['name'],
                  requestObject: data['data'][i]['requestObject'],
                );
                paymentList.add(model);
              }
            }
          }
          setState(() {
            Provider.of<AppData>(context, listen: false)
                .updatePaymentHistory(paymentList.length);
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentHistoryScreen(
                list: paymentList,
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

  void clearUserDB(BuildContext context) async {
    try {
      await dbImplementation.deleteAll();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } catch (e) {
      print('Clear user db error: $e');
    }
  }

  showAlertDialog(
      {BuildContext context,
      String title,
      String message,
      String cancelText,
      String proceedText,
      Function cancelFunction,
      Function proceedFunction}) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(cancelText),
      onPressed: cancelFunction,
    );
    Widget continueButton = FlatButton(
      child: Text(proceedText),
      onPressed: proceedFunction,
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Column serviceWidget(String img, String name) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xfff1f3f6),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/$img.png'))),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'avenir',
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Container avatarWidget(String img, String name) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 150,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xfff1f3f6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/images/$img.png'),
                    fit: BoxFit.contain),
                border: Border.all(color: Colors.black, width: 2)),
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  // checkIfLoggedIn() async {
  //   if (isLoggedIn == false) {
  //     bool response = await Navigator.of(context).push(new CupertinoPageRoute(
  //         builder: (BuildContext context) => new LoginScreen()));
  //     if (response == true) getCurrentUser();
  //     return;
  //   }
  //   /* bool response = await appMethods.logOutUser();
  //   if (response == true) getCurrentUser(); */
  // }

  // openAdmin() {
  //   Navigator.of(context).push(new MaterialPageRoute(
  //       builder: (BuildContext context) => new AdminHome()));
  // }

  // Row buildPreventation() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       PreventitonCard(
  //         svgSrc: "assets/icons/hand_wash.svg",
  //         title: "Wash Hands",
  //       ),
  //       PreventitonCard(
  //         svgSrc: "assets/icons/use_mask.svg",
  //         title: "Use Masks",
  //       ),
  //       PreventitonCard(
  //         svgSrc: "assets/icons/Clean_Disinfect.svg",
  //         title: "Clean Disinfect",
  //       ),
  //     ],
  //   );
  // }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  // TextSpan(
                  //   text: "Dial 999 for \nMedical Help!\n",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headline
                  //       .copyWith(color: Colors.white),
                  // ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
      ],
    );
  }

// class PreventitonCard extends StatelessWidget {
//   final String svgSrc;
//   final String title;
//   const PreventitonCard({
//     Key key,
//     this.svgSrc,
//     this.title,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SvgPicture.asset(svgSrc),
//         // Text(
//         //   title,
//         //   style:
//         //       Theme.of(context).textTheme.body1.copyWith(color: kPrimaryColor),
//         // )
//       ],
//     );
//   }
// }
}
