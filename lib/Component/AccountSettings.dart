import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountSettings extends StatelessWidget {

  final IconData selectIcon;
  final String settingText;

  const AccountSettings(
      {@required this.selectIcon,
        @required this.settingText,
      });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 13),
      child: Column(
        children: [
          Container(
            child: Row(
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
                      height: 9,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
