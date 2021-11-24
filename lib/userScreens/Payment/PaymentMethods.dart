import 'package:elandguard/Constants/myColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethods extends StatefulWidget {

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        centerTitle: true,
        title: Text(
          "Payment Method",
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: 88,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(blurRadius: 0.4,
                        color: Colors.black38,
                        spreadRadius: 0.4,
                        offset: Offset(0.1,0.1)

                    ),
                  ],
                  color: kPrimaryCardBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Image(
                          image: AssetImage("assets/images/mastercard.png"),

                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        child: Text("MasterCard", style: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.w400),),

                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18,),
              Container(
                height: 88,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(blurRadius: 0.4,
                        color: Colors.black38,
                        spreadRadius: 0.4,
                        offset: Offset(0.1,0.1)

                    ),
                  ],
                  color: kPrimaryCardBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 80,
                        child: Image(
                          image: AssetImage("assets/images/slydepay.png"),
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        child: Text("SlydePay", style: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.w400),),

                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18,),
              Container(
                height: 88,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(blurRadius: 0.4,
                        color: Colors.black38,
                        spreadRadius: 0.4,
                        offset: Offset(0.1,0.1)

                    ),
                  ],
                  color: kPrimaryCardBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Image(
                          image: AssetImage("assets/images/expresspay.png"),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        child: Text("ExpressPay", style: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.w400),),

                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
