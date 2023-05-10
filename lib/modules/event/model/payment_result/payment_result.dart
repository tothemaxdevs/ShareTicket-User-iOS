import 'package:json_annotation/json_annotation.dart';

import 'payement_guide.dart';
import 'virtual_account.dart';
import 'qris.dart';

part 'payment_result.g.dart';

@JsonSerializable()
class PaymentResult {
  @JsonKey(name: 'payement_guide')
  PayementGuide? payementGuide;
  @JsonKey(name: 'virtual_account')
  VirtualAccount? virtualAccount;
  Qris? qris;

  PaymentResult({this.payementGuide, this.virtualAccount, this.qris});

  @override
  String toString() {
    return 'PaymentResult(payementGuide: $payementGuide, virtualAccount: $virtualAccount, qris: $qris)';
  }

  factory PaymentResult.fromJson(Map<String, dynamic> json) {
    return _$PaymentResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentResultToJson(this);

  PaymentResult copyWith({
    PayementGuide? payementGuide,
    VirtualAccount? virtualAccount,
    Qris? qris,
  }) {
    return PaymentResult(
      payementGuide: payementGuide ?? this.payementGuide,
      virtualAccount: virtualAccount ?? this.virtualAccount,
      qris: qris ?? this.qris,
    );
  }
}
