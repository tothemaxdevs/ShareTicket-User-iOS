import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String kInitBoarding = 'initial_boarding';
  static const String kAccesToken = "access_token";
  static const String kIsLogin = "isLogin";
  static const String kUserId = "userId";
  static const String userInfo = "userInfo";
  static const String tokenFcm = "tokenFcm";
  static const String profileId = "profileID";
  static const String kUserName = "userName";
  static const String kUserEmail = "userEmail";
  static const String kUserPhone = "userPhone";
  static const String kImage = "image";
  static const String kProvince = "province";
  static const String kCity = "city";
  static const String kCityProvince = "cityProvince";
  static const String kLanguage = "language";

  static Future<bool> getIsOnBoarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kInitBoarding) ?? true;
  }

  static Future<bool> setIsOnBoarding(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(kInitBoarding, value);
  }

  static Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kAccesToken) ?? '';
  }

  static Future<bool> setAccessToken(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kAccesToken, value ?? '');
  }

  static Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kLanguage) ?? '';
  }

  static Future<bool> setLanguage(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kLanguage, value ?? '');
  }

  static Future<String> getTokenFCM() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(tokenFcm) ?? '';
  }

  static Future<bool> setTokenFCM(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(tokenFcm, value);
  }

  static Future<String> getUserid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kUserId) ?? '';
  }

  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kUserName) ?? '';
  }

  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kUserId, value);
  }

  static Future<bool> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(kIsLogin) ?? false;
  }

  static Future<bool> setIsLogin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(kIsLogin, value);
  }

  static Future<bool> setprofileID(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(profileId, value!);
  }

  static Future<String> getprofileId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(profileId) ?? '';
  }

  static Future<bool> setCity(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kCity, value!);
  }

  static Future<String> getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kCity) ?? '';
  }

  static Future<bool> setProvince(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kProvince, value!);
  }

  static Future<String> getProvince() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kProvince) ?? '';
  }

  static Future<bool> setCityProvince(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kCityProvince, value!);
  }

  static Future<String> getCityProvince() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kCityProvince) ?? '';
  }

  static Future<bool> setUserPhone(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kUserPhone, value!);
  }

  static Future<bool> setUserName(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kUserName, value!);
  }

  static Future<bool> setUserEmail(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(kUserEmail, value!);
  }

  static Future<String> getImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(kImage) ?? '';
  }

  static removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(kAccesToken);
    prefs.remove(kIsLogin);
    prefs.remove(kUserId);
    prefs.remove(userInfo);
    prefs.remove(profileId);
    prefs.remove(kUserName);
    prefs.remove(kUserPhone);
    prefs.remove(kUserEmail);
    prefs.remove(kCity);
    prefs.remove(kProvince);
    prefs.remove(kCityProvince);
    prefs.remove(kLanguage);
  }
}
