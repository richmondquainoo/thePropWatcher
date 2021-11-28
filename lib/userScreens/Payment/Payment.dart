import 'dart:async';
import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Component/TextButtonComponent.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/InvoiceModel.dart';
import 'package:elandguard/userScreens/scanQRCode.dart';
import 'package:elandguard/userScreens/verifyRateableValue.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../verifyCertificate.dart';

class Payment extends StatefulWidget {
  final InvoiceModel invoiceModel;
  Payment({this.invoiceModel});

  @override
  _PaymentState createState() => _PaymentState(invoiceModel: invoiceModel);
}

class _PaymentState extends State<Payment> {
  final InvoiceModel invoiceModel;

  _PaymentState({this.invoiceModel});

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: TextButtonComponent(
          onTap: () {
            paymentStatusCheck(context: context, invoiceModel: invoiceModel);
          },
          label: "Check Payment Status",
          labelColor: kPrimaryTheme,
          textColor: Colors.white,
          fontSize: 17.3,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          if (data['data'] != null && data['data'] == 'Paid') {
            new UtilityService().showMessage(
              message: 'Payment status is: ${data['data']}',
              icon: Icon(
                Icons.check,
                color: Colors.teal,
              ),
              context: context,
            );
            if (invoiceModel.serviceCode == 'VP') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanScreen(),
                ),
              );
            }
            if (invoiceModel.serviceCode == 'VTC') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyCertificate(),
                ),
              );
            }
            if (invoiceModel.serviceCode == 'VRV') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyRateableValue(),
                ),
              );
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
      Navigator.of(context, rootNavigator: true).pop();
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
