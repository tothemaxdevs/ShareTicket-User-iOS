import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/core/auth/screen/login_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/services/logging_interceptor.dart';
import 'package:shareticket/utils/services/navigator_global.dart';
import 'package:shareticket/utils/services/navigator_key.dart';
import 'package:shareticket/utils/state/error_state.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> getNewPass(url, {queryParam, page, withToken = true}) async {
    _dio.interceptors.add(LoggingInterceptor());
    String accessToken = await LocalStorageService.getAccessToken();

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      _dio.options.headers['Accept'] = 'application/json';
    }

    if (page != null) {
      queryParam['page'] = page;
    }

    print('QUERY $queryParam');

    try {
      Response response = await _dio.get(url, queryParameters: queryParam);
      print('RESPONSE $response');
      return response;
    } on DioError catch (error) {
      print('ERROR ${error.toString()}');
      return error.response!.data;
    }
  }

  Future<Response> getNew(url, {queryParam, page, withToken = true}) async {
    _dio.interceptors.add(LoggingInterceptor());
    String accessToken = await LocalStorageService.getAccessToken();

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      _dio.options.headers['Accept'] = 'application/json';
    }

    // if (page != null) {
    //   queryParam['page'] = page;
    // }

    print('QUERY $queryParam');

    try {
      Response response = await _dio.get(url, queryParameters: queryParam);
      log('RESPONSE $response');
      return response;
    } on DioError catch (error) {
      print('ERROR ${error.stackTrace.toString()}');
      return error.response!.data;
    }
  }

  Future<Response> get(url, {queryParam, page, withToken = true}) async {
    _dio.interceptors.add(LoggingInterceptor());
    String accessToken = await LocalStorageService.getAccessToken();

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    _dio.options.headers['Accept'] = 'application/json';
    // log('BEARER $accessToken');
    // if (page != null) {
    //   queryParam['page'] = page;
    // }

    // print('QUERY $queryParam');

    try {
      Response response = await _dio.get(url, queryParameters: queryParam);
      // print('RESPONSE $response');
      return response;
    } on DioError catch (error) {
      // print('ERROR ${error.stackTrace.toString()}');
      log('---------------------');
      log('ERROR DISINI GAES');
      log(error.message.toString());
      log(error.response.toString());
      // log(error.response!.data['messages'].toString());
      // log(error.response!.data['error_code'].toString());
      log('---------------------');

      if (error.response!.statusCode == 401) {
        log('HERE');
        GlobalNavigator.showAlertDialog('Any message', onClick: () {
          LocalStorageService.removeValues();
          // _googleSignIn.disconnect();
          Navigator.pushNamedAndRemoveUntil(
              navigatorKey.currentContext!, LoginScreen.path, (route) => false);
        });
      }
      return error.response!.data;
    }
  }

  Future<Response> getMap(url, {query}) async {
    try {
      query['key'] = 'AIzaSyCbo7jjDTdFANGzFcWCc9MwXsmID-OXgiQ';
      print(query);
      Response response = await _dio.get(url, queryParameters: query);
      print(response);
      return response;
    } on DioError catch (error) {
      print('ERROR ${error.stackTrace.toString()}');
      return error.response!.data;
    }
  }

  Future<Response> post(url, body, {bool withToken = true}) async {
    String accessToken = await LocalStorageService.getAccessToken();
    _dio.interceptors.add(LoggingInterceptor());

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    _dio.options.headers['Accept'] = 'application/json';
    log('REQUEST BODY $body');
    var formBody = FormData.fromMap(body);

    try {
      Response response = await _dio.post(url, data: formBody);
      return response;
    } on DioError catch (error) {
      log('ERROR1 ${handleErrorDio(error).toString()}');

      // log('ERROR2 ${error.response.toString()}');
      return error.response!;
    }
  }

  Future<Response> delete(url, {bool withToken = true}) async {
    String accessToken = await LocalStorageService.getAccessToken();
    _dio.interceptors.add(LoggingInterceptor());
    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      _dio.options.headers['Accept'] = 'application/json';
    }
    Response response = await _dio.delete(url);
    return response;
  }

  Future<Response> postTes(url, body, {bool withToken = true}) async {
    String accessToken = await LocalStorageService.getAccessToken();
    _dio.interceptors.add(LoggingInterceptor());
    String username =
        'xnd_development_3FiM1cFcXx9oLzcrZMCcJzSf6x7U3yRTaT275XWP2zmlHyrmJKVFSGGuLyBxQ8BB';
    String password = '';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    if (withToken) {
      _dio.options.headers['Authorization'] = ' $basicAuth';
      _dio.options.headers['Accept'] = 'application/json';
    }

    print('REQUEST BODY $body');
    var formBody = FormData.fromMap(body);

    try {
      Response response = await _dio.post(url, data: formBody);
      return response;
    } on DioError catch (error) {
      print('ERROR ${handleErrorDio(error)}');
      print('ERROR ${error.response!.data}');
      return error.response!;
    }
  }

  Future<Response> postXendit(url, body, {bool withAuth = true}) async {
    // String accessToken = await LocalStorageService.getAccessToken();
    String username =
        'xnd_development_3FiM1cFcXx9oLzcrZMCcJzSf6x7U3yRTaT275XWP2zmlHyrmJKVFSGGuLyBxQ8BB';
    String password = '';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    if (withAuth) {
      _dio.options.headers['Authorization'] = basicAuth;
      _dio.options.headers['Accept'] = 'application/json';
    }

    // if (id != null) {
    //   url = '$url/$id';
    // }

    // if (page != null) {
    //   query['page'] = page;
    // }

    print('REQUEST BODY $body');
    var formBody = FormData.fromMap(body);

    try {
      Response response = await _dio.post(url, data: body);
      return response;
    } on DioError catch (error) {
      print('ERROR ${handleErrorDio(error)}');
      print('ERROR ${error.response!.data}');
      return error.response!;
    }
  }
}
