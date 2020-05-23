import 'package:flutter/cupertino.dart';
import 'package:scrappy/models/license/license.dart';
import 'package:scrappy/scrappy_const.dart';
import 'package:scrappy/settings/settings_service.dart';

import '../scrappy_const.dart';

enum AccessLevel {
  public,
  waiter,
  cashier,
}

class AuthIdentity{
  final AccessLevel accessLevel;
  String role;
  String username;
  AuthIdentity({@required this.accessLevel, @required this.username}){
    switch(this.accessLevel){
      case AccessLevel.public:
        this.role = ScrappyContstants.networkContextGuest;
        break;
      case AccessLevel.waiter:
        this.role = ScrappyContstants.networkContextWaiter;
        break;
      case AccessLevel.cashier:
        this.role = ScrappyContstants.networkContextCashier;
        break;
    }
  }
}

class AuthService{
  static AuthIdentity currentUser;
  static License currentLicense;

  static bool isAuthorized(AccessLevel requiredLevel){
    if(AuthService.currentUser != null){
      //print(['required', requiredLevel.index,  'current', AuthService.currentUser.accessLevel.index]);
      return AuthService.currentUser.accessLevel.index >= requiredLevel.index;
    }
    return false;
  }

  static Future<String> getAuthUserName() async {
    //todo recupero da server
    String adminUsername = SettingsService.data.adminNickname ?? +'admin';
    return adminUsername;
  }

  static Future<void> setAuthUserName(String newValue) async {
    //mmmmmmmmmmmmmmmmmmmmmmmm fa un pò cagare.... non dovrebbe esse in locale
    SettingsService.data.adminNickname = newValue;

    //se posso fare questa operazione ero già admin, forse voglio rimanerlo?!
    await Storage<String>(ScrappyContstants.boxUsername).unshiftAsync(newValue);
    await SettingsService.sendData(SettingsService.data);
  }

  static Future<void> init() async {
    AccessLevel ac = AccessLevel.public;
    String username = await Storage<String>(ScrappyContstants.boxUsername).firstAsync() ?? '';
    String adminUserName = await AuthService.getAuthUserName();
    if(username != '')
      ac = AccessLevel.waiter;
    if(username == adminUserName)
      ac = AccessLevel.cashier;
    AuthService.currentUser = AuthIdentity(accessLevel: ac, username: username);
  }

  static String getFirstRouteByRole() {
    switch(AuthService.currentUser.accessLevel){
      case AccessLevel.public:
      case AccessLevel.waiter: return MyCatalog.routeName;
      case AccessLevel.cashier: return HomePage.routeName;
    }
  }

}