import 'dart:async';

import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/databaseTools/UserDBImp.dart';
import 'package:elandguard/model/AppData.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/userScreens/Login/login.dart';
import 'package:elandguard/userScreens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  bool proceed = false;
  UserDBImplementation implementation = UserDBImplementation();

  @override
  void initState() {
    super.initState();
    // Timer(
    //   Duration(seconds: 5),
    //   () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => LoginScreen(),
    //     ),
    //   ),
    // );
    controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        proceed = true;
        authenticate(context);
        // goToHome();
      }
    });
  }

  Future<void> authenticate(BuildContext context) async {
    try {
      UserProfileModel user = await implementation.getLoggedInUser();
      if (user != null) {
        print('logged in: ${user.loggedIn}');
        await goToHome(user: user);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    } catch (e) {
      print('Authenticate error: $e');
    }
  }

  Future<void> goToHome({UserProfileModel user}) async {
    Provider.of<AppData>(context, listen: false).updateUserData(user);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: kBackgroundTheme,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/propWatch.png',
                        height: animation.value * 150,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "PropertyWatch",
                        style: TextStyle(
                            color: kPrimaryTheme,
                            fontWeight: FontWeight.w400,
                            fontSize: animation.value * 20,
                            letterSpacing: 1.3,
                            wordSpacing: 1.4),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      // value: 5,
                      valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Version $VERSION",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.black,
                          letterSpacing: 0.8),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
