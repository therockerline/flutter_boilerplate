import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scrappy/auth/auth_service.dart';
import 'package:scrappy/network/token_service.dart';

import '../auth/auth_service.dart';
import '../scrappy_const.dart';
import '../scrappy_const.dart';

class NetworkService {
  /*
  static http.Response _doRequest(Function f,{ String method, String context, String function, String params, dynamic data = null, String url = Environment.apiUrl}) {
    isSafe = false;
    http.Response result = f(method: method, data: data, context: context, function: function, params: params, url: url) as http.Response;
    isSafe = true;
    return result;
  }*/
  static Future<http.Response> get({String context = null, String function = null, String params = null, String url = ScrappyContstants.url}) async {
    return  await NetworkService._request(method: 'GET', context: context, function: function, params: params, url: url);
  }

  static Future<http.Response> post({ @required dynamic body, String context = null, String function = null, String params = null, String url = ScrappyContstants.url}) async {
    return await NetworkService._request(method: 'POST', context: context, function: function, params: params, data: body, url: url);
  }

  static Future<http.Response> patch({ @required dynamic body, String context = null, String function = null, String params = null, String url = ScrappyContstants.url}) async {
    return await NetworkService._request(method: 'PATCH', context: context, function: function, params: params, data: body, url: url);
  }

  static Future<http.Response> delete({ String context = null, String function = null, String params = null, String url = ScrappyContstants.url}) async {
    return await NetworkService._request(method: 'DELETE', context: context, function: function, params: params,  url: url);
  }

  static Future<http.Response> _request({@required String method, dynamic data = null, @required String context, @required String function, String params, bool renew = false, @required String url}) async {
    print(['try request',method,context,function,params,url]);
    http.Response response = null;
    Map<String,String> headers = Map<String,String>();
    headers["Accept"] = "application/json";
    headers["license"] = function != ScrappyContstants.networkFunctionLicense ? (AuthService.currentLicense != null ? AuthService.currentLicense.hash : params) : ScrappyContstants.networkFunctionLicense;
    String body;
    if(!([ ScrappyContstants.networkContextGuest, ScrappyContstants.networkContextPublic].contains(context)) && context != null ){
      String token = ( await TokenService.instance.getToken(role: context, renew: renew)) as String;
      headers["Authorization"] = "bearer $token";
    }
    if(data!=null){
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/x-www-form-urlencoded";
      body = data as String;
    }
    if(url == null)
      throw('url is not defined');
    //print(url);
    String uri = Uri.encodeFull(
        url +
            (context!=null?(context+'/'):'')  +
            (function!=null?(function+'/'):'') +
            (params ?? '')
    );
    DateTime start = DateTime.now();
    try {
      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'PATCH':
          response = await http.patch(uri, body: body, headers: headers);
          break;
        case 'POST':
          response = await http.post(uri, body: body, headers: headers);
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw('method non definito');
      }
    }catch(e){
      return null;
    }
    /*int millis = DateTime.now().difference(start).inMilliseconds;
    String stringMillis = repeatCharInHead(str: "${millis}",char: ' ', strLength: 6);
    if(url == Environment.apiUrl) {
      NetworkService.stat.add(millis);
      double media = NetworkService.stat.reduce((val, elem) => val + elem) / NetworkService.stat.length;
      print(media);
    }*/
    //print([start,"await $stringMillis","statusCode ${response.statusCode}",uri, data.toString()]);
    //gestione errori
    switch(response.statusCode) {
      case ScrappyContstants.invalidToken: //invalid token
        return await _request(method: method,
            data: data,
            context: context,
            function: function,
            params: params,
            url: url,
            renew: true);
      default: return response;
    }
  }
}