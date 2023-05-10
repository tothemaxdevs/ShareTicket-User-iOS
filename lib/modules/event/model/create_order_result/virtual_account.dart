import 'package:json_annotation/json_annotation.dart';

part 'virtual_account.g.dart';

@JsonSerializable()
class VirtualAccount {
  String? id;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'virtual_account_id')
  String? virtualAccountId;
  @JsonKey(name: 'external_id')
  String? externalId;
  @JsonKey(name: 'owner_id')
  String? ownerId;
  String? name;
  @JsonKey(name: 'bank_code')
  String? bankCode;
  @JsonKey(name: 'merchant_code')
  String? merchantCode;
  @JsonKey(name: 'account_number')
  String? accountNumber;
  @JsonKey(name: 'expected_amount')
  String? expectedAmount;
  @JsonKey(name: 'expiration_date')
  DateTime? expirationDate;
  String? status;
  @JsonKey(name: 'status_payment')
  String? statusPayment;
  String? currency;
  String? country;
  @JsonKey(name: 'is_closed')
  String? isClosed;
  @JsonKey(name: 'is_single_use')
  String? isSingleUse;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  dynamic createdBy;
  @JsonKey(name: 'updated_by')
  String? updatedBy;

  VirtualAccount({
    this.id,
    this.userId,
    this.virtualAccountId,
    this.externalId,
    this.ownerId,
    this.name,
    this.bankCode,
    this.merchantCode,
    this.accountNumber,
    this.expectedAmount,
    this.expirationDate,
    this.status,
    this.statusPayment,
    this.currency,
    this.country,
    this.isClosed,
    this.isSingleUse,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  @override
  String toString() {
    return 'VirtualAccount(id: $id, userId: $userId, virtualAccountId: $virtualAccountId, externalId: $externalId, ownerId: $ownerId, name: $name, bankCode: $bankCode, merchantCode: $merchantCode, accountNumber: $accountNumber, expectedAmount: $expectedAmount, expirationDate: $expirationDate, status: $status, statusPayment: $statusPayment, currency: $currency, country: $country, isClosed: $isClosed, isSingleUse: $isSingleUse, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  factory VirtualAccount.fromJson(Map<String, dynamic> json) {
    return _$VirtualAccountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VirtualAccountToJson(this);

  VirtualAccount copyWith({
    String? id,
    String? userId,
    String? virtualAccountId,
    String? externalId,
    String? ownerId,
    String? name,
    String? bankCode,
    String? merchantCode,
    String? accountNumber,
    String? expectedAmount,
    DateTime? expirationDate,
    String? status,
    String? statusPayment,
    String? currency,
    String? country,
    String? isClosed,
    String? isSingleUse,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic createdBy,
    String? updatedBy,
  }) {
    return VirtualAccount(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      virtualAccountId: virtualAccountId ?? this.virtualAccountId,
      externalId: externalId ?? this.externalId,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      bankCode: bankCode ?? this.bankCode,
      merchantCode: merchantCode ?? this.merchantCode,
      accountNumber: accountNumber ?? this.accountNumber,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      expirationDate: expirationDate ?? this.expirationDate,
      status: status ?? this.status,
      statusPayment: statusPayment ?? this.statusPayment,
      currency: currency ?? this.currency,
      country: country ?? this.country,
      isClosed: isClosed ?? this.isClosed,
      isSingleUse: isSingleUse ?? this.isSingleUse,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
