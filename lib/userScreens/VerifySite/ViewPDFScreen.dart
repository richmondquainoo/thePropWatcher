import 'dart:async';
import 'dart:io';

import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/userScreens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class ViewPDFScreen extends StatefulWidget {
  final String url;

  ViewPDFScreen({this.url});

  @override
  _ViewPDFScreenState createState() => _ViewPDFScreenState(url: url);
}

class _ViewPDFScreenState extends State<ViewPDFScreen> {
  final String url;

  _ViewPDFScreenState({this.url});

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  bool isReady = false;
  String errorMessage = '';
  String urlPDFPath = '';
  bool loaded = false;
  bool exists = true;
  PDFViewController _pdfViewController;

  Future<File> getFileFromUrl() async {
    var fileName = url.substring(url.lastIndexOf('/'), url.lastIndexOf(('.')));
    print('fileName: $fileName');

    try {
      var data = await NetworkUtility().getData(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  void initState() {
    // requestPersmission();
    getFileFromUrl().then(
      (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  // void requestPermission() async {
  //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        elevation: 0,
        title: Text(
          "View Site Document",
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
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PDFView(
              filePath: urlPDFPath,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: true,
              nightMode: false,
              onError: (e) {
                //Show some error message or UI
              },
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages;
                  pdfReady = true;
                });
              },
              onViewCreated: (PDFViewController vc) {
                setState(() {
                  _pdfViewController = vc;
                });
              },
              onPageChanged: (int page, int total) {
                setState(() {
                  _currentPage = page;
                });
              },
              onPageError: (page, e) {},
            ),
            errorMessage.isEmpty
                ? !isReady
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
                : Center(
                    child: Text(errorMessage),
                  )
          ],
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            // Text(
            //   "Press the button below to return to home",
            //   style: GoogleFonts.lato(
            //     fontSize: 12,
            //     color: Colors.black54,
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrangeAccent,
                      ),
                      child: Center(
                        child: Text(
                          'Return To Home',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                // Expanded(
                //   child: GestureDetector(
                //     onTap: () {
                //       paymentStatusCheck(
                //           context: context, invoiceModel: invoiceModel);
                //     },
                //     child: Container(
                //       padding: EdgeInsets.all(10),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.teal,
                //       ),
                //       child: Center(
                //         child: Text(
                //           'Continue',
                //           style: GoogleFonts.lato(
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Future<void> verificationRequest(BuildContext context) async {
  //   try {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return ProgressDialog(displayMessage: 'Please wait...');
  //       },
  //     );
  //     UserProfileModel user =
  //         Provider.of<AppData>(context, listen: false).userData;
  //     VerifySiteRequestModel requestModel = VerifySiteRequestModel(
  //         applicant_name: user.name, ref_number: '12345678');
  //     List<CoordinateModel> wkt = [];
  //     if (positions.isNotEmpty) {
  //       for (Position pos in positions) {
  //         wkt.add(new CoordinateModel(
  //             latitude: pos.latitude,
  //             longitude: pos.longitude,
  //             accuracy: pos.accuracy));
  //       }
  //     }
  //     requestModel.wkt = wkt;
  //     var jsonBody = jsonEncode(requestModel);
  //     NetworkUtility networkUtility = NetworkUtility();
  //     Response response = await networkUtility.postData(
  //       url: VERIFY_SITE_LOCATION_PDF_URL,
  //       body: jsonBody,
  //     );
  //
  //     print('verify site pdf: ${response.body}');
  //     // List<String> fileContents = [response.body];
  //     // Blob blob = new Blob(fileContents, 'text/plain', 'native');
  //     // FileSystem _filesystem =
  //     //     await window.requestFileSystem(1024 * 1024, persistent: false);
  //     // FileEntry fileEntry = await _filesystem.root.createFile('dart_test.csv');
  //     // FileWriter fw = await fileEntry.createWriter();
  //     // fw.write(blob);
  //     // File file = await fileEntry.file();
  //     // print("File info: ${file.name} - ${file.relativePath}");
  //     Navigator.of(context, rootNavigator: true).pop();
  //
  //     print('RequestModel: ${requestModel.toJson()}');
  //   } catch (e) {
  //     print('verificationRequest error: $e');
  //   }
  // }
}
