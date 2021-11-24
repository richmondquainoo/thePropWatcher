import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/OtpModel.dart';
import 'package:elandguard/tools/progressdialog.dart';
import 'package:elandguard/userScreens/OTPScreen/OtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:elandguard/tools/app_data.dart';
import 'package:elandguard/tools/app_methods.dart';
import 'package:elandguard/tools/app_tools.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:elandguard/userScreens/Login/login.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

//
//  final String posturl = "http://141.136.36.89:8080/swa_service/rest/";
//
//  Future<String> createUserAccount(String jsonRequest) async {
//     //
//     final queryParameters = jsonRequest;
//
// //final uri =Uri.https(posturl, 'client_account_mgt_service/select_tbl_client_account_add_update', queryParameters);
//
//     //parse
//    // encodeFull
//
//   //final uri =Uri.https('www.myurl.com', '/api/v1/test/${widget.pk}', queryParameters);
//       //var url = Uri.parse('https://example.com/whatsit/create');
//        //var url = Uri.encodeFull(posturl+"client_account_mgt_service/select_tbl_client_account_add_update");
//     final  response = await http.post(Uri.parse(posturl+"client_account_mgt_service/select_tbl_client_account_add_update"),
//       headers: {
//         "Accept": "application/json"
//       },
//       body: jsonRequest
//     );
//
//     if(response.statusCode == 200){
//     final String responseString = response.body;
//     return responseString;
//   }else{
//     return null;
//   }
//
//   }
//
//
//
// Future<String> sendSMS(String jsonRequest) async {
//     final response = await http.post(Uri.parse(posturl+"sms_service/select_log_sms_alert"),
//       headers: {
//         "Accept": "application/json"
//       },
//       body: jsonRequest
//     );
//
//     if(response.statusCode == 200){
//     final String responseString = response.body;
//     return responseString;
//   }else{
//     return null;
//   }
//
//   }

class _SignUpState extends State<SignUp> {
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  // UserDB userDB = UserDB();
  String fullName;
  String email;
  String phone;
  String password;
  String passwordConfirm;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: kBackgroundTheme,
      appBar: new AppBar(
        backgroundColor: kBackgroundTheme,
        title: new Text("Sign Up", style: TextStyle(fontSize: 18, color: kPrimaryTheme),),
        centerTitle: false,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_outlined, color: kPrimaryTheme,),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Log In",
                style: TextStyle(
                    color: kPrimaryTheme,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
      body: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 35),
          child: new Column(
            children: <Widget>[
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
                    style: TextStyle(color: Colors.black87),
                    controller: fullNameController,
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black87, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                          ),
                        borderSide: const BorderSide(color: kPrimaryTheme, width: 0.7),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.black54,),
                      hintText: 'FullName',
                      hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                  ),
                ),
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
                    style: TextStyle(color: Colors.black87),
                    controller: phoneController,
                    onChanged: (value) {
                      phone = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black87, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)
                          ),
                        borderSide: const BorderSide(color: kPrimaryTheme, width: 0.7),
                      ),
                      prefixIcon: Icon(Icons.phone, color: Colors.black54,),
                      hintText: 'Phone',
                      hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
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
                    style: TextStyle(color: Colors.black87),
                    controller: emailController,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black87, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)
                          ),
                        borderSide: const BorderSide(color: kPrimaryTheme, width: 0.7),
                      ),
                      prefixIcon: Icon(Icons.mail, color: Colors.black54,),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
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
                    obscureText: true,
                    style: TextStyle(color: Colors.black87),
                    controller: passwordController,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black87, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)
                          ),
                        borderSide: const BorderSide(color: kPrimaryTheme, width: 0.7),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.black54,),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
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
                    obscureText: true,
                    style: TextStyle(color: Colors.black87),
                    controller: passwordConfirmController,
                    onChanged: (value) {
                      passwordConfirm = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black87, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)
                          ),
                        borderSide: const BorderSide(color: kPrimaryTheme, width: 0.7),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.black54,),
                      hintText: 'Password Confirm',
                      hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 12),
                child: TextButtonComponent(
                  labelColor: kPrimaryTheme,
                  label: "Create Account",
                  textColor: Colors.white,
                  onTap: () {
                    bool canProceed = isValidEntries(context);
                    if (canProceed) {
                      OTPModel model = OTPModel(
                        name: fullName,
                        email: email,
                        password: password,
                        phone: phone,
                      );
                      new UtilityService().confirmationBox(
                          title: 'Confirmation',
                          message:
                              'Are you sure you want to proceed with the account creation?',
                          context: context,
                          color: Colors.blueAccent,
                          onYes: () {
                            Navigator.pop(context);
                            createOTP(context: context, dataModel: model);
                          },
                          onNo: () {
                            Navigator.pop(context);
                          });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      children: [
                        Divider(
                          thickness: 0.0,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              'Version 1.0.1',
                              style: GoogleFonts.lato(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87),
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
        ),
      ),
    );
  }

  bool isValidEntries(BuildContext context) {
    if (fullNameController.text.length == 0) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter full name',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (phoneController.text.length != 10) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter valid phone number',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (emailController.text.length == 0 ||
        !emailController.text.contains("@") ||
        !emailController.text.contains(".")) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter valid email',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (passwordController.text.length == 0 ||
        passwordConfirmController.text.length == 0) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter password',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    }
     else if (passwordController.text != passwordConfirmController.text) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please retype to confirm password',
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

  void createOTP({OTPModel dataModel, BuildContext context}) async {
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
          url: OTP_URL, body: jsonBody, auth: 'Bearer $ACCESS_TOKEN');

      print('Response: ${response.body}');

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
        } else {
          print('Body: ${response.body}');
          OTPModel otpModel = new OTPModel(
            name: data['data']['name'],
            email: data['data']['email'],
            pin: data['data']['pin'],
            phone: data['data']['phone'],
            password: data['data']['password'],
            // password: passwordController.text,
          );
          print('otp: $otpModel');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                  otpModel: otpModel,
                  track: 'Registration',
                  ),
            ),
          );
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
}
