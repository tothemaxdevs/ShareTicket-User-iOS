import 'package:json_annotation/json_annotation.dart';

part 'virtual_account.g.dart';

@JsonSerializable()
class VirtualAccount {
  String? id;
  @JsonKey(name: 'account_name')
  String? accountName;
  @JsonKey(name: 'bank_code')
  String? bankCode;
  @JsonKey(name: 'xendit_id')
  String? xenditId;
  @JsonKey(name: 'external_id')
  String? externalId;
  @JsonKey(name: 'expected_amount')
  String? expectedAmount;
  @JsonKey(name: 'account_number')
  String? accountNumber;
  @JsonKey(name: 'expiration_date')
  String? expirationDate;
  @JsonKey(name: 'order_id')
  String? orderId;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  String? createdBy;
  @JsonKey(name: 'updated_by')
  dynamic updatedBy;

  VirtualAccount({
    this.id,
    this.accountName,
    this.bankCode,
    this.xenditId,
    this.externalId,
    this.expectedAmount,
    this.accountNumber,
    this.expirationDate,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  @override
  String toString() {
    return 'VirtualAccount(id: $id, accountName: $accountName, bankCode: $bankCode, xenditId: $xenditId, externalId: $externalId, expectedAmount: $expectedAmount, accountNumber: $accountNumber, expirationDate: $expirationDate, orderId: $orderId, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  factory VirtualAccount.fromJson(Map<String, dynamic> json) {
    return _$VirtualAccountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VirtualAccountToJson(this);

  VirtualAccount copyWith({
    String? id,
    String? accountName,
    String? bankCode,
    String? xenditId,
    String? externalId,
    String? expectedAmount,
    String? accountNumber,
    String? expirationDate,
    String? orderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    dynamic updatedBy,
  }) {
    return VirtualAccount(
      id: id ?? this.id,
      accountName: accountName ?? this.accountName,
      bankCode: bankCode ?? this.bankCode,
      xenditId: xenditId ?? this.xenditId,
      externalId: externalId ?? this.externalId,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      accountNumber: accountNumber ?? this.accountNumber,
      expirationDate: expirationDate ?? this.expirationDate,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
