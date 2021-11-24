//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/adminScreens/admin_home.dart';
import 'package:elandguard/constants.dart';
import 'package:elandguard/databaseTools/UserDB.dart';
import 'package:elandguard/databaseTools/UserDBImp.dart';
import 'package:elandguard/model/UserProfileModel.dart';

import 'package:elandguard/userScreens/Payment/PaymentScreen.dart';
import 'package:elandguard/userScreens/Settings/ProfileSettingsScreen.dart';
import 'package:elandguard/userScreens/SplashScreen/Splash%20Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Payment/Payment.dart';
import 'aboutUs.dart';
import 'delivery.dart';
import 'History/history.dart';
import 'notifications.dart';

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

  // AppMethods appMethods = new FirebaseMethods();
  //

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
  }

  //
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
  //   // TODO: implement initState
  //   // getCurrentUser();
  // }
  //
  // Future getCurrentUser() async {
  //   //acctName = await getStringDataLocally(key: acctFullName);
  //   //acctEmail = await getStringDataLocally(key: userEmail);
  //   acctPhotoURL = await getStringDataLocally(key: photoURL);
  //   isLoggedIn = await getBoolDataLocally(key: loggedIN);
  //
  //   var data = json.decode(loginUser);
  //   var responsedata = data['data'];
  //   for (var items in responsedata) {
  //     //iterate over the list
  //     Map myMap = items; //store each map
  //     acctName = myMap['fullname'];
  //     acctEmail = myMap['email_address'];
  //     AppGlobals.global_user_id = myMap['userid'].toString();
  //   }
  //
  //   //print(await getStringDataLocally(key: userEmail));
  //   acctName == null ? acctName = "name" : acctName;
  //   acctEmail == null ? acctEmail = "email" : acctEmail;
  //   setState(() {});
  // }


  @override
  Widget build(BuildContext context) {
    // this.context = context;
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: kPrimaryTheme,
        title: GestureDetector(
          // onLongPress: openAdmin,
          child: new Text(
            "Land Guard Services",
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
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Welcome back, John.",
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
              height: 3.0,
            ),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(new CupertinoPageRoute(
                    //     builder: (context) => ScanScreen()));
                  },
                  child: Container(
                    height: 88,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            child: Image(
                              image:
                              AssetImage("assets/images/circleCheck.png"),
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "Verify Plan",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    // Navigator.of(context).push(new CupertinoPageRoute(
                    //     builder: (context) => VerifyCertificate()));
                  },
                  child: Container(
                    height: 88,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            child: Image(
                              image: AssetImage("assets/images/verified.png"),
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              "Verify Title Certificate",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(new CupertinoPageRoute(
                    //     builder: (context) => VerifyRateableValue()));
                  },
                  child: Container(
                    height: 88,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            child: Image(
                              image: AssetImage("assets/images/verify.png"),
                              color: Colors.lightBlue,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "Verify Rateable Values",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    // Navigator.of(context).push(new CupertinoPageRoute(
                    //     builder: (context) => TrackJob()));
                  },
                  child: Container(
                    height: 88,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            child: Image(
                              image: AssetImage("assets/images/add.png"),
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              "Track Job",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(new CupertinoPageRoute(
                    //     builder: (context) => ScanScreen()));
                  },
                  child: Container(
                    height: 88,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            child: Image(
                              image:
                              AssetImage("assets/images/location-pin.png"),
                              color: Colors.pink,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "Verify Location",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    // Navigator.of(context).push(new CupertinoPageRoute(
                    //     builder: (context) => GirliesTrackApplication()));
                  },
                  child: Container(
                    height: 88,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            child: Image(
                              image: AssetImage("assets/images/search.png"),
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              "Verify Search",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
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
                              onTap: () {},
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
                              onTap: () {},
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
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.history_outlined,
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
                              "My Recent Transactions",
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
                              onTap: () {},
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
              height: 30,
            ),
            Center(
              child: Text(
                "Version: 1.0.1",
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
                              backgroundImage:
                              AssetImage('assets/images/no_user.jpg'),
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
                                  "username",
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
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                            new GirliesNotifications()));
                      },
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
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                            new HistoryScreen()));
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
                        backgroundColor: Colors.blueGrey,
                        child: new Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("Settings"),
                      onTap: () {
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                            new ProfileSettingsScreen()));
                      },
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.deepOrange,
                        child: new Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("Delivery Address"),
                      onTap: () {
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                            new GirliesDelivery()));
                      },
                    ),
                    new ListTile(
                      leading: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.amber,
                        child: new Icon(
                          Icons.payment_rounded,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("Payment"),
                      onTap: () {
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                Payment()));
                      },
                    ),
                    new Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black38,
                    ),
                    new ListTile(
                      trailing: new CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.cyan,
                        child: new Icon(
                          Icons.help,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      title: new Text("About Us"),
                      onTap: () {
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                            new GirliesAboutUs()));
                      },
                      //
                    ),
                    new ListTile(
                      trailing: new CircleAvatar(
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
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                            new SplashScreen()));
                      },
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
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Center(
                            child: Container(
                              child: Text(
                                'Version 1.0.0',
                                style: GoogleFonts.lato(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue),
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
                fontSize: 16,
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
              left: MediaQuery
                  .of(context)
                  .size
                  .width * .4,
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
