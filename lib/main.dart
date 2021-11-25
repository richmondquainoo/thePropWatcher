import 'package:elandguard/userScreens/SplashScreen/Splash%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/AppData.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ' Property Watch',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
