import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/AppData.dart';
import 'package:elandguard/model/InvoiceModel.dart';
import 'package:elandguard/model/ServiceCharge.dart';
import 'package:elandguard/model/UserProfileModel.dart';
import 'package:elandguard/userScreens/Payment/Payment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class InvoiceScreen extends StatefulWidget {
  final ServiceChargeModel serviceChargeModel;

  InvoiceScreen({this.serviceChargeModel});

  @override
  _InvoiceScreenState createState() =>
      _InvoiceScreenState(serviceChargeModel: serviceChargeModel);
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final ServiceChargeModel serviceChargeModel;

  _InvoiceScreenState({this.serviceChargeModel});

  var uuid = Uuid();
  String uuidGen;
  DateTime now = DateTime.now();
  String formattedDate;
  String formattedDate1;
  String invoiceNum;

  @override
  Widget build(BuildContext context) {
    uuidGen = uuid.v4();
    formattedDate = DateFormat('yyMMddHHmmss').format(now);
    formattedDate1 = DateFormat('yyyy-MM-dd').format(now);
    invoiceNum = uuidGen.substring(0, 4).toUpperCase() + "-" + formattedDate;
    UserProfileModel user =
        Provider.of<AppData>(context, listen: false).userData;
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
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Inv #:',
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
                                flex: 3,
                                child: Text(
                                  '$invoiceNum',
                                  style: GoogleFonts.lato(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
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
                                  formattedDate1,
                                  style: GoogleFonts.lato(
                                    fontSize: 10,
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
                                  (serviceChargeModel != null &&
                                          serviceChargeModel.serviceName !=
                                              null)
                                      ? serviceChargeModel.serviceName
                                      : '-',
                                  style: GoogleFonts.robotoMono(
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
                                  (serviceChargeModel != null &&
                                          serviceChargeModel.amount != null)
                                      ? '${serviceChargeModel.amount.toStringAsFixed(2)}'
                                      : '-',
                                  style: GoogleFonts.robotoMono(
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
                                  style: GoogleFonts.robotoMono(
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
                                  (serviceChargeModel != null &&
                                          serviceChargeModel.tax != null)
                                      ? '${serviceChargeModel.tax.toStringAsFixed(2)}'
                                      : '-',
                                  style: GoogleFonts.robotoMono(
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
                                  style: GoogleFonts.robotoMono(
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
                                  (serviceChargeModel != null &&
                                          serviceChargeModel.amount != null &&
                                          serviceChargeModel.tax != null)
                                      ? '${(serviceChargeModel.amount + serviceChargeModel.tax).toStringAsFixed(2)}'
                                      : '-',
                                  style: GoogleFonts.robotoMono(
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
                        new UtilityService().confirmationBox(
                            title: 'Continue to payment checkout',
                            message:
                                'You will be redirected to a payment checkout screen. Please ensure that payment process'
                                'is completed before leaving the screen.',
                            context: context,
                            yesColor: Colors.teal,
                            yesLabel: 'Proceed',
                            noLabel: 'Cancel',
                            noColor: Colors.deepOrange,
                            buttonHeight: 30,
                            buttonWidth: 100,
                            onYes: () {
                              Navigator.pop(context);
                              proceedToCheckout(user, context);
                            },
                            onNo: () {
                              Navigator.pop(context);
                            });
                      },
                    ),
                    SizedBox(
                      height: 20,
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
                          child: Container(),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: QrImage(
                              data: invoiceNum,
                              version: QrVersions.auto,
                              size: 60.0,
                            ),
                          ),
                        ),
                      ],
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

  void proceedToCheckout(UserProfileModel user, BuildContext context) {
    InvoiceModel model = InvoiceModel(
      name: user.name,
      phone: user.phone,
      email: user.email,
      // email: 'danmarfo8@gmail.com',
      description: 'Payment for service ${serviceChargeModel.serviceName}',
      serviceCode: serviceChargeModel.serviceCode,
      serviceName: serviceChargeModel.serviceName,
      amount: serviceChargeModel.amount,
      tax: serviceChargeModel.tax,
      totalAmount: serviceChargeModel.amount + serviceChargeModel.tax,
      invoiceNo: invoiceNum,
      origin: 'Phone_App',
    );
    proceedToPayment(context: context, invoiceModel: model);
  }

  Future<void> proceedToPayment(
      {BuildContext context, InvoiceModel invoiceModel}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );

      var jsonBody = jsonEncode(invoiceModel);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postDataWithAuth(
          url: CREATE_INVOICE_URL,
          body: jsonBody,
          auth: 'Bearer $ACCESS_TOKEN');

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
          invoiceModel.checkoutId = data['data']['checkoutId'];
          invoiceModel.checkoutUrl = data['data']['checkoutUrl'];
          invoiceModel.clientReference = data['data']['clientReference'];

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Payment(
                invoiceModel: invoiceModel,
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
      print('proceedToPayment error: $e');
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
