
import 'package:elandguard/Component/AccountSettings.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/userScreens/Settings/profile.dart';
import 'package:flutter/material.dart';

import 'ChangePassword.dart';

class ProfileSettingsScreen extends StatefulWidget {

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 23,
            // color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GirliesProfile(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: AccountSettings(
                    selectIcon: Icons.person,
                    settingText: "Profile",
                  ),
                ),
              ),
              Divider(
                color: Colors.black38,
                endIndent: 20,
                indent: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: AccountSettings(
                    selectIcon: Icons.lock,
                    settingText: "Change Password",
                  ),
                ),
              ),
              Divider(
                color: Colors.black38,
                endIndent: 20,
                indent: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: AccountSettings(
                    selectIcon: Icons.lock,
                    settingText: "Change Password",
                  ),
                ),
              ),
              Divider(
                color: Colors.black38,
                endIndent: 20,
                indent: 20,
              ),
              // AccountSettings(
              //   selectIcon: Icons.vpn_key_sharp,
              //   settingText: "Set pin",
              // ),
              // Divider(
              //   color: Colors.black38,
              //   endIndent: 20,
              //   indent: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
