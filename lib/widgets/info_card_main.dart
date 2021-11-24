import 'package:elandguard/constants.dart';
import 'package:elandguard/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCardMain extends StatelessWidget {
  final String title;
  final int effectedNum;
  final Color iconColor;
  final Function press;
  const InfoCardMain({
    Key key,
    this.title,
    this.effectedNum,
    this.iconColor,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: press,
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            // Here constraints.maxWidth provide us the available width for the widget
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
                          child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        // wrapped within an expanded widget to allow for small density device
                       /*  Expanded(
                            child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/running.svg",
                              height: 12,
                              width: 12,
                              color: iconColor,
                            ),
                          ),
                        ), */
                        SizedBox(width: 5),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),


  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                            alignment: Alignment.center,
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                              //color: iconColor.withOpacity(0.12),
                             // shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/images/delicious.jpeg",
                              height: 80,
                              width: 180,
                              //color: iconColor,
                            ),
                          ),
                        )
                       /*  Expanded(
                          child: LineReportChart(),
                        ), */
                      ],
                    ),
                  ),

  SizedBox(width: 110),
                 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

