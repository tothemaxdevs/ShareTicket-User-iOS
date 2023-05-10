import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? fullname;
  String? email;
  String? phone;
  @JsonKey(name: 'is_used')
  int? isUsed;

  User({this.id, this.fullname, this.email, this.phone, this.isUsed});

  @override
  String toString() {
    return 'User(id: $id, fullname: $fullname, email: $email, phone: $phone, isUsed: $isUsed)';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? fullname,
    String? email,
    String? phone,
    int? isUsed,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}
