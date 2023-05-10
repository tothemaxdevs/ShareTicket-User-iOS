import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? fullname;
  String? phone;
  String? email;
  dynamic status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'user_address')
  dynamic userAddress;

  User({
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.status,
    this.createdAt,
    this.userAddress,
  });

  @override
  String toString() {
    return 'User(id: $id, fullname: $fullname, phone: $phone, email: $email, status: $status, createdAt: $createdAt, userAddress: $userAddress)';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
