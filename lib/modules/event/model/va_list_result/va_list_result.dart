import 'package:json_annotation/json_annotation.dart';

import 'payment.dart';

part 'va_list_result.g.dart';

@JsonSerializable()
class VaListResult {
  Payment? payment;

  VaListResult({this.payment});

  @override
  String toString() => 'VaListResult(psyment: $payment)';

  factory VaListResult.fromJson(Map<String, dynamic> json) {
    return _$VaListResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VaListResultToJson(this);

  VaListResult copyWith({
    Payment? payment,
  }) {
    return VaListResult(
      payment: payment ?? this.payment,
    );
  }
}
