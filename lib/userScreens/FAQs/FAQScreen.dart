import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        centerTitle: true,
        title: Text(
          "FAQs",
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
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What is PropertyWatch?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "PropertyWatch is a publicly available app designed to provide you an integrated tool for monitoring your land property in Ghana.",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What services are available in PropertyWatch?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "The list of services currently available to clients are: "
              "\n1. $SERVICE_1"
              "\n2. $SERVICE_2"
              "\n3. $SERVICE_3"
              "\n4. $SERVICE_4"
              "\n5. $SERVICE_5",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "Are the services Paid or Free?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "Apart from \"$SERVICE_5\", which is a free service, all others are paid services.",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What is $SERVICE_1?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "This service allows a client to $SERVICE_1_INFO.",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What is $SERVICE_2?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "This service allows you to $SERVICE_2_INFO",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What is $SERVICE_3?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "This service allows you to $SERVICE_3_INFO",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What is $SERVICE_4?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "This service allows you to $SERVICE_4_INFO",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What is $SERVICE_5?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "This service allows you to $SERVICE_5_INFO.",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "What do i need to view the location of my site plan?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "To view the location of a site plan, you need a site plan with a QR Code details.",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "How do I track my jobs at Lands Commission?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "To track your job at Lands Commission, you need a valid Job Number. "
              "You can either scan using the QR Code button or enter the Job number to track your job.",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
          ListTile(
            minVerticalPadding: 10,
            title: Text(
              "How do I verify a rateable value?",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              "To verify a rateable value, you need a valid valuation number of your property. "
              "You can either scan using the QR Code button or enter the valuation number to verify the rateable value.",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
