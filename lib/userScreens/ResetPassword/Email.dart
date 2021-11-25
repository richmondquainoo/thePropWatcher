import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/OtpModel.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/userScreens/OTPScreen/OtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class EmailScreen extends StatefulWidget {
  EmailScreen();

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  var emailController = TextEditingController();
  _EmailScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundTheme,
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Enter your email",
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
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26),
                child: Column(
                  children: [
                    Text(
                      'Please enter the email address you used in creating your account.',
                      style: GoogleFonts.lato(),
                    ),
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
                          obscureText: false,
                          style: TextStyle(color: Colors.black),
                          controller: emailController,
                          onChanged: (value) {},
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
                              Icons.email,
                              color: Colors.black54,
                            ),
                            hintText: 'Email',
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
                      label: "Proceed",
                      onTap: () {
                        bool canProceed = isValidEntries(context);
                        if (canProceed) {
                          generateResetOTP(context);
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

  Future<void> generateResetOTP(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );
      UserProfileModel model = UserProfileModel(email: emailController.text);
      var jsonBody = jsonEncode(model);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postDataWithAuth(
          url: RESET_OTP_URL, body: jsonBody, auth: 'Bearer $ACCESS_TOKEN');

      print('Reset otp response: ${response.body}');

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
          print('Body: ${response.body}');
          OTPModel otpModel = new OTPModel(
            name: data['data']['name'],
            email: data['data']['email'],
            pin: data['data']['pin'],
            phone: data['data']['phone'],
            // password: passwordController.text,
          );
          print('otp: $otpModel');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                otpModel: otpModel,
                track: 'Reset',
              ),
            ),
          );
        } else {
          new UtilityService().showMessage(
            message: data['message'],
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            context: context,
          );
        }
      }
    } catch (e) {
      print('generateResetOTP error: $e');
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

  bool isValidEntries(BuildContext context) {
    if (emailController.text.length == 0 ||
        !emailController.text.contains("@") ||
        !emailController.text.contains(".")) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter password',
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
