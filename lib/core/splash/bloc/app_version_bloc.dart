import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shareticket/core/splash/api/app_version_api_repository.dart';
import 'package:shareticket/core/splash/app_version/app_version.dart';

part 'app_version_event.dart';
part 'app_version_state.dart';

class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
  final AppVersionApiRepository _apiRepository = AppVersionApiRepository();

  AppVersionBloc() : super(AppVersionInitialState()) {
    on<GetAppVersionFromApiEvent>(getAppVersionFromApiEventHandler);
    on<GetAppVersionFromInfoEvent>(getAppVersionFromInfoEventHandler);
  }

  getAppVersionFromApiEventHandler(
      GetAppVersionFromApiEvent event, Emitter<AppVersionState> emit) async {
    // if (network.isOnline) {
    try {
      Response response = await _apiRepository.getAppVersion(event.params);
      var appVersion = response.data['data']['app_version'];
      log('ini dari bloc $appVersion');
      emit(AppVersionLoadedState(AppVersion.fromJson(appVersion)));
    } catch (e) {
      emit(AppVersionErrorState(e.toString()));
    }
    // } else {
    //   emit(AppVersionNoConnectionState());
    // }
  }

  getAppVersionFromInfoEventHandler(
      GetAppVersionFromInfoEvent event, Emitter<AppVersionState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    if (appVersion != null) {
      emit(AppVersionInfoLoadedState(appVersion));
    } else {
      emit(AppVersionInfoEmptyState());
    }
  }
}
