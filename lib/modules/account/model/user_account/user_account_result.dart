import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'user_account_result.g.dart';

@JsonSerializable()
class UserAccountResult {
  User? user;

  UserAccountResult({this.user});

  @override
  String toString() => 'UserAccountResult(user: $user)';

  factory UserAccountResult.fromJson(Map<String, dynamic> json) {
    return _$UserAccountResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserAccountResultToJson(this);

  UserAccountResult copyWith({
    User? user,
  }) {
    return UserAccountResult(
      user: user ?? this.user,
    );
  }
}
