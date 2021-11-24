import 'dart:convert';

import 'package:elandguard/Constants/myColors.dart';
import 'package:flutter/material.dart';
import 'package:elandguard/tools/app_tools.dart';
import 'package:http/http.dart' as http;


import 'WebService.dart';

class GirliesTrackApplication extends StatefulWidget {
  @override
  _GirliesTrackApplicationState createState() => _GirliesTrackApplicationState();
}

class _GirliesTrackApplicationState extends State<GirliesTrackApplication> {
   TextEditingController jobnumber = new TextEditingController();
 
  TextEditingController txtclientname = new TextEditingController();
  TextEditingController txtjob_status = new TextEditingController();
  TextEditingController txtbusiness_process_name = new TextEditingController();
  
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;

final String posturl = "http://41.66.204.146:8283/gelis_online_service_live/rest/";

String dataToPost ='';
String dataToPostresult ='';
List  datamilsetonetresult;
  List data;

  Future<String> getData() async {
    var response = await http.post(Uri.parse(posturl+"case_management_service/load_application_milestone_for_tracking_by_job"),
      headers: {
        "Accept": "application/json"
      },
      body: dataToPost
    );

    this.setState(() {
      
      dataToPostresult =response.body;
      //data = json.decode(response.body);
    });
    
   // showSnackBar(dataToPostresult, scaffoldKey);
    //print(data[1]["data"]);
    
    return "Success!";
  }

   List<Widget> getDataList() {
    var tempList = datamilsetonetresult.map((value) {
      return ListTile(
        leading: Image.network(value["imageUrl"]),
        title: Text(value["title"]),
        subtitle: Text(value["author"]),
      );
    });
    return tempList.toList();
  }

final GlobalKey<AnimatedListState> _listKey = GlobalKey();
final GlobalKey<AnimatedListState> _listKeymsg = GlobalKey();

      // backing data
      List<String> _data = [];
      List<String> _datamsg = [];

  @override
  void initState(){
    this.getData();
  }
    
  
  
  @override
  Widget build(BuildContext context) {
   this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: kPrimaryTheme,
      appBar: new AppBar(
        title: new Text("Tracking Application"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Job Number",
                textIcon: Icons.person,
                controller: jobnumber),
            new SizedBox(
              height: 10.0,
            ),
             appButton(
                btnTxt: "Track",
                onBtnclicked: verifyDetails,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
                 new SizedBox(
              height: 30.0,
            ),
             
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Applicant Name",
                textIcon: Icons.phone,
                textType: TextInputType.text,
                controller: txtclientname),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Status",
                textIcon: Icons.email,
                controller: txtjob_status),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Application Type",
                textIcon: Icons.lock,
                controller: txtbusiness_process_name),
            new SizedBox(
              height: 30.0,
            ),
          SizedBox(
              height: 300,
              child: AnimatedList(
                // Give the Animated list the global key
                padding: const EdgeInsets.all(15),
              
                key: _listKey,
                initialItemCount: _data.length,
                // Similar to ListView itemBuilder, but AnimatedList has
                // an additional animation parameter.
                itemBuilder: (context, index, animation) {
                  // Breaking the row widget out as a method so that we can
                  // share it with the _removeSingleItem() method.
                  return _buildItem(_data[index], animation);
                },
              ),
            ),
             SizedBox(height: 20,), 
            Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                Text('Notification of Jobs', style: TextStyle(
                  
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'avenir'
                ),),
                Container(
                 padding: const EdgeInsets.all(15),
                  height: 60,
                  width: 60,
                  child: Icon(Icons.settings_remote),
                )
              ],
            ),
           SizedBox(
              height: 200,
               child: AnimatedList(
                // Give the Animated list the global key
                padding: const EdgeInsets.all(15),
               key: _listKeymsg,
                initialItemCount: _datamsg.length,
                itemBuilder: (context, index, animation) {
                  // Breaking the row widget out as a method so that we can
                  // share it with the _removeSingleItem() method.
                  return _buildItemmsg(_datamsg[index], animation);
                },
              ),
            ), 
            
          /*  RaisedButton(
              child: Text('Insert item', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _insertSingleItemmsg('Jogn');
              },
            ),  */
          ],
        ),
      ),
      
    );
  }



 // This is the animated row with the Card.
      Widget _buildItem(String item, Animation animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            color: Colors.white,
            child: ListTile(
              title: Text(
                item,
                style: TextStyle(fontSize: 16),
              ),
               subtitle: Text(
                item,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        );
      }


// This is the animated row with the Card.
      Widget _buildItemmsg(String item, Animation animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            color: Colors.white,
            child: ListTile(
              title: Text(
                item,
                style: TextStyle(fontSize: 12),
              ),
               /* subtitle: Text(
                item,
                style: TextStyle(fontSize: 10),
              ), */
            ),
          ),
        );
      }


       void _insertSingleItem(String itemvakuse) {
        String newItem = itemvakuse;
        // Arbitrary location for demonstration purposes
        int insertIndex = 0;
        // Add the item to the data list.
        _data.insert(insertIndex, newItem);
        // Add the item visually to the AnimatedList.
        _listKey.currentState.insertItem(insertIndex);
      }


       void _insertSingleItemmsg(String itemvakuse) {
        String newItem = itemvakuse;
        // Arbitrary location for demonstration purposes
        int insertIndex = 0;
        // Add the item to the data list.
        _datamsg.insert(insertIndex, newItem);
        // Add the item visually to the AnimatedList.
        _listKeymsg.currentState.insertItem(insertIndex);
      }


 verifyDetails() async {
    if (jobnumber.text == "") {
      showSnackBar("Job Number cannot be empty", scaffoldKey);
      return;
    }



String jsonRequestValue='{"job_number": "' + jobnumber.text +'"}';
//String jsonRequestValue='{"job_number": "LCGAOS21308482020"}';

dataToPost=jsonRequestValue;
getData();

 var data = json.decode(dataToPostresult);
  var applicationdetails = data["application_details"].toString();
//var dataapplication_details = json.decode(applicationdetails);

     // Map applicationdetailsdata = json.decode(data);
    var videos = data['application_details']; //returns a List of Maps
    for (var items in videos){ //iterate over the list
          Map myMap = items; //store each map 
          print(myMap['client_name']);
          txtclientname.text=myMap['client_name'];
          txtjob_status.text=myMap['job_status'];
          txtbusiness_process_name.text=myMap['business_process_name'];

    }


//_listKey.currentState.
  var milestones = data['milestones']; //returns a List of Maps
    for (var items in milestones){ //iterate over the list
          Map myMap = items; //store each map 
          print(myMap['milestone_description']);
          
          _insertSingleItem(myMap['milestone_description']);
          

    }

 var notifications = data['notifications']; //returns a List of Maps
    for (var items in notifications){ //iterate over the list
          Map myMap = items; //store each map 
          print(myMap['sms_message']);
          
          _insertSingleItemmsg(myMap['sms_message']);
          

    }



datamilsetonetresult = data['application_details'] as List;

   // String resultstring=  WebService.instance.track_job(jsonRequestValue).toString();
  
     // print(resultstring);
 // showSnackBar(resultstring, scaffoldKey);

     // _showDialog(this.context);
      //Alert(context: context, title: "Contact Save", desc: 'Contact Save Successfully').show();
     /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => DashBoardMenu(),
      )); */
                                              // 

   /*  if (phoneNumber.text == "") {
      showSnackBar("Phone cannot be empty", scaffoldKey);
      return;
    }

    if (email.text == "") {
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    if (re_password.text == "") {
      showSnackBar("Re-Password cannot be empty", scaffoldKey);
      return;
    }

    if (password.text != re_password.text) {
      showSnackBar("Passwords don't match", scaffoldKey);
      return;
    } */

 /*    displayProgressDialog(context);
    String response = await appMethod.createUserAccount(
        fullname: fullname.text,
        phone: phoneNumber.text,
        email: email.text.toLowerCase(),
        password: password.text.toLowerCase());

    if (response == successful) {
      closeProgressDialog(context);
      Navigator.of(context).pop();
      Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackBar(response, scaffoldKey);
    } */
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
