
import 'package:elandguard/userScreens/OTPScreen/OtpScreen.dart';
import 'package:elandguard/userScreens/Settings/ProfileSettingsScreen.dart';
import 'package:elandguard/userScreens/SetProfileDetails/SetProfile.dart';
import 'package:elandguard/userScreens/SignUpScreen/Signup.dart';
import 'package:elandguard/userScreens/SplashScreen/Splash%20Screen.dart';
import 'package:elandguard/userScreens/myHomePage.dart';
import 'package:elandguard/userScreens/Settings/profile.dart';
import 'package:flutter/material.dart';
import 'userScreens/Login/login.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Property Watch',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
