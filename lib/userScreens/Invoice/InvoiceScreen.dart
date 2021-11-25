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

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen();

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  var emailController = TextEditingController();
  _InvoiceScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundTheme,
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Invoice",
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Please view your service invoice below.',
                      style: GoogleFonts.lato(),
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
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Invoice #:',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    // color: Colors.pink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '1232323',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Date:',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    // color: Colors.pink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '1232323',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Service',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    // color: Colors.pink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Amount (GHS)',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Verify Plan',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    // color: Colors.pink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '250.00',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Tax',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    // color: Colors.pink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '-',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Total',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    // color: Colors.pink,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '250.00',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButtonComponent(
                      labelColor: kPrimaryTheme,
                      textColor: Colors.white,
                      label: "Proceed to make payment",
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
