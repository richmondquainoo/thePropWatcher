import 'package:elandguard/Constants/myColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../myHomePage.dart';
import 'TitleCertificateResponseModel.dart';

class TitleCertificateDetails extends StatefulWidget {
  final TitleCertificateResponseModel model;

  TitleCertificateDetails({this.model});

  @override
  _TitleCertificateDetailsState createState() =>
      _TitleCertificateDetailsState(model: model);
}

class _TitleCertificateDetailsState extends State<TitleCertificateDetails> {
  final TitleCertificateResponseModel model;

  _TitleCertificateDetailsState({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Details - Title Certificate Search",
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
        child: Column(
          children: <Widget>[
            Divider(),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'GID',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.gid != null)
                                  ? model.gid
                                  : '-',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Reference No.',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.reference_number != null)
                                  ? model.reference_number
                                  : '-',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Certificate No.',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.certicate_number != null)
                                  ? model.certicate_number
                                  : '-',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Date Issued',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.date_of_issued_cert_no != null)
                                  ? model.date_of_issued_cert_no
                                  : '-',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Instrument Date',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.date_of_instument != null)
                                  ? model.date_of_instument
                                  : '-',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Registration Date',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.date_of_registration != null)
                                  ? model.date_of_registration
                                  : '-',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(),
                  Text('More Info '),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
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
                          'Certificate Type',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        (model != null && model.type_of_certificate != null)
                            ? model.type_of_certificate
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
                          'Applicant',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null && model.applicant_name != null)
                              ? model.applicant_name
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
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
                          'Instrument Type',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null && model.type_instrument != null)
                              ? model.type_instrument
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
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
                          'Commencement Date',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null && model.date_commencement != null)
                              ? model.date_commencement
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
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
                          'Term',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null && model.term != null)
                              ? model.term
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
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
                          'Registration Type',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null && model.type_of_registration != null)
                              ? model.type_of_registration
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
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
                          'Encumbrance',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null &&
                                  model.encumbrance != null &&
                                  model.encumbrance != 'null')
                              ? model.encumbrance
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
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
                          'Land size',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null && model.land_size != null)
                              ? model.land_size
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
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
                          'Plan Number',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null &&
                                  model.plan_number != null &&
                                  model.plan_number != 'null')
                              ? model.plan_number
                              : '-',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Align(
                                alignment: Alignment.center,
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
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Expanded(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //     builder: (context) => VerifyRateableValueMap(
                      //       //       model: model,
                      //       //     ),
                      //       //   ),
                      //       // );
                      //       new UtilityService().showMessage(
                      //         context: context,
                      //         message:
                      //             'Sorry, map is not available at the moment.',
                      //         icon: Icon(
                      //           Icons.error_outline,
                      //           color: Colors.red,
                      //         ),
                      //       );
                      //     },
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.redAccent,
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(12.0),
                      //         child: Align(
                      //           alignment: Alignment.center,
                      //           child: Text(
                      //             'View On Map',
                      //             style: GoogleFonts.lato(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
