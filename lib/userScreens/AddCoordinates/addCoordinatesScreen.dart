import 'package:elandguard/Constants/myColors.dart';
import 'package:elandguard/Util/Utility.dart';
import 'package:flutter/material.dart';

class AddCoordinatesScreen extends StatefulWidget {
  @override
  _AddCoordinatesScreenState createState() => _AddCoordinatesScreenState();
}

class _AddCoordinatesScreenState extends State<AddCoordinatesScreen> {
  final List<String> coordinates = <String>[];

  void addItemToList() {
    setState(() {
      coordinates.insert(0, coordinatesController.text);
    });
  }

  void editItemOnList() {
    setState(() {
      coordinates.insert(0, editCoordinatesController.text);
    });
  }
  _displayDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24),
                  Text(
                    "Enter Coordinates",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryTheme,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller: coordinatesController,
                        maxLines: 1,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: coordinatesController.clear,
                            icon: Icon(Icons.clear),
                          ),
                          labelText: 'Northings, Eastings',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      )),
                  // Container(
                  //   width: 150.0,
                  //   height: 1.0,
                  //   color: Colors.grey[400],
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.only(top: 10, right: 75, left: 75),
                  //     child: TextFormField(
                  //       controller: latitudeController,
                  //       maxLines: 1,
                  //       autofocus: false,
                  //       keyboardType: TextInputType.text,
                  //       decoration: InputDecoration(
                  //         suffixIcon: IconButton(
                  //           onPressed: latitudeController.clear,
                  //           icon: Icon(Icons.clear),
                  //         ),
                  //         labelText: 'Eastings',
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(8.0),
                  //         ),
                  //       ),
                  //     )),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel".toUpperCase(),
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Add".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryTheme,
                          ),
                        ),
                        onPressed: () {
                          print('Update the user info');
                          if (coordinatesController.text.isEmpty) {
                            new UtilityService().showMessage(
                                context: context,
                                message: "Enter longitude,latitude",
                                icon: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ));
                          } else {
                            addItemToList();
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24),
                  Text(
                    "Edit Coordinates",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryTheme,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 25, left: 25),
                      child: TextFormField(
                        controller: coordinatesController,
                        maxLines: 1,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: coordinatesController.clear,
                            icon: Icon(Icons.clear),
                          ),
                          labelText: 'Northings, Eastings',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      )),
                  // Container(
                  //   width: 150.0,
                  //   height: 1.0,
                  //   color: Colors.grey[400],
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.only(top: 10, right: 75, left: 75),
                  //     child: TextFormField(
                  //       controller: latitudeController,
                  //       maxLines: 1,
                  //       autofocus: false,
                  //       keyboardType: TextInputType.text,
                  //       decoration: InputDecoration(
                  //         suffixIcon: IconButton(
                  //           onPressed: latitudeController.clear,
                  //           icon: Icon(Icons.clear),
                  //         ),
                  //         labelText: 'Eastings',
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(8.0),
                  //         ),
                  //       ),
                  //     )),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel".toUpperCase(),
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "Edit".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryTheme,
                          ),
                        ),
                        onPressed: () {
                          print('Update the user info');
                          if (coordinatesController.text.isEmpty) {
                            new UtilityService().showMessage(
                                context: context,
                                message: "Enter longitude,latitude",
                                icon: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ));
                          } else {
                            editItemOnList();
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  var coordinatesController = TextEditingController();
  var editCoordinatesController = TextEditingController();
  // var longitudeController = TextEditingController();
  // var latitudeController = TextEditingController();

  String longitude;
  String latitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryTheme,
        title: Text("My Coordinates"),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: _displayDialog,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kPrimaryTheme,
                  ),
                  child: Center(
                    child: Text(
                      "Add Coordinates",
                      style: TextStyle(
                          fontSize: 19,
                          wordSpacing: 0.4,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: kPrimaryCardBackground,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 22,
                      color: Colors.teal,
                    ),
                    SizedBox(width: 5,),
                    Center(
                      child: Text(
                        "Added Coordinates",
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.w300,
                            color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "Swipe left to remove coordinates",
                style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: coordinates.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = coordinates[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          coordinates.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$item has been removed'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      },
                      background: Container(color: Colors.red),
                      child: GestureDetector(
                        onTap: (){
                          _editDialog();
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              '${coordinates[index]}',
                              style: TextStyle(fontSize: 18),
                            ),
                            leading: Icon(
                              Icons.location_on_sharp,
                              size: 22,
                              color: Colors.black54,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                new UtilityService().confirmationBox(
                                    context: context,
                                    title: "Delete Item",
                                    color: kPrimaryTheme,
                                    message:
                                        "Are you sure you want to delete this item?",
                                    onNo: () {
                                      Navigator.pop(context);
                                    },
                                    onYes: () {
                                      coordinates.removeAt(0);
                                      Navigator.pop(context);
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 30,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: kPrimaryCardBackground,
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 20.0, right: 20),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               Container(
            //                 child: Text("Northings:"),
            //               ),
            //               SizedBox(width: 5,),
            //               Container(
            //                 child: Text(longitude !=null ? longitude : " "),
            //               ),
            //             ],
            //           ),
            //           Row(
            //             children: [
            //               Container(
            //                 child: Text("Eastings:"),
            //               ),
            //               SizedBox(width: 5,),
            //               Container(
            //                 child: Text(latitude !=null ? latitude : " "),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     )
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // GestureDetector(
            //   onTap: () {
            //     new UtilityService().confirmationBox(
            //       context: context,
            //       message: "Are you sure you want to clear coordinate list?",
            //       title: "Clear List",
            //       onNo: () {
            //         Navigator.pop(context);
            //       },
            //       onYes: () {
            //         coordinates.removeAt(0);
            //         Navigator.pop(context);
            //       },
            //       color: kPrimaryTheme,
            //     );
            //   },
            //   child: Container(
            //     height: 30,
            //     width: 120,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.white,
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black12,
            //             offset: Offset(0.4, 1),
            //             spreadRadius: 0.4,
            //           ),
            //         ]),
            //     child: Center(
            //       child: Text(
            //         "Clear all",
            //         style: TextStyle(
            //             fontSize: 15.8,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.redAccent),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 60,
            // ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal,
                  ),
                  child: Center(
                    child: Text(
                      "Process Data",
                      style: TextStyle(
                          fontSize: 19,
                          wordSpacing: 0.4,
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
    );
  }
}
