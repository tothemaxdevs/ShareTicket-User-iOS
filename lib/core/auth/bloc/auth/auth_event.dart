part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  Map<String, dynamic>? params;
  LoginEvent(this.params);
}

class LoginSocialEvent extends AuthEvent {
  Map<String, dynamic>? params;
  LoginSocialEvent(this.params);
}

class RegisterEvent extends AuthEvent {
  Map<String, dynamic>? params;
  RegisterEvent(this.params);
}

class OtpVerificationEvent extends AuthEvent {
  Map<String, dynamic>? params;
  OtpVerificationEvent(this.params);
}

class LoginBasicEvent extends AuthEvent {
  Map<String, dynamic>? params;
  LoginBasicEvent(this.params);
}

class RegisterBasicEvent extends AuthEvent {
  Map<String, dynamic>? params;
  RegisterBasicEvent(this.params);
}

class ResetPasswordEvent extends AuthEvent {
  Map<String, dynamic>? params = {};
  ResetPasswordEvent({this.params});
}
