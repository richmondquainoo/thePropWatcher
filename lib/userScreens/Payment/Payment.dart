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
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatefulWidget {
  final InvoiceModel invoiceModel;
  final String requestObject;
  Payment({this.invoiceModel, this.requestObject});

  @override
  _PaymentState createState() =>
      _PaymentState(invoiceModel: invoiceModel, requestObject: requestObject);
}

class _PaymentState extends State<Payment> {
  final InvoiceModel invoiceModel;
  final String requestObject;
  _PaymentState({this.invoiceModel, this.requestObject});

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(
            fontSize: 20,
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
            // color: Colors.white,
          ),
        ),
        actions: <Widget>[
          NavigationControls(_controller.future),
        ],
      ),
      body: WebView(
        initialUrl: (invoiceModel != null && invoiceModel.checkoutUrl != null)
            ? invoiceModel.checkoutUrl
            : '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      persistentFooterButtons: [
        Column(
          children: [
            Text(
              "Please wait for the payment process to be completed before pressing the buttons below.",
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      paymentStatusCheck(
                          context: context, invoiceModel: invoiceModel);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange,
                      ),
                      child: Center(
                        child: Text(
                          'Check Status',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      paymentStatusCheck(
                          context: context, invoiceModel: invoiceModel);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> paymentStatusCheck(
      {BuildContext context, InvoiceModel invoiceModel}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Checking status...');
        },
      );

      var jsonBody = jsonEncode(invoiceModel);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postDataWithAuth(
          url: INVOICE_STATUS_CHECK_URL,
          body: jsonBody,
          auth: 'Bearer $ACCESS_TOKEN');

      print('Check invoice response: ${response.body}');

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
          if (data['message'] != null && data['message'] == 'Paid') {
            print(data);
            new UtilityService().showMessage(
              message: 'Payment status is: ${data['message']}',
              icon: Icon(
                Icons.check,
                color: Colors.teal,
              ),
              context: context,
            );
            if (invoiceModel.serviceCode == 'VP') {
              String req = data['data']['requestObject'].toString();
              print('Request: $req');
              goToSitePlanPolygon(
                context: context,
                request: req,
              );
            }
            if (invoiceModel.serviceCode == 'VTC') {
              String req = data['data']['requestObject'].toString();
              var obj = jsonDecode(req);
              TitleCertificateRequestModel request =
                  TitleCertificateRequestModel();
              request.certificate_number = obj['certificate_number'];
              print('Re: $request');
              getTitleCertificate(
                context: context,
                request: request,
              );
            }
            if (invoiceModel.serviceCode == 'VRV') {
              String req = data['data']['requestObject'].toString();
              var obj = jsonDecode(req);
              VerifyRateableRequestModel request = VerifyRateableRequestModel();
              request.valuation_number = obj['valuation_number'];
              request.gdCode = obj['gdCode'];
              print('Re: $request');
              getRateableValue(
                context: context,
                request: request,
              );
            }
            if (invoiceModel.serviceCode == 'VSL') {
              String req = data['data']['requestObject'].toString();
              var obj = jsonDecode(req);
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
              request.ref_number = invoiceModel.clientReference;
              request.wkt = coordinates;

              print('Re: $request');
              plotSiteBoundary(context: context, request: request);
            }
          } else {
            new UtilityService().showMessage(
              message: data['data'],
              icon: Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              context: context,
            );
          }
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
    }
  }

  //Get Rateable value results
  Future<void> getRateableValue(
      {BuildContext context, VerifyRateableRequestModel request}) async {
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

          Navigator.pushReplacement(
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

  //Get site boundary pdf
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
      // new UtilityService().showMessage(
      //   context: context,
      //   message: 'An error occurred, please try again.',
      //   icon: Icon(
      //     Icons.error_outline,
      //     color: Colors.red,
      //   ),
      // );
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

  //Update payment info with responseObject
  Future<void> addResponseObject(
      BuildContext context, InvoiceModel invoiceModel) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );

      var jsonBody = jsonEncode(invoiceModel);
      NetworkUtility networkUtility = NetworkUtility();
      await networkUtility.postDataWithAuth(
          url: ADD_RESPONSE_OBJECT_URL,
          body: jsonBody,
          auth: 'Bearer $ACCESS_TOKEN');

      Navigator.of(context, rootNavigator: true).pop();
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

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("No back history item")),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("No forward history item")),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
