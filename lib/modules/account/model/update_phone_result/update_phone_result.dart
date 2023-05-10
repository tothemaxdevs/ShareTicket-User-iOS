import 'package:json_annotation/json_annotation.dart';

part 'update_phone_result.g.dart';

@JsonSerializable()
class UpdatePhoneResult {
  int? code;
  String? message;

  UpdatePhoneResult({this.code, this.message});

  @override
  String toString() {
    return 'UpdatePhoneResult(code: $code, message: $message)';
  }

  factory UpdatePhoneResult.fromJson(Map<String, dynamic> json) {
    return _$UpdatePhoneResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdatePhoneResultToJson(this);

  UpdatePhoneResult copyWith({
    int? code,
    String? message,
  }) {
    return UpdatePhoneResult(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
