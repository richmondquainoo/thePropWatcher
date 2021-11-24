import 'package:flutter/material.dart';

class TopButtonComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: 22,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

}