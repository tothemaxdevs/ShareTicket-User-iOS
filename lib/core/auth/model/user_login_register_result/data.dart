import 'package:json_annotation/json_annotation.dart';

import 'token.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Token? token;

  Data({this.token});

  @override
  String toString() => 'Data(token: $token)';

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  Data copyWith({
    Token? token,
  }) {
    return Data(
      token: token ?? this.token,
    );
  }
}
