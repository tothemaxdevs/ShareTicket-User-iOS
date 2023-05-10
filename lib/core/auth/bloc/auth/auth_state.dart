part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoginBlocInitial extends AuthState {}

class PostLoginLoadingState extends AuthState {
  PostLoginLoadingState();
}

class PostLoginLoadedState extends AuthState {
  final LoginResult? loginResult;
  //  userId, userName, userEmail, userPhone, userProvider;

  PostLoginLoadedState({this.loginResult
      // required this.token,
      });
}

class PostLoginFailedState extends AuthState {
  final Response response;
  PostLoginFailedState(this.response);
}

class PostLoginErrorState extends AuthState {
  final String message;
  PostLoginErrorState(this.message);
}

class PostLoginSocialLoadingState extends AuthState {
  PostLoginSocialLoadingState();
}

class PostLoginSocialLoadedState extends AuthState {
  final String? accessToken;
  final Response? response;
  PostLoginSocialLoadedState({
    this.response,
    this.accessToken,
  });
}

class PostLoginSocialFailedState extends AuthState {
  final Response response;
  PostLoginSocialFailedState(this.response);
}

class PostLoginSocialErrorState extends AuthState {
  final String message;
  PostLoginSocialErrorState(this.message);
}

//
class PostRegisterLoadingState extends AuthState {
  PostRegisterLoadingState();
}

class PostRegisterLoadedState extends AuthState {
  final LoginResult loginResult;
  PostRegisterLoadedState(this.loginResult);
}

class PostRegisterFailedState extends AuthState {
  final Response response;
  PostRegisterFailedState(this.response);
}

class PostRegisterErrorState extends AuthState {
  final String message;
  PostRegisterErrorState(this.message);
}

//
class PostLoginBasicLoadingState extends AuthState {
  PostLoginBasicLoadingState();
}

class PostLoginBasicLoadedState extends AuthState {
  final UserLoginRegisterResult? data;
  //  userId, userName, userEmail, userPhone, userProvider;

  PostLoginBasicLoadedState({this.data
      // required this.token,
      });
}

class PostLoginBasicFailedState extends AuthState {
  final Response response;
  PostLoginBasicFailedState(this.response);
}

class PostLoginBasicErrorState extends AuthState {
  final String message;
  PostLoginBasicErrorState(this.message);
}

class PostRegisterBasicLoadingState extends AuthState {
  PostRegisterBasicLoadingState();
}

class PostRegisterBasicLoadedState extends AuthState {
  final UserLoginRegisterResult data;
  PostRegisterBasicLoadedState(this.data);
}

class PostRegisterBasicFailedState extends AuthState {
  final Response response;
  PostRegisterBasicFailedState(this.response);
}

class PostRegisterBasicErrorState extends AuthState {
  final String message;
  PostRegisterBasicErrorState(this.message);
}

class PostOtpLoadingState extends AuthState {
  PostOtpLoadingState();
}

class PostOtpLoadedState extends AuthState {
  final String token;
  PostOtpLoadedState(this.token);
}

class PostOtpFailedState extends AuthState {
  final Response response;
  PostOtpFailedState(this.response);
}

class PostOtpErrorState extends AuthState {
  final String message;
  PostOtpErrorState(this.message);
}

class PostResetPasswordLoadingState extends AuthState {
  PostResetPasswordLoadingState();
}

class PostResetPasswordLoadedState extends AuthState {
  final Response data;
  PostResetPasswordLoadedState(this.data);
}

class PostResetPasswordErrorState extends AuthState {
  final String message;
  PostResetPasswordErrorState(this.message);
}

class PostResetPasswordFailedState extends AuthState {
  final Response data;
  PostResetPasswordFailedState(this.data);
}
