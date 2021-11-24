import 'package:http/http.dart' as http;
//import 'package:lc_mobile/classes/ContactIdentificationForm_cls.dart';
import 'dart:convert';

  class WebService {
  
   //Create a private constructor
  WebService._();
  // make this a singleton class
 WebService._privateConstructor();
 static final WebService instance = WebService._privateConstructor();
 
final String post_url = "http://41.66.204.146:8283/gelis_online_service_live/rest/";
static const post_url1 = "http://41.66.204.146:8283/gelis_online_service_live/rest/";
Future<String> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}




Future<String> track_job(String dataToPost) async{
 
 //final response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  final response = await http.post(Uri.parse(post_url+"case_management_service/load_application_milestone_for_tracking_by_job"),
      headers: {
        //HttpHeaders.contentTypeHeader: 'application/json'
        //if your api require key then pass your key here as well e.g "key": "my-long-key"
       "Accept": "application/json" 
      },
      body: dataToPost
  );
   if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body.toString();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  
}



Future<String> contact_identification_form_update_geolocation_Post(String data_to_post) async{
  final response = await http.post(Uri.parse(post_url+"contact_identification_form/contact_identification_form_update_geolocation"),
      headers: {
        //HttpHeaders.contentTypeHeader: 'application/json'
        //if your api require key then pass your key here as well e.g "key": "my-long-key"
       "Accept": "application/json" 
      },
      body: data_to_post
  );
   if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  
}


Future<String> contact_identification_form_add_update_Post(String data_to_post) async{
  final response = await http.post(Uri.parse(post_url+"contact_identification_form/contact_identification_form_add_update"),
      headers: {
        //HttpHeaders.contentTypeHeader: 'application/json'
        //if your api require key then pass your key here as well e.g "key": "my-long-key"
       "Accept": "application/json" 
      },
      body: data_to_post
  );
   if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  
}

/* static Future<List<ContactIdentificationForm>>  select_all_contact_identification_form_all_Post(String data_to_post) async{
 try {
  final response = await http.post(post_url1+"contact_identification_form/select_all_contact_identification_form",
      headers: {
        //HttpHeaders.contentTypeHeader: 'application/json'
        //if your api require key then pass your key here as well e.g "key": "my-long-key"
       "Accept": "application/json" 
      },
      body: data_to_post
  );
   if (response.statusCode == 200) {
 
 List<ContactIdentificationForm> listModel = [];
  var loading = false;

 final data = jsonDecode(response.body);
print(data);

for(Map i in data){
          listModel.add(ContactIdentificationForm.fromJson(i));
        }
return listModel;
     // List jsonResponse = json.decode(response.body);
    //  return jsonResponse.map((job) => new ContactIdentificationForm.fromJson(job)).toList();

 //List<ContactIdentificationForm> list = map<ContactIdentificationForm>((json) => ContactIdentificationForm.fromJson(json)).toList()
//print(data[0]["name"]);

    /* 
        var rest = data["articles"] as List;
        print(rest);
        list = rest.map<ContactIdentificationForm>((json) => ContactIdentificationForm.fromJson(json)).toList(); */
      //return list;
    //return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');/*  */
  }
 } catch (e) {
      throw Exception(e.toString());
}

  
}

static List<ContactIdentificationForm> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ContactIdentificationForm>((json) => ContactIdentificationForm.fromJson(json)).toList();
  } */


}


/* var jsonData = '{ "name" : "Dane", "alias" : "FilledStacks"  }';
var parsedJson = json.decode(jsonData); */