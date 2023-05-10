import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'account_data_result.g.dart';

@JsonSerializable()
class AccountDataResult {
  User? user;

  AccountDataResult({this.user});

  @override
  String toString() => 'AccountDataResult(user: $user)';

  factory AccountDataResult.fromJson(Map<String, dynamic> json) {
    return _$AccountDataResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AccountDataResultToJson(this);
}
