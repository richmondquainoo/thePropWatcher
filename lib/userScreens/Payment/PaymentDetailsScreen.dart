import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/CoordinateModel.dart';
import 'package:elandguard/model/InvoiceModel.dart';
import 'package:elandguard/model/VerifyRateableRequestModel.dart';
import 'package:elandguard/model/VerifyRateableResponseModel.dart';
import 'package:elandguard/model/VerifySiteRequestModel.dart';
import 'package:elandguard/userScreens/SitePlanLocation/SitePlanPolygon.dart';
import 'package:elandguard/userScreens/TitleCertificate/TitleCertificateDetails.dart';
import 'package:elandguard/userScreens/TitleCertificate/TitleCertificateRequestModel.dart';
import 'package:elandguard/userScreens/TitleCertificate/TitleCertificateResponseModel.dart';
import 'package:elandguard/userScreens/VerifyRateableValue/VerifyRateableValueDetails.dart';
import 'package:elandguard/userScreens/VerifySite/ViewPDFTest.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final InvoiceModel model;

  PaymentDetailsScreen({this.model});

  @override
  _PaymentDetailsScreenState createState() =>
      _PaymentDetailsScreenState(model: model);
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final InvoiceModel model;

  _PaymentDetailsScreenState({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        centerTitle: true,
        title: Text(
          "Payment Details",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 23,
            // color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "View payment details below",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16.5),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 0.3,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Narration',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Details',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Payment Date',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null &&
                                    model.paymentDate != null &&
                                    model.paymentDate.length > 0)
                                ? model.paymentDate
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Invoice #',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null &&
                                    model.invoiceNo != null &&
                                    model.invoiceNo.length > 0)
                                ? model.invoiceNo
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Reference #',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null &&
                                    model.clientReference != null &&
                                    model.clientReference.length > 0)
                                ? model.clientReference
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Service Code',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null &&
                                    model.serviceCode != null &&
                                    model.serviceCode.length > 0)
                                ? model.serviceCode
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Service Name',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null &&
                                    model.serviceName != null &&
                                    model.serviceName.length > 0)
                                ? model.serviceName
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Payment Status',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (model != null &&
                                      model.status != null &&
                                      model.status.length > 0)
                                  ? model.status
                                  : '-',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w300,
                                color: (model != null &&
                                        model.status != null &&
                                        model.status.length > 0 &&
                                        model.status == 'Paid')
                                    ? Colors.teal
                                    : Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Amount',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null && model.paymentAmount != null)
                                ? model.paymentAmount.toStringAsFixed(2)
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Payment Mode',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null &&
                                    model.paymentMode != null &&
                                    model.paymentMode.length > 0)
                                ? model.paymentMode
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Payment By',
                              style: GoogleFonts.lato(),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            (model != null &&
                                    model.name != null &&
                                    model.name.length > 0)
                                ? model.name
                                : '-',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 0.3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getResults(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: kPrimaryTheme,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'View Service Results',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getResults(BuildContext context) {
    try {
      if (model != null && model.status != null && model.status != 'Paid') {
        new UtilityService().showMessage(
          context: context,
          message: 'No service details found.',
          icon: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
        );
      }
      //Get VRV details
      else if (model != null &&
          model.serviceCode == 'VRV' &&
          model.requestObject != null) {
        var obj = jsonDecode(model.requestObject);
        VerifyRateableRequestModel request = VerifyRateableRequestModel();
        request.valuation_number = obj['valuation_number'];
        request.gdCode = obj['gdCode'];
        print('Re: $request');
        getRateableValue(
          context,
          request,
        );
      }

      //Get site plot boundaries pdf
      else if (model != null &&
          model.serviceCode == 'VSL' &&
          model.requestObject != null) {
        var obj = jsonDecode(model.requestObject);
        print(obj);
        String applicant = obj['applicant_name'];
        print(applicant);
        var wkt = obj['wkt'] as List;
        List<CoordinateModel> coordinates = [];
        if (wkt.isNotEmpty) {
          for (int i = 0; i < wkt.length; i++) {
            coordinates.add(
              new CoordinateModel(
                latitude: wkt[i]['latitude'],
                longitude: wkt[i]['longitude'],
                accuracy: wkt[i]['accuracy'],
              ),
            );
          }
        }
        VerifySiteRequestModel request = VerifySiteRequestModel();
        request.applicant_name = applicant;
        request.ref_number = model.clientReference;
        request.wkt = coordinates;

        print('Re: $request');
        plotSiteBoundary(context: context, request: request);
      }

      //Get title certificate
      else if (model != null &&
          model.serviceCode == 'VTC' &&
          model.requestObject != null) {
        var obj = jsonDecode(model.requestObject);
        TitleCertificateRequestModel request = TitleCertificateRequestModel();
        request.certificate_number = obj['certificate_number'];

        print('Re: $request');
        getTitleCertificate(
          context: context,
          request: request,
        );
      }
      //Get site plan polygon
      else if (model != null &&
          model.serviceCode == 'VP' &&
          model.requestObject != null) {
        var obj = jsonDecode(model.requestObject);
        goToSitePlanPolygon(
          context: context,
          request: obj.toString(),
        );
      } else {
        new UtilityService().showMessage(
          context: context,
          message: 'No service details found.',
          icon: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('GetResults error: $e');
      new UtilityService().showMessage(
        context: context,
        message: 'An error has occurred. Please try again.',
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
    }
  }

  //Get Rateable value results
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyRateableValueDetails(
                model: null,
              ),
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

          //update central db with responseObject
          // String responseObject = jsonEncode(model);
          // InvoiceModel mod = InvoiceModel();
          // mod.responseObject = responseObject;
          // mod.clientReference = invoiceModel.clientReference;
          // await addResponseObject(context, mod);

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

  //Plot site boundaries pdf
  Future<void> plotSiteBoundary(
      {BuildContext context, VerifySiteRequestModel request}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );

      var jsonBody = jsonEncode(request);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postDataWithAuth(
          url: VERIFY_SITE_LOCATION_PDF_URL,
          body: jsonBody,
          auth: 'Bearer $ACCESS_TOKEN');

      print('verify site pdf: ${response.body}');
      Navigator.of(context, rootNavigator: true).pop();
      if (response.body != null) {
        var data = response.body;
        var obj = jsonDecode(data);
        if (obj['status'] != 200) {
          new UtilityService().showMessage(
            context: context,
            message: 'No data found.',
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          );
        } else {
          String path = await createFileOfPdfUrl(path: obj['data']);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFScreen(
                path: path,
              ),
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ViewPDFScreen(
          //       url: obj['data'],
          //     ),
          //   ),
          // );
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

      print('RequestModel: ${request.toJson()}');
    } catch (e) {
      print('plotSiteBoundary error: $e');
    }
  }

  Future<String> createFileOfPdfUrl({String path}) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    String pdfFilePath;
    try {
      final url = path;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      // print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");
      pdfFilePath = "${dir.path}/$filename";
      print("pdfFilePath: $pdfFilePath");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return pdfFilePath;
  }

  //Get Title Certificate results
  Future<void> getTitleCertificate(
      {BuildContext context, TitleCertificateRequestModel request}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );

      var jsonBody = jsonEncode(request);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postData(
        url: TITLE_CERTIFICATE_URL,
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TitleCertificateDetails(
                model: null,
              ),
            ),
          );
        } else {
          TitleCertificateResponseModel model = TitleCertificateResponseModel();
          model.gid = obj['transaction_info']['gid'].toString();
          model.nature_of_instument =
              obj['transaction_info']['nature_of_instument'].toString();
          model.date_of_registration =
              obj['transaction_info']['date_of_registration'].toString();
          model.volume = obj['transaction_info']['volume'].toString();
          model.date_of_issued_cert_no =
              obj['transaction_info']['date_of_issued_cert_no'].toString();
          model.type_of_certificate =
              obj['transaction_info']['type_of_certificate'].toString();
          model.registered_number =
              obj['transaction_info']['registered_number'].toString();
          model.cc_number = obj['transaction_info']['cc_number'].toString();
          model.certicate_number =
              obj['transaction_info']['certicate_number'].toString();
          model.applicant_name =
              obj['transaction_info']['applicant_name'].toString();
          model.grantor_name =
              obj['transaction_info']['grantor_name'].toString();
          model.job_number = obj['transaction_info']['job_number'].toString();
          model.type_instrument =
              obj['transaction_info']['type_instrument'].toString();
          model.date_of_instument =
              obj['transaction_info']['date_of_instument'].toString();
          model.consideration =
              obj['transaction_info']['consideration'].toString();
          model.purpose = obj['transaction_info']['purpose'].toString();
          model.date_commencement =
              obj['transaction_info']['date_commencement'].toString();
          model.term = obj['transaction_info']['term'].toString();
          model.remarks = obj['transaction_info']['remarks'].toString();
          model.plotted_by_reg =
              obj['transaction_info']['plotted_by_reg'].toString();
          model.checked_by = obj['transaction_info']['checked_by'].toString();
          model.plott_date_reg =
              obj['transaction_info']['plott_date_reg'].toString();
          model.type_of_registration =
              obj['transaction_info']['type_of_registration'].toString();
          model.fid_id_fk = obj['transaction_info']['fid_id_fk'].toString();
          model.plan_number = obj['transaction_info']['plan_number'].toString();
          model.encumbrance = obj['transaction_info']['encumbrance'].toString();
          model.status = obj['transaction_info']['status'].toString();
          model.reference_number =
              obj['transaction_info']['reference_number'].toString();
          model.land_size = obj['transaction_info']['land_size'].toString();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TitleCertificateDetails(
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

  //Get site plan polygon
  Future<void> goToSitePlanPolygon(
      {BuildContext context, String request}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );
      if (request.startsWith("\"")) {
        request = request.substring(1, (request.length - 1));
      }
      // var jsonBody = jsonEncode(request);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postData(
        url: SITE_POLYGON_URL,
        body: request,
      );

      Navigator.of(context, rootNavigator: true).pop();
      if (response.body != null) {
        var data = response.body;
        print('Polygon: $data');
        processPolygon(data);
      }
    } catch (e) {
      print('goToSitePlanPolygon error: $e');
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

  //Get site plan polygon
  void processPolygon(String polygon) {
    String coordinateString;
    List<Position> positions = [];
    if (polygon != null) {
      if (polygon.startsWith('MULTI')) {
        String str1 = polygon.substring(14);
        int end = str1.length - 3;
        coordinateString = str1.substring(1, end);
      }
      if (polygon.startsWith('POLY')) {
        String str1 = polygon.substring(8);
        int end = str1.length - 2;
        coordinateString = str1.substring(1, end);
      }

      if (coordinateString != null) {
        List<String> list1 = coordinateString.split(',');
        if (list1.isNotEmpty) {
          for (String pos in list1) {
            double lon = double.parse(pos.split(' ')[0]);
            double lat = double.parse(pos.split(' ')[1]);
            Position position = Position(longitude: lon, latitude: lat);
            positions.add(position);
          }
        }
      }
      if (positions.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SitePlanPolygon(positions: positions),
          ),
        );
      }
    }
  }
}
