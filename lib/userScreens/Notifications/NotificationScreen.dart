import 'dart:convert';

import 'package:elandguard/Component/ProgressDialog.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/NetworkUtility.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:elandguard/Util/paths.dart';
import 'package:elandguard/model/ApplicationDetailsModel.dart';
import 'package:elandguard/model/MilestoneModel.dart';
import 'package:elandguard/model/TrackJobModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class NotificationScreen extends StatefulWidget {
  // final ServiceChargeModel serviceChargeModel;

  NotificationScreen();

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // final ServiceChargeModel serviceChargeModel;

  _NotificationScreenState();

  @override
  Widget build(BuildContext context) {
    // UserProfileModel user = Provider.of<AppData>(context, listen: false).userData;
    return Scaffold(
      backgroundColor: kBackgroundTheme,
      appBar: AppBar(
        backgroundColor: kBackgroundTheme,
        elevation: 0,
        title: Text(
          "My Notifications",
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
                      'Please view your notifications below.',
                      style: GoogleFonts.lato(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 0.5,
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

  Future<void> getJobDetails(
      {BuildContext context, TrackJobModel trackJobModel}) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return ProgressDialog(displayMessage: 'Please wait...');
        },
      );

      var jsonBody = jsonEncode(trackJobModel);
      NetworkUtility networkUtility = NetworkUtility();
      Response response = await networkUtility.postData(
        url: TRACK_JOB_URL,
        body: jsonBody,
      );

      Navigator.of(context, rootNavigator: true).pop();
      print(response.body);
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

        bool status = data['success'];

        // Handle network error
        if (!status) {
          new UtilityService().showMessage(
            message: 'An error has occurred. Please try again',
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            context: context,
          );
        } else {
          ApplicationDetailsModel details = ApplicationDetailsModel(
            client_name:
                data['application_details'][0]['client_name'].toString(),
            case_number:
                data['application_details'][0]['case_number'].toString(),
            job_status: data['application_details'][0]['job_status'].toString(),
            created_date:
                data['application_details'][0]['created_date'].toString(),
            modified_date:
                data['application_details'][0]['modified_date'].toString(),
            business_process_name: data['application_details'][0]
                    ['business_process_name']
                .toString(),
            business_process_sub_name: data['application_details'][0]
                    ['business_process_sub_name']
                .toString(),
            application_stage:
                data['application_details'][0]['application_stage'].toString(),
          );
          List<MilestoneModel> mod = [];
          var milestones = data['milestones'] as List;
          if (milestones.isNotEmpty) {
            for (int i = 0; i < milestones.length; i++) {
              MilestoneModel m = MilestoneModel(
                // ms_id: data['milestones'][i]['ms_id'],
                mile_stone_status: data['milestones'][i]['mile_stone_status'],
                milestone_description: data['milestones'][i]
                    ['milestone_description'],
                // working_day_required: data['milestones'][i]['working_day_required'],
                // milestone_remaining: data['milestones'][i]['milestone_remaining'],
              );
              mod.add(m);
            }
          }
          details.milestones = mod;
        }
      }
    } catch (e) {
      print('getJobDetails error: $e');
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
}
