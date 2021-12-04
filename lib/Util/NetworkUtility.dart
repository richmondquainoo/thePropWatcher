import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkUtility {
  Future<Response> getData(String url) async {
    try {
      var uri = Uri.parse(url);
      Response response = await http.get(uri);
      return response;
    } catch (e) {
      print('Network Service Error: ${e.toString()}');
      return null;
    }
  }

  Future<Response> getDataWithAuth({String url, String auth}) async {
    var uri = Uri.parse(url);
    Map<String, String> headers = {HttpHeaders.authorizationHeader: auth};
    try {
      Response response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      print('Network Service Error: ${e.toString()}');
      return null;
    }
  }

  Future<Response> postData({String url, String body}) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    var uri = Uri.parse(url);
    try {
      Response response = await http.post(uri, headers: headers, body: body);
      return response;
    } catch (e) {
      print('Network Service Error: ${e.toString()}');
      return null;
    }
  }

  Future<Response> postDataWithAuth(
      {String url, String body, String auth}) async {
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: auth
    };
    try {
      Response response = await http.post(uri, headers: headers, body: body);
      return response;
    } catch (e) {
      print('Network Service Error: ${e.toString()}');
      return null;
    }
  }
}
