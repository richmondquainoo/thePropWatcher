import 'dart:convert';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class ChangePassword extends StatefulWidget {

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var repeatPasswordController = TextEditingController();


  String oldPassword;
  String newPassword;
  String repeatPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Icon(
                          Icons.lock,
                          color: kPrimaryTheme,
                          size: 63,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height:45,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          // color: Colors.black38,
                          border: Border.all(
                              color: kPrimaryTheme, // set border color
                              width: 0.95), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          // style: TextStyle(color: Colors.white),
                          obscureText: true,
                          controller: oldPasswordController,
                          onChanged: (value) {
                            oldPassword = value;
                          },
                          decoration: InputDecoration(
                            // labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Old Password',
                            hintStyle: TextStyle(
                              // color: Colors.white,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height:45,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          // color: Colors.black38,
                          border: Border.all(
                              color: kPrimaryTheme, // set border color
                              width: 0.95), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          // style: TextStyle(color: Colors.white),
                          obscureText: true,
                          controller: newPasswordController,
                          onChanged: (value) {
                            newPassword = value;
                          },
                          decoration: InputDecoration(
                            // labelStyle: TextStyle(color: Colors.white),
                            // hintStyle: TextStyle(
                            //   color: Colors.white,
                            // ),
                            // fillColor: Colors.grey,
                            // filled: true,
                            hintText: 'New Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height:45,
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          // color: Colors.black38,
                          border: Border.all(
                              color: kPrimaryTheme, // set border color
                              width: 0.95), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          // style: TextStyle(color: Colors.white),
                          obscureText: true,
                          controller: repeatPasswordController,
                          onChanged: (value) {
                            repeatPassword = value;
                          },
                          decoration: InputDecoration(
                            // labelStyle: TextStyle(color: Colors.white),
                            // hintStyle: TextStyle(
                            //   color: Colors.white,
                            // ),
                            hintText: 'Repeat Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextButtonComponent(
                        label: "Done",
                        onTap: () {
                          bool canProceed = isValidEntries(context);
                          if(canProceed){

                            new UtilityService().confirmationBox(
                                title: 'Confirmation',
                                message: 'Are you sure you want to proceed with the registration?',
                                context: context,
                                color: Colors.blueAccent,
                                onYes: (){
                                  Navigator.pop(context);
                                },
                                onNo: (){
                                  Navigator.pop(context);
                                }
                            );
                          }


                          },
                        labelColor:kPrimaryTheme
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(30.0),
                      //   child: Container(
                      //     child: Align(
                      //       alignment: FractionalOffset.bottomCenter,
                      //       child: Column(
                      //         children: [
                      //           Divider(
                      //             thickness: 0.3,
                      //             color: Colors.white,
                      //           ),
                      //           SizedBox(
                      //             height: 6,
                      //           ),
                      //           Center(
                      //             child: Container(
                      //               child: Text(
                      //                 'Version 1.1.0',
                      //                 style: GoogleFonts.lato(
                      //                     fontSize: 13,
                      //                     fontWeight: FontWeight.w400,
                      //                     color: Colors.blueAccent),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  bool isValidEntries(BuildContext context) {
    if (oldPasswordController.text.length == 0) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter old password',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (newPasswordController.text.length == 0) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter new password',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (newPasswordController.text.length < 6) {
      new UtilityService().showMessage(
        context: context,
        message: 'Invalid length of password. Password must be 6+ characters',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    }
    else if (repeatPasswordController.text.length < 5) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please repeat password',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else {
      return true;
    }
    return false;
  }
}
