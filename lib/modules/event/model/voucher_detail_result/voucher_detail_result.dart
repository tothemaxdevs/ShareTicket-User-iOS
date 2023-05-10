import 'package:json_annotation/json_annotation.dart';

import 'user.dart';
import 'voucher.dart';

part 'voucher_detail_result.g.dart';

@JsonSerializable()
class VoucherDetailResult {
  Voucher? voucher;
  User? user;

  VoucherDetailResult({this.voucher, this.user});

  @override
  String toString() => 'VoucherDetailResult(voucher: $voucher, user: $user)';

  factory VoucherDetailResult.fromJson(Map<String, dynamic> json) {
    return _$VoucherDetailResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VoucherDetailResultToJson(this);

  VoucherDetailResult copyWith({
    Voucher? voucher,
    User? user,
  }) {
    return VoucherDetailResult(
      voucher: voucher ?? this.voucher,
      user: user ?? this.user,
    );
  }
}
