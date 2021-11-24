import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final Color iconColor;

  const BackButton({this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: 25,
          color: iconColor!= null ? iconColor : Colors.white
        ),
      ),
    );
  }
}

