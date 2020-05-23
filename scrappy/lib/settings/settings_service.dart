import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scrappy/models/settings/settings_model.dart';

import '../auth/auth_service.dart';
import '../network/network_service.dart';
import '../scrappy_const.dart';


class SettingsService{
  static SettingsModel data;

  static Future<SettingsModel> getData() async {
    http.Response response = await NetworkService.get(
        context: ScrappyContstants.networkContextWaiter,
        function: ScrappyContstants.networkFunctionSettings);
    //print(response.body);
    dynamic js = json.decode(response.body);
    SettingsService.data = SettingsModel.fromJson(js[0] as Map<String, dynamic>);
    return SettingsService.data;
  }

  static Future<SettingsModel> sendData(SettingsModel settings) async {
    SettingsService.data = settings;
    http.Response response = await NetworkService.patch(
        context: AuthService.currentUser.role,
        function: ScrappyContstants.networkFunctionSettings,
        params: SettingsService.data.id,
        body: json.encode(SettingsService.data.toJson())
    );
    if(response.statusCode == 200){
      print(['responseStatus:',response.statusCode, response.body]);
      return SettingsModel.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
    }
    return null;
  }
}