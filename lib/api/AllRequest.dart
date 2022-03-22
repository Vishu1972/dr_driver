
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AllHttpRequest extends StatelessWidget {

  static String apiUrl= "http://drcab.vfastdelivery.in/api/Rebliss/";

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future login(funName,body) async {
    print(body);
    // set up POST request arguments
    String url = AllHttpRequest.apiUrl+funName;
    print(url);

    // make POST request
    var response = await http.post(Uri.parse(url), body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      print('get Response body: ${response.body}');
//      CustomToast.showToastMessage("get Response body: ${response.body}");
      return json.decode(response.body);
    } else if (response.statusCode == 422) {
      // If the call to the server was successful, parse the JSON.
      print('get Response body: ${response.body}');
//      CustomToast.showToastMessage("get Response body: ${response.body}");
      return json.decode(response.body);
    } else {
      print("failed");
      return false;
    }
  }

  Future postRequest(funName, body) async {
    String url = AllHttpRequest.apiUrl+funName;
    // make POST request
    Map<String, String> headers = {
      "Accept":"application/json",
      "Content-Type":"application/json",
    };
    var response = await http.post(Uri.parse(url), headers:headers, body: json.encode(body));
    print(response.request);
    print(response.statusCode);
    print('get Response body: ${response.body}');
//    return json.decode(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future postUnAuthRequest(funName,body) async {
    print(body);
    // set up POST request arguments
    String url = AllHttpRequest.apiUrl+funName;
    print(url);
    Map<String, String> headers = {
      "Accept":"application/json",
      "Content-Type":"application/json",
    };

    // make POST request
    var response = await http.post(Uri.parse(url), body: body, headers: headers);
    print(response.statusCode);
    print('get Response body: ${response.body}');
//    return json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return json.decode(response.body);
    } else if (response.statusCode == 422 || response.statusCode == 400) {
      // If the call to the server was successful, parse the JSON.
      return json.decode(response.body);
    } else {
      print("failed");
      return null;
    }
  }

  Future getUnAuthRequest(funName) async {
    // set up Get request arguments
    final String url = AllHttpRequest.apiUrl+funName;
    print(url);
//    CustomToast.showToastMessage("Url=====$url");
    // make POST request
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print('get Response body: ${response.body}');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
//      CustomToast.showToastMessage("get Response body: ${response.body}");
      return json.decode(response.body);
    } else if(response.statusCode == 201 || response.statusCode == 422) {
      return json.decode(response.body);
    } else {
      print("failed");
      return false;
    }
  }

  Future getAuthRequest(funName) async {
    final String token = "await PreferenceHelper.getToken()";

    // set up Get request arguments
    final String url = AllHttpRequest.apiUrl+funName;
    print(url);
    Map<String, String> headers = {
      'Authorization' : '$token'
    };
    print("Token $token");
    // make POST request
    var response = await http.get(Uri.parse(url), headers: {'Authorization':'Bearer $token'});
    if (kDebugMode) {
      print("Request Header == ${response.request?.headers}");
    }
    print("Status Code == ${response.statusCode}");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      print('get Response body: ${response.body}');
      return json.decode(response.body);
    } else {
      print("failed");
      // If the call to the server was successful, parse the JSON.
      print('get Response body: ${response.body}');
      return json.decode(response.body);
    }
  }


  Future uploadResource(funName, List<Map<String, dynamic>> imageList, requestParam) async {

    print("Resource request data: $imageList");
    print("URL: ${AllHttpRequest.apiUrl+funName}");

    var request = http.MultipartRequest('POST', Uri.parse(AllHttpRequest.apiUrl+funName));
    request.headers.addAll({
      "Accept":"application/json",
      'Content-Type': 'multipart/form-data'
    });
    request.fields['Name'] = "${requestParam['Name']}";
    request.fields['AadharNumber'] = "${requestParam['AadharNumber']}";
    request.fields['DriverMobile'] = "${requestParam['DriverMobile']}";
    request.fields['DriverAadharNumber'] = "${requestParam['DriverAadharNumber']}";
    request.fields['Vehiclenumber'] = "${requestParam['Vehiclenumber']}";
    request.fields['Insurancestart'] = "${requestParam['Insurancestart']}";
    request.fields['Insuranceend'] = "${requestParam['Insuranceend']}";
    request.fields['Permit'] = "${requestParam['Permit']}";
    request.fields['confirmation'] = "${requestParam['confirmation']}";

    List<http.MultipartFile> newList = [];
    for(var image in imageList) {
      File imageFile = File(image['path'].toString());
      String fileName = image['path'].split("/").last;
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile("${image['key']}", stream.cast(), length, filename: fileName);
      newList.add(multipartFile);
    }
//    request.fields.addAll(requestParam);
    request.files.addAll(newList);
    print("All images added");
    try {
      var streamResponse = await request.send();

//      var response = await http.Response.fromStream(streamResponse);
//      if (response.statusCode != 200) {
//        print("Image upload status code is not : 200");
//        return null;
//      }
      var responseData = await streamResponse.stream.bytesToString();
      debugPrint("ResponseData====$responseData");
      var resultData = json.decode(responseData);
      debugPrint("ResultData====$resultData");

      return resultData;
    } catch(e){
      debugPrint("$e");
      return null;
    }
  }
}
