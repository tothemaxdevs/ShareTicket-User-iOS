import 'package:json_annotation/json_annotation.dart';

import 'qri.dart';
import 'virtual_account.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  @JsonKey(name: 'virtual_account')
  List<VirtualAccount>? virtualAccount;
  List<VirtualAccount>? qris;

  Payment({this.virtualAccount, this.qris});

  @override
  String toString() {
    return 'Payment(virtualAccount: $virtualAccount, qris: $qris)';
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return _$PaymentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  Payment copyWith({
    List<VirtualAccount>? virtualAccount,
    List<VirtualAccount>? qris,
  }) {
    return Payment(
      virtualAccount: virtualAccount ?? this.virtualAccount,
      qris: qris ?? this.qris,
    );
  }
}
