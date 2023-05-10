import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'token_type')
  String? tokenType;
  @JsonKey(name: 'expires_in')
  int? expiresIn;

  Token({this.accessToken, this.tokenType, this.expiresIn});

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn)';
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  Token copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
  }) {
    return Token(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}
