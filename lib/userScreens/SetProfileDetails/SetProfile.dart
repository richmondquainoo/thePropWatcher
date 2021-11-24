import 'dart:convert';

import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/databaseTools/UserDB.dart';
import 'package:elandguard/databaseTools/UserDBImp.dart';
import 'package:elandguard/model/OtpModel.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/userScreens/Settings/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
  var phoneController = TextEditingController();
  var setPasswordController = TextEditingController();
  var emailController = TextEditingController();

  String profileName;
  String phone;
  String setPassword;
  String email;


  File imageFile;
  final picker = ImagePicker();

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
    setProfilePicture();
  }

  void setProfilePicture() async {
    try {
      if (user.picture != null) {
        base64Encoded = user.picture;
        final decodedBytes = base64Decode(base64Encoded);
        final directory = await getApplicationDocumentsDirectory();
        var file = File("${directory.path}/profile.png");
        file.writeAsBytesSync(decodedBytes);
        imageFile = file;
      }
    } catch (e) {
      print('setProfilePicture err: $e');
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundTheme,
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Set Profile",
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
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: imageFile == null
                                      ? AssetImage('assets/images/no_user.jpg')
                                      : FileImage(imageFile),
                                  // backgroundImage: imageFile!=null
                                  //     ?
                                  //   Image.file(imageFile)
                                  //   // height: 300.0,
                                  //   // fit: BoxFit.scaleDown,
                                  //     : AssetImage('assets/images/no_user.jpg'),
                                ),
                                Positioned(
                                  right: -16,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 46,
                                    width: 46,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(color: Colors.black12),
                                      ),
                                      color: Colors.grey[200],
                                      onPressed: () async {
                                        final pickedFile =
                                        await picker.getImage(source: ImageSource.gallery);
                                        print('picker: ${pickedFile}');
                                        if (pickedFile != null) {
                                          File croppedFile = await ImageCropper.cropImage(
                                            sourcePath: pickedFile.path,
                                            aspectRatioPresets: [
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio16x9
                                            ],
                                            androidUiSettings: AndroidUiSettings(
                                              toolbarTitle: 'Cropper',
                                              toolbarColor: Colors.green[700],
                                              toolbarWidgetColor: Colors.white,
                                              activeControlsWidgetColor: Colors.green[700],
                                              initAspectRatio: CropAspectRatioPreset.original,
                                              lockAspectRatio: false,
                                            ),
                                            iosUiSettings: IOSUiSettings(
                                              minimumAspectRatio: 1.0,
                                            ),
                                          );
                                          if (croppedFile != null){
                                            setState(() {
                                              imageFile = croppedFile;

                                            });
                                            print('imageFile: $imageFile');
                                          }
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/Camera Icon.svg",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                          controller: profileNameController,
                          onChanged: (value) {
                            profileName = value;
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
                            prefixIcon: Icon(Icons.person, color: Colors.black54,),
                            hintText: 'Profile Name',
                            hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
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
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          controller: setPasswordController,
                          onChanged: (value) {
                            setPassword = value;
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
                            hintText: 'Set Password',
                            hintStyle: TextStyle(fontSize: 17, color: Colors.black54),
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
                      height: 30,
                    ),
                    TextButtonComponent(
                      labelColor: kPrimaryTheme,
                      textColor: Colors.white,
                      label: "Done",
                      onTap: () async{
                        bool canProceed = isValidEntries(context);
                        if (canProceed) {
                          //Save user data to local storage
                          await saveToLocalDB(context);
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

  Future<void> saveToLocalDB(BuildContext context) async {
    //Save user data to local storage
    UserProfileModel model = UserProfileModel(
      phone: phone,
      profileName: profileName,
      password: setPassword,
      // picture:

      //add profile name and pic
    );
    await dbImplementation.saveUser(model);
    new UtilityService().confirmationBox(
        title: 'Confirmation',
        message: 'Are you sure you want to always login with this pin?',
        context: context,
        color: Colors.blueAccent,
        onYes: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHomePage()));
        },
        onNo: () {
          Navigator.pop(context);
        });
  }

  bool isValidEntries(BuildContext context) {
    if ((profileNameController.text.length ==0)) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter username',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    }else if (setPasswordController.text.length == 0) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please set your password',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    }else if (setPasswordController.text.length < 4) {
      new UtilityService().showMessage(
        context: context,
        message: 'Password must be 4+ character long',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    }else if (phoneController.text.length < 10) {
      new UtilityService().showMessage(
        context: context,
        message: 'Please enter your phone number',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return false;
    }
    else {
      return true;
    }
  }


  Object displayProfilePicture() {
    return imageFile != null
        ? FileImage(imageFile)
        : AssetImage('assets/images/no_user.jpg');
  }

}
