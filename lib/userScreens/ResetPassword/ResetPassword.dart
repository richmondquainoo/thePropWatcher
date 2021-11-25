import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/databaseTools/UserDB.dart';
import 'package:elandguard/databaseTools/UserDBImp.dart';
import 'package:elandguard/model/AppData.dart';
import 'package:elandguard/model/OtpModel.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/userScreens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../myHomePage.dart';

class SetProfileScreen extends StatefulWidget {
  final OTPModel otpModel;

  SetProfileScreen({this.otpModel});

  @override
  _SetProfileScreenState createState() => _SetProfileScreenState(otpModel);
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  final OTPModel otpModel;
  var profileNameController = TextEditingController();
  var confirmController = TextEditingController();
  var setPasswordController = TextEditingController();

  String confirm;
  String phone;
  String setPassword;
  String email;

  _SetProfileScreenState(this.otpModel);

  UserDBImplementation dbImplementation = UserDBImplementation();
  UserDB userDB = UserDB();
  UserProfileModel user;
  String base64Encoded;
  @override
  void initState() {
    super.initState();
    initializeDB();
  }

  void initializeDB() async {
    try {
      await userDB.initialize();
      getUserInfo();
    } catch (e) {
      print('init err: $e');
    }
  }

  void getUserInfo() async {
    UserProfileModel u = await dbImplementation.getUser();
    setState(() {
      user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundTheme,
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Reset my password",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: kPrimaryTheme),
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Column(
            children: [
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 48,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: Center(
                        child: TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          controller: setPasswordController,
                          onChanged: (value) {
                            setPassword = value;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: const BorderSide(
                                  color: kPrimaryTheme, width: 0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black54,
                            ),
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 48,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: Center(
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          controller: confirmController,
                          onChanged: (value) {
                            confirm = value;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: const BorderSide(
                                  color: kPrimaryTheme, width: 0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black54,
                            ),
                            hintText: 'Confirm Password',
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButtonComponent(
                      labelColor: kPrimaryTheme,
                      textColor: Colors.white,
                      label: "Reset Password",
                      onTap: () async {
                        print('reset otp: $otpModel');
                        bool canProceed = isValidEntries(context);
                        if (canProceed) {
                          //Reset password
                          await confirmReset(context);
                        }
                      },
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

  Future<void> confirmReset(BuildContext context) async {
    //Prepare data for post
    UserProfileModel model = UserProfileModel(
      email: otpModel.email,
      password: confirmController.text,
    );
    await dbImplementation.saveUser(model);
    new UtilityService().confirmationBox(
        title: 'Confirmation',
        message: 'Are you sure you want to reset your password?',
        context: context,
        color: Colors.blueAccent,
        onYes: () {
          Navigator.pop(context);
          resetPassword(dataModel: model, context: context);
        },
        onNo: () {
          Navigator.pop(context);
        });
  }

  void resetPassword({UserProfileModel dataModel, BuildContext context}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );
      var jsonBody = jsonEncode(dataModel);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postDataWithAuth(
          url: RESET_PASSWORD_URL,
          body: jsonBody,
          auth: 'Bearer $ACCESS_TOKEN');

      print('Reset response: ${response.body}');

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
        // //when there is a response to handle
        // int status = response.statusCode;
        var data = jsonDecode(response.body);

        int status = data['status'];
        print('Status: $status');
        // Handle network error
        if (status == 500 || status == 404 || status == 403 || status == -111) {
          new UtilityService().showMessage(
            message: 'An error has occurred. Please try again',
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            context: context,
          );
        } else {
          print('Body: ${response.body}');

          //Check if record exist in the local db
          UserDBImplementation dbImplementation = UserDBImplementation();
          UserProfileModel foundLocally =
              await dbImplementation.getByEmail(data['data']['email']);

          //if record exists locally, update local record
          if (foundLocally != null) {
            print('foundLocally: $foundLocally');
            foundLocally.password = confirmController.text;
            bool updated = await dbImplementation.updateUser(foundLocally);
            //if record updated successfully, go to login page
            if (updated) {
              new UtilityService().showMessage(
                context: context,
                message: 'Password reset successful',
                icon: Icon(
                  Icons.check,
                  color: Colors.teal,
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }
            //else show error message
            else {
              new UtilityService().showMessage(
                context: context,
                message: 'An attempt to update user record failed.',
                icon: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
              );
            }
          }
          //if record doesn't exists locally, save record
          else {
            UserProfileModel model = new UserProfileModel(
              name: data['data']['name'],
              email: data['data']['email'],
              password: confirmController.text,
              phone: data['data']['phone'],
            );

            saveUserDetailsLocally(model);
          }
        }
      }
    } catch (e) {
      print('postUserData error: $e');
      new UtilityService().showMessage(
        context: context,
        message: 'An error has occurred. Please try again',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void saveUserDetailsLocally(UserProfileModel user) async {
    try {
      UserDBImplementation dbImplementation = UserDBImplementation();
      UserDB userDB = UserDB();

      await userDB.initialize();
      await userDB.deleteAll();

      await dbImplementation.saveUser(user);
      Provider.of<AppData>(context, listen: false).updateUserData(user);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    } catch (e) {
      print('saving user data to local db error: $e');
    }
  }

  bool isValidEntries(BuildContext context) {
    if (setPasswordController.text.length == 0) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter password',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (setPasswordController.text.length < 4) {
      new UtilityService().showMessage(
        context: context,
        message: 'Password must be 4+ character long',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (setPasswordController.text != confirmController.text) {
      new UtilityService().showMessage(
        context: context,
        message: 'Passwords mismatch',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
