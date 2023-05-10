import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shareticket/utils/environment/environment.dart';
import 'package:shareticket/utils/services/api_service.dart';

class HomeApi {
  final ApiService _apiService;

  HomeApi() : _apiService = ApiService();
  static const String api = Environment.endpointApi;
  static const String category = 'api/event-categories';
  static const String eventGroup = 'api/event-groups';
  static const String event = 'api/event';
  static const String content = 'api/content/contents';
  static const String city = 'api/reference/cities';
  static const String province = 'api/reference/provinces';

  Future<Response> getCategory({param}) async {
    Response response =
        await _apiService.get('$api$category', queryParam: param);
    return response;
  }

  Future<Response> getEventGroup({param}) async {
    Response response =
        await _apiService.get('$api$eventGroup', queryParam: param);
    return response;
  }

  Future<Response> getEvent({param}) async {
    Response response = await _apiService.get('$api$event', queryParam: param);
    return response;
  }

  Future<Response> getContent({param}) async {
    Response response =
        await _apiService.get('$api$content', queryParam: param);
    return response;
  }

  Future<Response> getCity({param}) async {
    Response response = await _apiService.get('$api$city', queryParam: param);
    return response;
  }

  Future<Response> getProvince({param}) async {
    Response response =
        await _apiService.get('$api$province', queryParam: param);
    return response;
  }
}
