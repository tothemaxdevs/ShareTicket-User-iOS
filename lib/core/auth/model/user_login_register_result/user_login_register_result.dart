import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'user_login_register_result.g.dart';

@JsonSerializable()
class UserLoginRegisterResult {
  bool? success;
  Data? data;

  UserLoginRegisterResult({this.success, this.data});

  @override
  String toString() {
    return 'UserLoginRegisterResult(success: $success, data: $data)';
  }

  factory UserLoginRegisterResult.fromJson(Map<String, dynamic> json) {
    return _$UserLoginRegisterResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserLoginRegisterResultToJson(this);

  UserLoginRegisterResult copyWith({
    bool? success,
    Data? data,
  }) {
    return UserLoginRegisterResult(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }
}
