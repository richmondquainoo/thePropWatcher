import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class MoreCardScreenComponent extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const MoreCardScreenComponent({
    this.label,
    this.icon,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 3),
              spreadRadius: 0.7,
              blurRadius: 0.8,
              color: Colors.black12,
            ),
            BoxShadow(
              offset: Offset(-1, -1),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              color: Colors.blueAccent,
            ),
          ],
          color: Colors.blueGrey,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 20,
              child: Icon(icon,
                color: Colors.white,),
            ),
            SizedBox(width: 12,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                      label,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Colors.white,
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}