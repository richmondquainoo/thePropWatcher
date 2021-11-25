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
import 'package:elandguard/userScreens/OTPScreen/OtpScreen.dart';
import 'package:elandguard/userScreens/ResetPassword/Email.dart';
import 'package:elandguard/userScreens/SignUpScreen/Signup.dart';
import 'package:elandguard/userScreens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String email;
  String password;

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: kBackgroundTheme,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22, top: 70),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/splash.png',
                  width: 240.0,
                  height: 150.0,
                ),
                // width: 600.0,
                height: 200.0,
              ),
              Container(
                height: 48,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  // set border width
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    controller: emailController,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black87, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            const BorderSide(color: kPrimaryTheme, width: 0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black54,
                      ),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
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
                    style: TextStyle(color: Colors.black54),
                    controller: passwordController,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black87, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            const BorderSide(color: kPrimaryTheme, width: 0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black54,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextButtonComponent(
                  labelColor: kPrimaryTheme,
                  label: "Login",
                  textColor: Colors.white,
                  onTap: () async {
                    // setState(() {
                    //   password = passwordController.text;
                    // });
                    bool canProceed = isValidEntries(context);
                    if (canProceed) {
                      bool foundLocally = await localAuthentication(context);
                      if (foundLocally) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      } else {
                        UserProfileModel model = UserProfileModel(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        serverAuthentication(model);
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Don't have an account?",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: Container(
                      child: Text(
                        "Register",
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.4,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmailScreen()),
                  );
                },
                child: Container(
                  child: Text(
                    "Forgot pin?",
                    style: GoogleFonts.lato(
                      color: Colors.teal,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
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

  Future<bool> localAuthentication(BuildContext context) async {
    UserDBImplementation imp = UserDBImplementation();
    UserProfileModel user =
        await imp.authenticateAgainstLocalDB(email, password);
    if ((user != null && user.email == email) &&
        (user != null && user.password == password)) {
      Provider.of<AppData>(context, listen: false).updateUserData(user);
      return true;
    } else {
      return false;
    }
  }

  bool isValidEntries(BuildContext context) {
    if (emailController.text.length == 0 ||
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
    } else if (passwordController.text.length == 0) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter password',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    } else if (passwordController.text.length < 4) {
      new UtilityService().showMessage(
        context: context,
        message: 'Invalid password',
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
    } catch (e) {
      print('saving user data to local db error: $e');
    }
  }

  void serverAuthentication(UserProfileModel userProfileModel) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Authenticating...');
        },
      );

      var jsonBody = jsonEncode(userProfileModel);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postDataWithAuth(
          url: AUTH_USER_URL, body: jsonBody, auth: 'Bearer $ACCESS_TOKEN');

      print('auth response: ${response.body}');

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
          UserProfileModel user = UserProfileModel(
            name: data['data']['name'],
            email: data['data']['email'],
            phone: data['data']['phone'],
            password: password,
          );
          saveUserDetailsLocally(user);
        } else {
          new UtilityService().showMessage(
            context: context,
            message: data['message'],
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('server auth error: $e');
    }
  }

//
//   verifyLogin() async {
//     if (emailController.text == "") {
//       showSnackBar("Email cannot be empty", scaffoldKey);
//       return;
//     }
//
//     if (passwordController.text == "") {
//       showSnackBar("Password cannot be empty", scaffoldKey);
//       return;
//     }
//
//
//  Navigator.of(context).push(
//                     new MaterialPageRoute(builder: (context) => new MyHomePage('')));
//
//  /* final jsonReq =
//           {
//             'username': email.text,
//             "password" : password.text.toLowerCase()
//           };
//
//
//
//   String jsonRequestValue= json.encode(jsonReq);
//
//
//   /* var resBody = {};
//   resBody["email"] = "employerA@gmail.com";
//   resBody["password"] = "admin123";
//   var user = {};
//   user["user"] = resBody;
//   String str = json.encode(resBody); */
//
//
//
//    displayProgressDialog(context);
//     String response = await loginClientAccount(jsonRequestValue);
//
//
//  if (response != null) {
//  var data = json.decode(response);
//   var responsestatus = data["success"];
//    var responseMsg = data["data"].toString();
//
//
//
//    if (responsestatus == true) {
//
//     if (responseMsg =="null") {
//      //showSnackBar(responseMsg, scaffoldKey);
// //var responsedata = data["data"];
//       closeProgressDialog(context);
//         _showDialog(context);
//       //Navigator.of(context).pop();
//      // Navigator.of(context).pop(true);
//     }else {
//       closeProgressDialog(context);
//        Navigator.of(context).push(
//                     new MaterialPageRoute(builder: (context) => new MyHomePage(response)));
//       // SnackBar(content: Text("hello"));
//      //Toast.show(message: "Please Check username and password",duration: Delay.SHORT,textColor: Colors.black);
//     // Toast.show("Please Check username and password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
//
//       //showSnackBar('Please Check username and password', scaffoldKey);
//     }
//
//      // _showDialog(context);
//     } else {
//       closeProgressDialog(context);
//       showSnackBar(response, scaffoldKey);
//     }
//  }else {
//       closeProgressDialog(context);
//
//       showSnackBar("Login not Successful. Please check your Internet", scaffoldKey);
//     } */
//
//   }
//
//   void _showDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: new Text("Whissla Login!"),
//         content: new Text("Please Check username and password!"),
//         actions: <Widget>[
//           new FlatButton(
//             child: new Text("OK"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
//   }
}
