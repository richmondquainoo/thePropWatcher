import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountInfoWidget extends StatelessWidget {
  final IconData selectIcon;
  final String settingText;
  final String firstSubtext;
  final String secondSubText;
  final String thirdSubText;
  final Color userColor;

  const AccountInfoWidget(
      {@required this.selectIcon,
      @required this.settingText,
      this.firstSubtext,
      this.secondSubText,
      this.thirdSubText,
      this.userColor,
      });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 9),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Icon(
                    selectIcon!= null ? selectIcon:Icons.person ,
                    size: 27,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        settingText!= null ? settingText :"My Account",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          // color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                           firstSubtext!= null ? firstSubtext : "",
                            style: GoogleFonts.lato(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              // color: Colors.black38,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text(
                            secondSubText!= null ? secondSubText : "",
                            style: GoogleFonts.lato(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              // color: Colors.black38,
                            ),
                          ),
                        ),
                        // Container(
                        //   child: Text(
                        //     thirdSubText!= null ? thirdSubText : "Username",
                        //     style: GoogleFonts.lato(
                        //       fontSize: 11,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black38,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
