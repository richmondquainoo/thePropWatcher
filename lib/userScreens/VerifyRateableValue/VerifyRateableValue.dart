import 'dart:convert';

import 'package:elandguard/Component/FormDropDown.dart';
import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/ServiceCharge.dart';
import 'package:elandguard/model/VerifyRateableRequestModel.dart';
import 'package:elandguard/model/VerifyRateableResponseModel.dart';
import 'package:elandguard/userScreens/Invoice/InvoiceScreen.dart';
import 'package:elandguard/userScreens/VerifyRateableValue/VerifyRateableValueDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class VerifyRateableValue extends StatefulWidget {
  @override
  _VerifyRateableValueState createState() => _VerifyRateableValueState();
}

class _VerifyRateableValueState extends State<VerifyRateableValue> {
  var number = new TextEditingController();
  String param;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Verify Rateable Value",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kPrimaryTheme),
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
      body: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Divider(),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Please select your search parameter',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                    child: AppDropdownInput(
                      hintText: '',
                      options: ['Valuation Number', 'GPS Address'],
                      value: param,
                      onChanged: (String value) {
                        setState(() {
                          param = value;
                        });
                      },
                      getLabel: (String value) => value,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (param == 'Valuation Number')
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Please enter valuation number. You can also scan the valuation number using the Scan QR Code button below.',
                                style: GoogleFonts.lato(),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    height: 55,
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
                                        controller: number,
                                        onChanged: (value) {
                                          // password = value;
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black87,
                                              width: 0.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                          hintText: 'Enter Valuation Number',
                                          hintStyle: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      String barcodeScanRes;
                                      try {
                                        barcodeScanRes =
                                            await FlutterBarcodeScanner
                                                .scanBarcode(
                                                    '#ff6666',
                                                    'Cancel',
                                                    true,
                                                    ScanMode.QR);
                                        print(barcodeScanRes);
                                        setState(() {
                                          number.text = barcodeScanRes;
                                          // controller.text.toUpperCase();
                                        });
                                      } on PlatformException {
                                        barcodeScanRes =
                                            'Failed to get platform version.';
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.qr_code,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Scan QR Code',
                                          style: GoogleFonts.lato(
                                            fontSize: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  (param == 'GD Code')
                      ? Container(
                          height: 55,
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
                              controller: number,
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
                                hintText: 'Enter GD Code',
                                hintStyle: TextStyle(
                                    fontSize: 17, color: Colors.black54),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButtonComponent(
                      labelColor: kPrimaryTheme,
                      label: "Proceed",
                      textColor: Colors.white,
                      onTap: () {
                        if (param == null || param.length == 0) {
                          new UtilityService().showMessage(
                            context: context,
                            message: 'Please select your search parameter',
                            icon: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                          );
                        } else if (param == 'Valuation Number' &&
                            number.text.length == 0) {
                          new UtilityService().showMessage(
                            context: context,
                            message: 'Please enter valuation number',
                            icon: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                          );
                        } else if (param == 'GD Code' &&
                            number.text.length == 0) {
                          new UtilityService().showMessage(
                            context: context,
                            message: 'Please enter GD Code',
                            icon: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                          );
                        } else {
                          VerifyRateableRequestModel req =
                              VerifyRateableRequestModel(
                            valuation_number: (param == 'Valuation Number')
                                ? number.text
                                : '',
                            gdCode: (param == 'GPS Address') ? number.text : '',
                          );
                          // getRateableValue(context, req);
                          getServiceCharge(
                            serviceCode: 'VRV',
                            context: context,
                            requestObject: jsonEncode(req),
                          );
                        }
                      },
                    ),
                  ),
                ],
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

  Future<void> getRateableValue(
      BuildContext context, VerifyRateableRequestModel req) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );

      var jsonBody = jsonEncode(req);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postData(
        url: VERIFY_RATEABLE_VALUE_URL,
        body: jsonBody,
      );

      Navigator.of(context, rootNavigator: true).pop();
      if (response.body != null) {
        var data = response.body;
        var obj = jsonDecode(data);
        if (!obj['success']) {
          new UtilityService().showMessage(
            context: context,
            message: 'No data found.',
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          );
        } else {
          VerifyRateableResponseModel model = VerifyRateableResponseModel();
          model.parcel_uid = obj['data']['parcel_uid'].toString();
          model.gid = obj['data']['gid'];
          model.assembly_code_sp = obj['data']['assembly_code_sp'];
          model.valuation_number_sp = obj['data']['valuation_number_sp'];
          model.upn = obj['data']['upn'];
          model.b_centriod = obj['data']['b_centriod'];
          model.polygon = obj['data']['polygon'];
          model.polygon_area = obj['data']['polygon_area'].toString();
          model.vp_id = obj['data']['vp_id'].toString();
          model.parcel_id = obj['data']['parcel_id'];
          model.valuation_number = obj['data']['valuation_number'];
          model.purpose_of_valuation = obj['data']['purpose_of_valuation'];
          model.valuation_date = obj['data']['valuation_date'];
          model.valuation_zone = obj['data']['valuation_zone'];
          model.property_use_code = obj['data']['property_use_code'];
          model.house_number = obj['data']['house_number'];
          model.street_name = obj['data']['street_name'];
          model.suburb = obj['data']['suburb'];
          model.owner_name = obj['data']['owner_name'];
          model.owner_address = obj['data']['owner_address'];
          model.owner_email = obj['data']['owner_email'];
          model.owner_phone_number = obj['data']['owner_phone_number'];
          model.occupier = obj['data']['occupier'];
          model.property_user = obj['data']['property_user'];
          model.date_of_inspection = obj['data']['date_of_inspection'];
          model.total_cost = obj['data']['total_cost'].toString();
          model.replacement_cost = obj['data']['replacement_cost'].toString();
          model.depreciation_rate = obj['data']['depreciation_rate'].toString();
          model.depreciated_value = obj['data']['depreciated_value'].toString();
          model.rateable_value = obj['data']['rateable_value'].toString();
          model.overall_total_cost =
              obj['data']['overall_total_cost'].toString();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyRateableValueDetails(
                model: model,
              ),
            ),
          );
        }
      } else {
        new UtilityService().showMessage(
          context: context,
          message: 'An error occurred, please try again.',
          icon: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('getRateableValue error: $e');
      // Navigator.of(context, rootNavigator: true).pop();
      new UtilityService().showMessage(
        context: context,
        message: 'An error occurred, please try again.',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
    }
  }
}
