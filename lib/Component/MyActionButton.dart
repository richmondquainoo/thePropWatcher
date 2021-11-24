import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyActionButton extends StatelessWidget {
  final String actionText;
  final Color actionColor;

  const MyActionButton({this.actionText, this.actionColor});


  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          actionText!= null ? actionText : "Done",
          style: GoogleFonts.lato(
              fontSize: 20,
              color: actionColor!= null ?actionColor : Colors.white,
              fontWeight: FontWeight.w600),
        ));
  }
}

