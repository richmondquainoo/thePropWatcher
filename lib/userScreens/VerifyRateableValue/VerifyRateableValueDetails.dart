import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/model/VerifyRateableResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../myHomePage.dart';
import 'VerifyRateableValueMap.dart';

class VerifyRateableValueDetails extends StatefulWidget {
  final VerifyRateableResponseModel model;

  VerifyRateableValueDetails({this.model});

  @override
  _VerifyRateableValueDetailsState createState() =>
      _VerifyRateableValueDetailsState(model: model);
}

class _VerifyRateableValueDetailsState
    extends State<VerifyRateableValueDetails> {
  final VerifyRateableResponseModel model;

  _VerifyRateableValueDetailsState({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "Details - Rateable Value",
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
                              'Parcel ID',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.parcel_id != null)
                                  ? model.parcel_id
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
                              'Assembly',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.assembly_code_sp != null)
                                  ? model.assembly_code_sp
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
                              'UPN',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.upn != null)
                                  ? model.upn
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
                              'Valuation Date',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.valuation_date != null)
                                  ? model.valuation_date.substring(0, 10)
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
                              'Valuation No.',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null && model.valuation_number != null)
                                  ? model.valuation_number
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
                              'Suburb',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.suburb != null &&
                                      model.suburb.length > 0)
                                  ? model.suburb
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
                              'Street',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.street_name != null &&
                                      model.street_name.length > 0)
                                  ? model.street_name
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
                              'Hse No.',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.house_number != null &&
                                      model.house_number.length > 0)
                                  ? model.house_number
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
                              'Owner',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.owner_name != null &&
                                      model.owner_name.length > 0)
                                  ? model.owner_name
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
                              'Occupier',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.occupier != null &&
                                      model.occupier.length > 0)
                                  ? model.occupier
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
                              'Type.',
                              style: GoogleFonts.lato(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              (model != null &&
                                      model.property_user != null &&
                                      model.property_user.length > 0)
                                  ? model.property_user
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
                    height: 10,
                  ),
                  Divider(),
                  Text('Cost Info '),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Description',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Cost (GHS)',
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
                          'Total Cost',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        (model != null &&
                                model.total_cost != null &&
                                model.total_cost.length > 0)
                            ? model.total_cost
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
                          'Replacement Cost',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null &&
                                  model.replacement_cost != null &&
                                  model.replacement_cost.length > 0)
                              ? model.replacement_cost
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
                          'Depreciation Rate',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null &&
                                  model.depreciation_rate != null &&
                                  model.depreciation_rate.length > 0)
                              ? model.depreciation_rate
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
                          'Depreciation Value',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null &&
                                  model.depreciated_value != null &&
                                  model.depreciated_value.length > 0)
                              ? model.depreciated_value
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
                          'Rateable Value',
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (model != null &&
                                  model.rateable_value != null &&
                                  model.rateable_value.length > 0)
                              ? model.rateable_value
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
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyRateableValueMap(
                                  model: model,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'View On Map',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
