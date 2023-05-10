import 'package:json_annotation/json_annotation.dart';

part 'virtual_account.g.dart';

@JsonSerializable()
class VirtualAccount {
  String? name;
  String? code;
  @JsonKey(name: 'is_activated')
  bool? isActivated;
  @JsonKey(name: 'status_payment')
  String? statusPayment;
  String? logo;

  VirtualAccount({
    this.name,
    this.code,
    this.isActivated,
    this.statusPayment,
    this.logo,
  });

  @override
  String toString() {
    return 'VirtualAccount(name: $name, code: $code, isActivated: $isActivated, statusPayment: $statusPayment, logo: $logo)';
  }

  factory VirtualAccount.fromJson(Map<String, dynamic> json) {
    return _$VirtualAccountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VirtualAccountToJson(this);

  VirtualAccount copyWith({
    String? name,
    String? code,
    bool? isActivated,
    String? statusPayment,
    String? logo,
  }) {
    return VirtualAccount(
      name: name ?? this.name,
      code: code ?? this.code,
      isActivated: isActivated ?? this.isActivated,
      statusPayment: statusPayment ?? this.statusPayment,
      logo: logo ?? this.logo,
    );
  }
}
