import 'package:json_annotation/json_annotation.dart';

part 'voucher.g.dart';

@JsonSerializable()
class Voucher {
  String? id;
  String? title;
  @JsonKey(name: 'category_id')
  String? categoryId;
  String? code;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'type_voucher')
  String? typeVoucher;
  @JsonKey(name: 'type_discount')
  String? typeDiscount;
  dynamic term;
  @JsonKey(name: 'minimum_purchase')
  int? minimumPurchase;
  @JsonKey(name: 'total_discount')
  int? totalDiscount;
  @JsonKey(name: 'max_discount')
  int? maxDiscount;
  @JsonKey(name: 'max_quota')
  int? maxQuota;
  @JsonKey(name: 'max_used')
  int? maxUsed;
  @JsonKey(name: 'total_claim')
  int? totalClaim;
  @JsonKey(name: 'total_used')
  int? totalUsed;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_by')
  String? createdBy;
  @JsonKey(name: 'updated_by')
  dynamic updatedBy;

  Voucher({
    this.id,
    this.title,
    this.categoryId,
    this.code,
    this.startDate,
    this.endDate,
    this.typeVoucher,
    this.typeDiscount,
    this.term,
    this.minimumPurchase,
    this.totalDiscount,
    this.maxDiscount,
    this.maxQuota,
    this.maxUsed,
    this.totalClaim,
    this.totalUsed,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  @override
  String toString() {
    return 'Voucher(id: $id, title: $title, categoryId: $categoryId, code: $code, startDate: $startDate, endDate: $endDate, typeVoucher: $typeVoucher, typeDiscount: $typeDiscount, term: $term, minimumPurchase: $minimumPurchase, totalDiscount: $totalDiscount, maxDiscount: $maxDiscount, maxQuota: $maxQuota, maxUsed: $maxUsed, totalClaim: $totalClaim, totalUsed: $totalUsed, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return _$VoucherFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VoucherToJson(this);

  Voucher copyWith({
    String? id,
    String? title,
    String? categoryId,
    String? code,
    String? startDate,
    String? endDate,
    String? typeVoucher,
    String? typeDiscount,
    dynamic term,
    int? minimumPurchase,
    int? totalDiscount,
    int? maxDiscount,
    int? maxQuota,
    int? maxUsed,
    int? totalClaim,
    int? totalUsed,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    dynamic updatedBy,
  }) {
    return Voucher(
      id: id ?? this.id,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      code: code ?? this.code,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      typeVoucher: typeVoucher ?? this.typeVoucher,
      typeDiscount: typeDiscount ?? this.typeDiscount,
      term: term ?? this.term,
      minimumPurchase: minimumPurchase ?? this.minimumPurchase,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      maxQuota: maxQuota ?? this.maxQuota,
      maxUsed: maxUsed ?? this.maxUsed,
      totalClaim: totalClaim ?? this.totalClaim,
      totalUsed: totalUsed ?? this.totalUsed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
