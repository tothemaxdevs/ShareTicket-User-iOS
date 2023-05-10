import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shareticket/utils/environment/environment.dart';
import 'package:shareticket/utils/services/api_service.dart';

class AccountApi {
  final ApiService _apiService;

  AccountApi() : _apiService = ApiService();
  static const String api = Environment.endpointApi;

  static const String authMe = 'api/me';
  static const String user = 'users';
  static const String changePassword = 'api/change-password';
  static const String updatePhone = 'api/update-phone';

  Future<Response> getMe() async {
    Response response = await _apiService.get('$api$authMe');
    return response;
  }

  Future<Response> getUserList() async {
    Response response = await _apiService.get('$api$user');
    return response;
  }

  Future<Response> deleteUser({id}) async {
    Response response = await _apiService.delete('$api$user/$id');
    return response;
  }

  Future<Response> postChangePassword({body}) async {
    Response response = await _apiService.post('$api$changePassword', body);
    return response;
  }

  Future<Response> postUpdatePhone({body}) async {
    Response response = await _apiService.post('$api$updatePhone', body);
    return response;
  }
}
