import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GirliesProfile extends StatefulWidget {
  @override
  _GirliesProfileState createState() => _GirliesProfileState();
}

class _GirliesProfileState extends State<GirliesProfile> {
  var profileNameController = TextEditingController();
  var nameController = TextEditingController();

  String profileName;
  String name;


  File imageFile;
  CroppedFile croppedFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Profile",
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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(height: 50),
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

                                          CroppedFile croppedFile = await ImageCropper().cropImage(
                                            sourcePath: pickedFile.path,
                                            aspectRatioPresets: [
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio16x9
                                            ],
                                            uiSettings: [
                                              AndroidUiSettings(
                                                  toolbarTitle: 'Cropper',
                                                  toolbarColor: Colors.deepOrange,
                                                  toolbarWidgetColor: Colors.white,
                                                  initAspectRatio: CropAspectRatioPreset.original,
                                                  lockAspectRatio: false),
                                              IOSUiSettings(
                                                title: 'Cropper',
                                              ),
                                              WebUiSettings(
                                                context: context,
                                              ),
                                            ],
                                          );
                                          if (croppedFile != null){
                                            setState(() {
                                              croppedFile = croppedFile;

                                            });
                                            print('imageFile: $imageFile');
                                          }
                                        }
                                        // if (pickedFile != null) {
                                        //   // File croppedFile = await ImageCropper.cropImage(
                                        //   //   sourcePath: pickedFile.path,
                                        //   //   aspectRatioPresets: [
                                        //   //     CropAspectRatioPreset.square,
                                        //   //     CropAspectRatioPreset.ratio3x2,
                                        //   //     CropAspectRatioPreset.original,
                                        //   //     CropAspectRatioPreset.ratio4x3,
                                        //   //     CropAspectRatioPreset.ratio16x9
                                        //   //   ],
                                        //   //   androidUiSettings: AndroidUiSettings(
                                        //   //     toolbarTitle: 'Cropper',
                                        //   //     toolbarColor: Colors.green[700],
                                        //   //     toolbarWidgetColor: Colors.white,
                                        //   //     activeControlsWidgetColor: Colors.green[700],
                                        //   //     initAspectRatio: CropAspectRatioPreset.original,
                                        //   //     lockAspectRatio: false,
                                        //   //   ),
                                        //   //   iosUiSettings: IOSUiSettings(
                                        //   //     minimumAspectRatio: 1.0,
                                        //   //   ),
                                        //   // );
                                        //   if (croppedFile != null){
                                        //     setState(() {
                                        //       imagePath = croppedFile.path;
                                        //     });
                                        //   }
                                        // }
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
                      height: 7,
                    ),
                    TextField(
                      controller: profileNameController,
                      onChanged: (value) {
                        profileName = value;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // labelStyle: TextStyle(
                        //   color: Colors.white,
                        // ),
                        hintText: "Your profile name",
                        labelText: "Profile name",
                        prefixIcon: Icon(
                          Icons.person,
                          color:kPrimaryTheme,
                          size: 22,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          // color: Colors.black38,
                          size: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // labelStyle: TextStyle(
                        //   color: Colors.white,
                        // ),
                        hintText: "Phone number",
                        prefixIcon: Icon(
                          Icons.phone_sharp,
                          color:kPrimaryTheme,
                          size: 22,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          // color: Colors.black38,
                          size: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        // labelStyle: TextStyle(
                        //   color: Colors.white,
                        // ),
                        hintText: "email",
                        prefixIcon: Icon(
                          Icons.email,
                          color:kPrimaryTheme,
                          size: 22,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          // color: Colors.black38,
                          size: 22,
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
                              message: 'Are you sure you want to proceed these profile details?',
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
                      labelColor:kPrimaryTheme,
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
    } else {
      return true;
    }
  }
}
