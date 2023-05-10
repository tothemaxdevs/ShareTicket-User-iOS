import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'user_account_list_result.g.dart';

@JsonSerializable()
class UserAccountListResult {
  List<User>? users;

  UserAccountListResult({this.users});

  @override
  String toString() => 'UserAccountListResult(users: $users)';

  factory UserAccountListResult.fromJson(Map<String, dynamic> json) {
    return _$UserAccountListResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserAccountListResultToJson(this);

  UserAccountListResult copyWith({
    List<User>? users,
  }) {
    return UserAccountListResult(
      users: users ?? this.users,
    );
  }
}
