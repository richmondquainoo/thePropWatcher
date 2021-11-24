import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextButtonComponent extends StatelessWidget {
  final String label;
  final Function onTap;
  final Color labelColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final BoxShadow boxShadow;
  final double offSetX;
  final double offSetY;
  final double spreadRadius;
  final double blurRadius;
  final Color shadowColor;

  TextButtonComponent(
      {@required this.label,
      @required this.onTap,
      this.labelColor,
      this.fontSize,
      this.borderRadius,
      this.boxShadow,
      this.offSetX,
      this.offSetY,
      this.spreadRadius,
      this.blurRadius,
      this.shadowColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              height: 45,
              decoration: BoxDecoration(
                color: labelColor != null ? labelColor : Colors.pink,
                borderRadius: BorderRadius.circular(
                  borderRadius != null ? borderRadius : 20,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(offSetX != null ? offSetX : 0.2,
                        offSetY != null ? offSetX : 0.2),
                    blurRadius: blurRadius != null ? blurRadius : 0.2,
                    spreadRadius: spreadRadius != null ? spreadRadius : 0.2,
                    color: shadowColor != null ? shadowColor : Colors.black12,
                  ),
                ],
              ),
              child: Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: fontSize != null ? fontSize : 21,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                  color: textColor != null ? textColor : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
