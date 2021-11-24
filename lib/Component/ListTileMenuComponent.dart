import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ListTileMenuComponent extends StatelessWidget {

  final IconData icon;
  final String label;
  final Function onTap;

  const ListTileMenuComponent({
    this.icon,
    this.label,
    this.onTap
  });


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Icon(
                icon,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}