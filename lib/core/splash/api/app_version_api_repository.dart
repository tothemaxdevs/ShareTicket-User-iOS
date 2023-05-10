import 'package:dio/dio.dart';
import 'package:shareticket/utils/environment/environment.dart';
import 'package:shareticket/utils/services/api_service.dart';
// import 'package:ordefo_customer/configs/ordefo_api.config.dart';
// import 'package:ordefo_customer/environments/environment.dart';

class AppVersionApiRepository {
  final ApiService _apiService;

  AppVersionApiRepository() : _apiService = ApiService();

  static const String appVersion = '${Environment.endpointApi}api/app-version';

  Future<Response> getAppVersion(params) async {
    Response response =
        await _apiService.getNew(appVersion, queryParam: params);
    return response;
  }
}
