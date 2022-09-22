import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/ServiceCharge.dart';
import 'package:elandguard/userScreens/Invoice/InvoiceScreen.dart';
import 'package:elandguard/userScreens/TitleCertificate/TitleCertificateRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class TitleCertificateScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<TitleCertificateScreen> {
  String qrCodeResult = "";
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        elevation: 0,
        title: Text(
          "Title Certificate",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 23,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Column(
            children: [
              Text(
                'Please enter Title Certificate Number below',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ), // set rounded corner radius
                      ),
                      child: Center(
                        child: TextField(
                          obscureText: false,
                          style: TextStyle(color: Colors.black54),
                          controller: controller,
                          onChanged: (value) {
                            // password = value;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black87,
                                width: 0.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: const BorderSide(
                                color: kPrimaryTheme,
                                width: 0.7,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.edit_outlined,
                              color: Colors.black54,
                            ),
                            hintText: 'Certificate Number',
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (controller.text.length == 0) {
                    new UtilityService().showMessage(
                      message: 'Please enter title certificate number.',
                      icon: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                      context: context,
                    );
                  } else {
                    TitleCertificateRequestModel req =
                        TitleCertificateRequestModel(
                      certificate_number: controller.text.toUpperCase(),
                    );
                    print(req);
                    getServiceCharge(
                      serviceCode: 'VTC',
                      context: context,
                      requestObject: jsonEncode(req),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryTheme,
                  ),
                  child: Center(
                    child: Text(
                      'Proceed',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                      ),
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

  void getServiceCharge(
      {String serviceCode, BuildContext context, var requestObject}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );
      String url = '$SERVICE_CHARGE_URL/$serviceCode';
      // print('URL: $url');
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.getDataWithAuth(
          url: url, auth: 'Bearer $ACCESS_TOKEN');

      // print('service charge response: ${response.body}');

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
        // print('Status: $status');
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
          ServiceChargeModel model = ServiceChargeModel(
            serviceCode: data['data']['serviceCode'],
            serviceName: data['data']['serviceName'],
            amount: data['data']['amount'],
            tax: data['data']['tax'],
            levy: data['data']['levy'],
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvoiceScreen(
                serviceChargeModel: model,
                requestObject: requestObject,
              ),
            ),
          );
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
      print('get bill error: $e');
    }
  }
}
