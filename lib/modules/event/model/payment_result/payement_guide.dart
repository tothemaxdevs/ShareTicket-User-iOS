import 'package:json_annotation/json_annotation.dart';

part 'payement_guide.g.dart';

@JsonSerializable()
class PayementGuide {
  String? id;
  @JsonKey(name: 'bank_name')
  String? bankName;
  @JsonKey(name: 'bank_code')
  String? bankCode;
  String? icon;
  @JsonKey(name: 'payment_atm')
  String? paymentAtm;
  @JsonKey(name: 'payment_mbanking')
  String? paymentMbanking;
  @JsonKey(name: 'payment_ibanking')
  String? paymentIbanking;

  PayementGuide({
    this.id,
    this.bankName,
    this.bankCode,
    this.icon,
    this.paymentAtm,
    this.paymentMbanking,
    this.paymentIbanking,
  });

  @override
  String toString() {
    return 'PayementGuide(id: $id, bankName: $bankName, bankCode: $bankCode, icon: $icon, paymentAtm: $paymentAtm, paymentMbanking: $paymentMbanking, paymentIbanking: $paymentIbanking)';
  }

  factory PayementGuide.fromJson(Map<String, dynamic> json) {
    return _$PayementGuideFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PayementGuideToJson(this);

  PayementGuide copyWith({
    String? id,
    String? bankName,
    String? bankCode,
    String? icon,
    String? paymentAtm,
    String? paymentMbanking,
    String? paymentIbanking,
  }) {
    return PayementGuide(
      id: id ?? this.id,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      icon: icon ?? this.icon,
      paymentAtm: paymentAtm ?? this.paymentAtm,
      paymentMbanking: paymentMbanking ?? this.paymentMbanking,
      paymentIbanking: paymentIbanking ?? this.paymentIbanking,
    );
  }
}
