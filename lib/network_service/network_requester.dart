import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../main.dart';
import '../screens/login.dart';
import '../utils/user_data.dart';

class NetworkRequester{
  var logger = Logger();



  //get method
  Future getRequest(String url)async{
    try{
      http.Response response = await http.get(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "token": UserData.token ?? ""
          }
      );
      if(response.statusCode==200){
        logger.i(jsonDecode(response.body));
        return jsonDecode(response.body);
      }else if(response.statusCode ==401) {
        final sharPref = await SharedPreferences.getInstance();
        sharPref.clear();
        Navigator.pushAndRemoveUntil(
            MyApp.navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => LoginScreen()), (
            route) => false);
      } else{
        logger.e('Request Failed');
      }
    }catch(e){
      logger.e(e);
    }
  }

  //post method
  Future postRequest(String url,Map<String,String> body)async{

    try{
      http.Response response = await http.post(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "token": UserData.token ?? ""
          }
      );
      if(response.statusCode==200){
        logger.i(jsonDecode(response.body));
        logger.i(response.statusCode);
        return jsonDecode(response.body);
      }else if(response.statusCode ==401){
        final sharPref = await SharedPreferences.getInstance();
        sharPref.clear();
        Navigator.pushAndRemoveUntil(
            MyApp.navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
      } else{
        logger.e('Request Failed');
      }
    }catch(e){
      logger.e(e);
    }
  }

}