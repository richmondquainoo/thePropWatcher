import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/model/InvoiceModel.dart';
import 'package:elandguard/userScreens/Payment/PaymentDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentHistoryScreen extends StatefulWidget {
  final List<InvoiceModel> list;

  PaymentHistoryScreen({this.list});

  @override
  _PaymentHistoryScreenState createState() =>
      _PaymentHistoryScreenState(list: list);
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final List<InvoiceModel> list;

  _PaymentHistoryScreenState({this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        centerTitle: true,
        title: Text(
          "Payment History",
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
                      "View payment history below",
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
                    children: populateHistory(),
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 0.3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> populateHistory() {
    List<ListTile> li = [];
    if (list.isNotEmpty) {
      for (InvoiceModel inv in list) {
        String date = '-';
        if (inv.paymentDate != null) {
          date = inv.paymentDate.substring(0, 10);
        }
        li.add(ListTile(
          title: Text(
            'Service: ${inv.serviceName}',
            style: GoogleFonts.lato(),
          ),
          subtitle: Text(
            'Date: $date | Amt: GHS ${inv.paymentAmount.toStringAsFixed(2)} | Status: ${inv.status}',
            style: GoogleFonts.lato(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentDetailsScreen(
                    model: inv,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: (inv.status != null && inv.status == 'Paid')
                    ? Colors.teal
                    : Colors.deepOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text(
                  'View Details',
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ),
          ),
          isThreeLine: true,
        ));
      }
    }
    return li;
  }
}
