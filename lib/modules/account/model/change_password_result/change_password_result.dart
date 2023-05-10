import 'package:json_annotation/json_annotation.dart';

part 'change_password_result.g.dart';

@JsonSerializable()
class ChangePasswordResult {
  String? message;

  ChangePasswordResult({this.message});

  @override
  String toString() => 'ChangePasswordResult(message: $message)';

  factory ChangePasswordResult.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangePasswordResultToJson(this);

  ChangePasswordResult copyWith({
    String? message,
  }) {
    return ChangePasswordResult(
      message: message ?? this.message,
    );
  }
}
