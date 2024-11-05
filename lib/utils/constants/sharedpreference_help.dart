
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
static late  SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
Future<void> saveToken(String?token) async {
    await _sharedPreferences?.setString(PrefKeys.token, token ?? "");
  }
Future<void> saveMpinStatus(String? mpinStatus) async {
    await _sharedPreferences?.setString(PrefKeys.mpinStatus, mpinStatus ?? "");
  }
  Future<void> saveUserID(String? authToken) async {
    await _sharedPreferences?.setString(PrefKeys.user_id, authToken ?? "");
  }
Future<void> saveSiteurl(String? siturl) async {
    await _sharedPreferences?.setString(PrefKeys.siturl, siturl ?? "");
  }
   Future<void> saveLogo(String? logo) async {
    await _sharedPreferences?.setString(PrefKeys.logo, logo ?? "");
  }
Future<void> savePhoto(String? photo) async {
    await _sharedPreferences?.setString(PrefKeys.photo, photo ?? "");
  }
Future<void> saveVersion(String? version) async {
    await _sharedPreferences?.setString(PrefKeys.version, version ?? "");
  }
Future<void> saveLangCode(String? langCode) async {
    await _sharedPreferences?.setString(PrefKeys.langCode, langCode ?? "");
  }
Future<void> saveHomeLogo(String? homeLogo) async {
    await _sharedPreferences?.setString(PrefKeys.homeLogo, homeLogo ?? "");
  }
Future<void> saveDelContent(String? delcontent) async {
    await _sharedPreferences?.setString(PrefKeys.delcontent, delcontent ?? "");
  }
Future<void> saveDelReq(String? delReq) async {
    await _sharedPreferences?.setString(PrefKeys.delReq,delReq?? "");
  }

  String get getToken {
    return _sharedPreferences?.getString(PrefKeys.token) ?? '';
  }
  String get getUserId {
    return _sharedPreferences?.getString(PrefKeys.user_id) ?? '';
  }
   String get getSiturl {
    return _sharedPreferences?.getString(PrefKeys.siturl) ?? '';
  }
   String get getLogo {
    return _sharedPreferences?.getString(PrefKeys.logo) ?? '';
  }
  String get getPhoto {
    return _sharedPreferences?.getString(PrefKeys.photo) ?? '';
  }
String get getVersion{
    return _sharedPreferences?.getString(PrefKeys.version) ?? '';
  }
String get getMpinStatus{
    return _sharedPreferences?.getString(PrefKeys.mpinStatus) ?? '';
  }
  String get getLanguageCode{
    return _sharedPreferences?.getString(PrefKeys.langCode) ?? '';
  }
String get getHomeLogo{
    return _sharedPreferences?.getString(PrefKeys.homeLogo) ?? '';
  }
  String get getDelContent{
    return _sharedPreferences?.getString(PrefKeys.delcontent) ?? '';

  }
  String get getDelReq{
    return _sharedPreferences?.getString(PrefKeys.delReq) ?? '';

  }
}

mixin PrefKeys {
  static const String token="token";
  static const String user_id = "userID";
  static const String siturl='siturl';
  static const String logo='logo';
  static const String version='version';
   static const String mpinStatus='mpinStatus';
   static const String langCode='langCode';
   static const String homeLogo='homeLogo';
   static const String photo='photo';
   static const String delcontent='delContent';
   static const String delReq='delReq';
}