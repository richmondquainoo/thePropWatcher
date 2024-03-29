import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UtilityService {
  void showMessage({String message, Icon icon, BuildContext context}) {
    showFlash(
        context: context,
        duration: Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.bottom,
            behavior: FlashBehavior.floating,
            child: FlashBar(
              icon: icon,
              content: Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        });
  }

  //
  // void listBox({String title, String message, BuildContext context, Color color}) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Padding(
  //           padding: const EdgeInsets.all(12.0),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 height: 600,
  //                 width: 400,
  //                 decoration: BoxDecoration(
  //                   color: Colors.blue,
  //                   borderRadius: BorderRadius.circular(10),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       offset: Offset(0.5, 0.5),
  //                       spreadRadius: 0.2,
  //                       blurRadius: 0.2,
  //                     ),
  //                   ],
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10),
  //                       child: Container(
  //                         alignment: Alignment.center,
  //                         child: Text(
  //                           title,
  //                           style: GoogleFonts.lato(
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w700,
  //                               color: Colors.teal,
  //                               decoration: TextDecoration.none),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 30,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 15, right: 15),
  //                       child: Container(
  //                         //alignment: Alignment.center,
  //                         child: Center(
  //                           child: Text(
  //                             message,
  //                             style: GoogleFonts.lato(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.w400,
  //                               color: Colors.black,
  //                               decoration: TextDecoration.none,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
  //
  // void notificationMessageWithButton(
  //     {String title,
  //       String message,
  //       BuildContext context,
  //       Function proceed,
  //       Color color,
  //       buttonText,
  //       Color textColor,
  //       Color backgroundColor,
  //     }) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 height: 220,
  //                 width: 400,
  //                 decoration: BoxDecoration(
  //                   color:backgroundColor!=null ? backgroundColor :Colors.blueAccent,
  //                   borderRadius: BorderRadius.circular(10),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       offset: Offset(0.5, 0.5),
  //                       spreadRadius: 0.2,
  //                       blurRadius: 0.2,
  //                     ),
  //                   ],
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10),
  //                       child: Container(
  //                         alignment: Alignment.center,
  //                         child: Text(
  //                           title,
  //                           style: GoogleFonts.lato(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.black,
  //                               decoration: TextDecoration.none),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 30,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 15),
  //                       child: Container(
  //                         //alignment: Alignment.center,
  //                         child: Center(
  //                           child: Text(
  //                             message,
  //                             style: GoogleFonts.lato(
  //                               fontSize: 15,
  //                               wordSpacing: 0.8,
  //                               fontWeight: FontWeight.w400,
  //                               color: textColor!= null ? textColor : Colors.black,
  //                               decoration: TextDecoration.none,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 15,
  //                     ),
  //                     GestureDetector(
  //                       onTap: proceed,
  //                       child: Container(
  //                         height: 40,
  //                         width: 184,
  //                         decoration: BoxDecoration(
  //                           color: color,
  //                           borderRadius: BorderRadius.circular(10),
  //                           boxShadow: [
  //                             BoxShadow(
  //                               offset: Offset(0.4, 0.5),
  //                               spreadRadius: 0.2,
  //                               blurRadius: 0.2,
  //                             )
  //                           ],
  //                         ),
  //                         child: Center(
  //                           child: Text(
  //                             buttonText,
  //                             style: TextStyle(
  //                                 decoration: TextDecoration.none,
  //                                 fontSize: 17,
  //                                 fontWeight: FontWeight.w400,
  //                                 color: Colors.white),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  void notificationMessageWithButton({
    String title,
    String message,
    BuildContext context,
    Function proceed,
    Color color,
    buttonText,
    Color textColor,
    Color backgroundColor,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220,
                  width: 400,
                  decoration: BoxDecoration(
                    color: backgroundColor != null
                        ? backgroundColor
                        : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0.5),
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          //alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              message,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                wordSpacing: 0.8,
                                fontWeight: FontWeight.w400,
                                color: textColor != null
                                    ? textColor
                                    : Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: proceed,
                        child: Container(
                          height: 40,
                          width: 184,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.4, 0.5),
                                spreadRadius: 0.2,
                                blurRadius: 0.2,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void confirmationBox({
    String title,
    String message,
    BuildContext context,
    Function onYes,
    Function onNo,
    Color color,
    String buttonLabel,
    double buttonHeight,
    double buttonWidth,
    Color yesColor,
    Color noColor,
    String yesLabel,
    String noLabel,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0.5),
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 0.5,
                        indent: 30,
                        endIndent: 30,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Container(
                          //alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              message,
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                wordSpacing: 1,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: onYes,
                            child: Container(
                              height: buttonHeight != null ? buttonHeight : 35,
                              width: buttonWidth != null ? buttonWidth : 64,
                              decoration: BoxDecoration(
                                color: yesColor != null ? yesColor : color,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.2, 0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 0.2,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  yesLabel != null ? yesLabel : 'Yes',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: onNo,
                            child: Container(
                              height: buttonHeight != null ? buttonHeight : 35,
                              width: buttonWidth != null ? buttonWidth : 64,
                              decoration: BoxDecoration(
                                color: noColor != null ? noColor : color,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.2, 0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 0.2,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  noLabel != null ? noLabel : 'No',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void singleButtonConfirmation({
    String title,
    String message,
    BuildContext context,
    Function onYes,
    Color color,
    String buttonLabel,
    double buttonHeight,
    double buttonWidth,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0.5),
                        spreadRadius: 0.2,
                        blurRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          //alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              message,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                wordSpacing: 1,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: onYes,
                          child: Container(
                            height: buttonHeight != null ? buttonHeight : 35,
                            width: buttonWidth != null ? buttonWidth : 64,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.4, 0.5),
                                  spreadRadius: 0.2,
                                  blurRadius: 0.2,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                buttonLabel != null ? buttonLabel : 'Yes',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void messageContent({
    String title,
    String message,
    BuildContext context,
    Function onYes,
    Color color,
    String buttonLabel,
    double buttonHeight,
    double buttonWidth,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0.5, 0.5),
                    //     spreadRadius: 0.2,
                    //     blurRadius: 0.2,
                    //   ),
                    // ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          //alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              message,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                wordSpacing: 1.4,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
