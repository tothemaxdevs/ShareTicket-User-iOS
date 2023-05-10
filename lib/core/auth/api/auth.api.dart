import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shareticket/utils/environment/environment.dart';
import 'package:shareticket/utils/services/api_service.dart';

class AuthApi {
  final ApiService _apiService;

  AuthApi() : _apiService = ApiService();
  static const String api = Environment.endpointApi;

  static const String authLogin = 'api/login';
  static const String authSocial = 'api/sign-social';
  static const String authRegister = 'api/register';
  static const String authOtp = 'api/verification-otp';
  static const String saveFiles = 'api/upload';

  static const String authLoginBasic = 'api/login-basic';
  static const String authRegisterBasic = 'api/register-basic';
  static const String forgotPassword = 'api/forgot-password';

  Future<Response> login({body}) async {
    Response response =
        await _apiService.post('$api$authLogin', body, withToken: false);
    return response;
  }

  Future<Response> register({body}) async {
    Response response =
        await _apiService.post('$api$authRegister', body, withToken: false);
    return response;
  }

  Future<Response> loginBasic({body}) async {
    Response response =
        await _apiService.post('$api$authLoginBasic', body, withToken: false);
    return response;
  }

  Future<Response> registerBasic({body}) async {
    Response response = await _apiService.post('$api$authRegisterBasic', body,
        withToken: false);
    return response;
  }

  Future<Response> signSocial({body}) async {
    Response response =
        await _apiService.post('$api$authSocial', body, withToken: false);
    return response;
  }

  Future<Response> otpVerification({body}) async {
    Response response =
        await _apiService.post('$api$authOtp', body, withToken: false);
    return response;
  }

  Future<Response> saveFile({body}) async {
    Response response = await _apiService.post('$api$saveFiles', body);
    return response;
  }

  Future<Response> postForgotPassword({body}) async {
    Response response = await _apiService.post('$api$forgotPassword', body);
    return response;
  }

  // Future<Response> createPersonalChat({body}) async {
  //   Response response = await _apiService.post('$api$authLogin', body);
  //   return response;
  // }

  // Future<ResponseData> getNotification() async {
  //   Response response = await _apiService.get('$api$authLogin');
  //   return ResponseData.fromJson(response.data);
  // }

  // Future<Response> deleteProductByid({id}) async {
  //   Response response = await _apiService.delete('$api$authLogin/$id');
  //   return response;
  // }
}
