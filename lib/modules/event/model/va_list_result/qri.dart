import 'package:json_annotation/json_annotation.dart';

part 'qri.g.dart';

@JsonSerializable()
class Qri {
  String? name;
  String? code;
  @JsonKey(name: 'is_activated')
  bool? isActivated;
  @JsonKey(name: 'status_payment')
  String? statusPayment;
  String? logo;

  Qri({
    this.name,
    this.code,
    this.isActivated,
    this.statusPayment,
    this.logo,
  });

  @override
  String toString() {
    return 'Qri(name: $name, code: $code, isActivated: $isActivated, statusPayment: $statusPayment, logo: $logo)';
  }

  factory Qri.fromJson(Map<String, dynamic> json) => _$QriFromJson(json);

  Map<String, dynamic> toJson() => _$QriToJson(this);

  Qri copyWith({
    String? name,
    String? code,
    bool? isActivated,
    String? statusPayment,
    String? logo,
  }) {
    return Qri(
      name: name ?? this.name,
      code: code ?? this.code,
      isActivated: isActivated ?? this.isActivated,
      statusPayment: statusPayment ?? this.statusPayment,
      logo: logo ?? this.logo,
    );
  }
}
