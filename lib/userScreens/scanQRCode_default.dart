import 'package:elandguard/Constants/myColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class scanQRCodedefaultScreen extends StatefulWidget {
  @override
  _scanQRCodedefaultState createState() => new _scanQRCodedefaultState();
}

class _scanQRCodedefaultState extends State<scanQRCodedefaultScreen> {
  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryTheme,
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Message displayed over here
              Text(
                "Result",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                qrCodeResult,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),

              //Button to scan QR code
              FlatButton(
                padding: EdgeInsets.all(15),
                onPressed: () async {
                  // String codeSanner = await BarcodeScanner.scan();    //barcode scanner
                  // setState(() {
                  //   qrCodeResult = codeSanner;
                  // });
                },
                child: Text(
                  "Open Scanner",
                  style: TextStyle(color: Colors.indigo[900]),
                ),
                //Button having rounded rectangle border
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.indigo[900]),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
        ));
  }
}
