part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {
  const AccountEvent();
}

class GetAccountEvent extends AccountEvent {}

class GetUserAccountListEvent extends AccountEvent {}

class ChangePasswordEvent extends AccountEvent {
  Map<String, dynamic>? params = {};
  ChangePasswordEvent({this.params});
}

class UpdatePhoneEvent extends AccountEvent {
  Map<String, dynamic>? params = {};
  UpdatePhoneEvent({this.params});
}

class PostDeleteUserEvent extends AccountEvent {
  Map<String, dynamic>? body;
  PostDeleteUserEvent({this.body});
}
