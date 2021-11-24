import 'dart:convert';

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:elandguard/Constants/myColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elandguard/tools/app_tools.dart';
import 'package:http/http.dart' as http;




class VerifyRateableValue extends StatefulWidget {


  @override
  _VerifyRateableValueState createState() => _VerifyRateableValueState();
}

class _VerifyRateableValueState extends State<VerifyRateableValue> {
   String qrCodeResult = "Not Yet Scanned";
   TextEditingController jobnumber = new TextEditingController();
  
   final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;


  String _txtclientnameString = '';
  String _txtjob_statusString = '';
  String _txtbusiness_process_nameString = '';


  final String posturl = "http://41.66.204.146:7273/epma_service/rest/";

String dataToPost ='';
String dataToPostresult ='';
List  datamilsetonetresult;
  List data;

  Future<String> getData(String datatobeposted) async {
    var response = await http.post(Uri.parse(posturl+"android_web_service/select_andriod_get_details_of_valuation_number"),
      headers: {
        "Accept": "application/json"
      },
      body: datatobeposted
    );

    this.setState(() {
      
      dataToPostresult =response.body;
      //data = json.decode(response.body);
    });
    

    var data = json.decode(dataToPostresult);
  //var applicationdetails = data["application_details"].toString();
//var dataapplication_details = json.decode(applicationdetails);


   // Map applicationdetailsdata = json.decode(data);
    var videos = data['data']; //returns a List of Maps
   
       _txtclientnameString =  'Applicant Name: ' + videos['owner_name'];
          _txtbusiness_process_nameString =  'Rateable Value : ' + videos['rateable_value'].toString();
         _txtjob_statusString = 'House Number: ' + videos['house_number'];
   
   
   





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
    //this.getData();
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
     backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        backgroundColor: kPrimaryTheme,
        title: new Text("Check Reable Value"),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.blue),
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
                textHint: "Enter Valuation Number",
                textIcon: Icons.person,
                controller: jobnumber),
      
            
               Row(
              children: <Widget>[
                 appButton(
                btnTxt: "Scan QR Code",
                onBtnclicked: scanBarcode,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
                appButton(
                btnTxt: "Search",
                onBtnclicked: verifyDetails,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
              ],
            ),

   
            
                  new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Valuation Details",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                       new Text(
                           _txtclientnameString,
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                         _txtbusiness_process_nameString,
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                         new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                        _txtjob_statusString,
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
            
          
          ],
        ),
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
           /*    Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => new GirliesCart())); */
            },
            child: new Icon(Icons.close),
          ),
        
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Container(
          height: 50.0,
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             /*  new Container(
                width: (screenSize.width - 20) / 2,
                child: new Text(
                  "ADD TO FAVORITES",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ), */
              new Container(
                width: (screenSize.width - 20) / 2,
                child: new Text(
                  "Status",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
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



String jsonRequestValue='{"valuation_number": "' + jobnumber.text +'"}';
//String jsonRequestValue='{"job_number": "LCGAOS21308482020"}';

dataToPost=jsonRequestValue;
getData(dataToPost);

 
  }

scanBarcode() async {

 String codeSannernew = await BarcodeScanner.scan();

 jobnumber.text=codeSannernew;
  }


}




