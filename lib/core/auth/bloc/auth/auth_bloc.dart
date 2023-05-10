import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shareticket/core/auth/api/auth.api.dart';
import 'package:shareticket/core/auth/model/login_model/login_model.dart';
import 'package:shareticket/core/auth/model/user_login_register_result/user_login_register_result.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi _api;
  AuthBloc({AuthApi? api})
      : _api = api ?? AuthApi(),
        super(LoginBlocInitial()) {
    on<LoginEvent>(_onLogin);
    on<LoginSocialEvent>(_onLoginSocial);
    on<RegisterEvent>(_onRegister);
    on<OtpVerificationEvent>(_onPostOtp);

    on<LoginBasicEvent>(_onLoginBasic);
    on<RegisterBasicEvent>(_onRegisterBasic);
    on<ResetPasswordEvent>(_onChangePassword);
  }

  _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(PostLoginLoadingState());

    try {
      Response response = await _api.login(body: event.params);
      log(response.data.toString());
      log('State Loaded');

      if (response.statusCode == 200) {
        log('LOADED');
        return emit(
          PostLoginLoadedState(
            loginResult: LoginResult(
                otp: '${response.data['data']['otp']['otp']}',
                token: '${response.data['data']['otp']['token']}',
                data: '${response.data['data']['otp']['data']}',
                type: '${response.data['data']['otp']['type']}',
                remainingTime:
                    '${response.data['data']['otp']['remaining_time']}',
                id: '${response.data['data']['otp']['id']}'),

            // token: '${response.data['data']['token']['access_token']}',
            // userId: '${response.data['data']['user']['id']}',
            // userName: '${response.data['data']['user']['name']}',
            // userEmail: '${response.data['data']['user']['email']}',
            // userPhone: '${response.data['data']['user']['phone']}'.toString(),
            // userProvider: '${response.data['data']['user']['provider']}'
          ),
        );
      } else {
        log('failed state');
        return emit(PostLoginFailedState(response));
      }
    } on DioError catch (error) {
      emit(PostLoginErrorState(error.message));
      log('State Error');
    }
  }

  _onLoginSocial(LoginSocialEvent event, Emitter<AuthState> emit) async {
    emit(PostLoginSocialLoadingState());

    try {
      final response = await _api.signSocial(body: event.params);
      log(response.data.toString());
      log('State Loaded');

      if (response.statusCode == 200) {
        log('LOADED');
        return emit(
          PostLoginSocialLoadedState(
              response: response,
              accessToken: response.data['data']['token']['access_token']),
        );
      } else {
        log('failed state');
        return emit(PostLoginSocialFailedState(response));
      }
    } on DioError catch (error) {
      emit(PostLoginSocialErrorState(error.message));
      log('State Error');
    }
  }

  _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(PostRegisterLoadingState());

    try {
      Response response = await _api.register(body: event.params);
      log(response.data.toString());
      if (response.statusCode == 200) {
        log('LOADED');
        emit(
          PostRegisterLoadedState(
            LoginResult(
                otp: '${response.data['data']['otp']['otp']}',
                token: '${response.data['data']['otp']['token']}',
                data: '${response.data['data']['otp']['data']}',
                type: '${response.data['data']['otp']['type']}',
                remainingTime:
                    '${response.data['data']['otp']['remaining_time']}',
                id: '${response.data['data']['otp']['id']}'),
          ),
        );
      } else {
        log('FAILED');
        emit(
          PostRegisterFailedState(response),
        );
      }
    } on DioError catch (error) {
      emit(PostRegisterErrorState(error.message));
    }
  }

  _onPostOtp(OtpVerificationEvent event, Emitter<AuthState> emit) async {
    emit(PostOtpLoadingState());

    try {
      Response response = await _api.otpVerification(body: event.params);
      log(response.data.toString());
      if (response.statusCode == 200) {
        log('LOADED');
        emit(
          PostOtpLoadedState(
            '${response.data['data']['token']['access_token']}',
          ),
        );
      } else {
        log('FAILED');
        emit(
          PostOtpFailedState(response),
        );
      }
    } on DioError catch (error) {
      emit(PostOtpErrorState(error.message));
    }
  }

  _onLoginBasic(LoginBasicEvent event, Emitter<AuthState> emit) async {
    emit(PostLoginBasicLoadingState());

    try {
      Response response = await _api.loginBasic(body: event.params);
      log(response.data.toString());
      log('State Loaded');

      if (response.statusCode == 200) {
        UserLoginRegisterResult result =
            UserLoginRegisterResult.fromJson(response.data);
        return emit(
          PostLoginBasicLoadedState(data: result),
        );
      } else {
        log('failed state');
        return emit(PostLoginBasicFailedState(response));
      }
    } on DioError catch (error) {
      emit(PostLoginBasicErrorState(error.message));
      log('State Error');
    }
  }

  _onRegisterBasic(RegisterBasicEvent event, Emitter<AuthState> emit) async {
    emit(PostRegisterBasicLoadingState());

    try {
      Response response = await _api.registerBasic(body: event.params);
      log(response.data.toString());
      if (response.statusCode == 200) {
        log('LOADED');
        UserLoginRegisterResult result =
            UserLoginRegisterResult.fromJson(response.data);
        emit(
          PostRegisterBasicLoadedState(result),
        );
      } else {
        log('FAILED');
        emit(
          PostRegisterBasicFailedState(response),
        );
      }
    } on DioError catch (error) {
      emit(PostRegisterBasicErrorState(error.message));
    }
  }

  _onChangePassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(PostResetPasswordLoadingState());
    try {
      Response data = await _api.postForgotPassword(body: event.params);

      if (data.statusCode == 200) {
        log('loaded');
        emit(PostResetPasswordLoadedState(data));
      } else {
        log('Failed');
        emit(PostResetPasswordFailedState(data));
      }
    } on DioError catch (error) {
      emit(PostResetPasswordErrorState(error.message));
    }
  }
}
