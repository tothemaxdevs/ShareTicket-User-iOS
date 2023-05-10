part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {
  const AccountEvent();
}

class GetAccountEvent extends AccountEvent {}

class GetUserAccountListEvent extends AccountEvent {}

class DeleteUserEvent extends AccountEvent {
  final String? userId;

  const DeleteUserEvent(this.userId);
}

class ChangePasswordEvent extends AccountEvent {
  Map<String, dynamic>? params = {};
  ChangePasswordEvent({this.params});
}

class UpdatePhoneEvent extends AccountEvent {
  Map<String, dynamic>? params = {};
  UpdatePhoneEvent({this.params});
}
