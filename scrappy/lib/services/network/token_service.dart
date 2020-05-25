import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scrappy/scrappy_const.dart';

import '../scrappy_const.dart';
import 'network_service.dart';

class TokenService {
  static TokenService instance;
  String _token;
  String _authUrl;

  TokenService({String authUrl}){
    this._authUrl = authUrl;
    if(TokenService.instance!=null) throw('TokenService just initialized');
      TokenService.instance = this;
  }

  dynamic getToken({bool renew = false, String role}) async{
    if(_token == null || renew) _token = (await _createNewToken(role: role)) as String;
    return _token;
  }

  dynamic _createNewToken({String role}) async{
    String clientId = '';
    String clientSecret = '';
    String audience = '';
    switch(role){
      case ScrappyContstants.networkContextCashier: {clientId = ScrappyContstants.clientIDCashier; clientSecret= ScrappyContstants.clientSecretCashier; audience = ScrappyContstants.clientAudienceCashier;}break;
      case ScrappyContstants.networkContextWaiter: {clientId = ScrappyContstants.clientIDWaiter; clientSecret= ScrappyContstants.clientSecretWaiter; audience = ScrappyContstants.clientAudienceWaiter; }break;
      default: {}break;
    }
    Map<String,dynamic> data = Map<String,dynamic>();
    data["client_id"] = clientId;
    data["client_secret"] = clientSecret;
    data["audience"] = audience;
    data["grant_type"] = "client_credentials";
    http.Response response = await NetworkService.post(url: _authUrl, body: jsonEncode(data));
    Map<String,dynamic> body = json.decode(response.body) as Map<String, dynamic>;
    return body["access_token"];
  }

}