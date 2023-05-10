import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'order_detail.dart';
import 'qris.dart';
import 'user.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  String? id;
  int? total;
  String? code;
  @JsonKey(name: 'is_paid')
  bool? isPaid;
  String? status;
  User? user;
  Event? event;
  @JsonKey(name: 'virtual_account')
  dynamic virtualAccount;
  Qris? qris;
  @JsonKey(name: 'order_detail')
  List<OrderDetail>? orderDetail;

  Order({
    this.id,
    this.total,
    this.code,
    this.isPaid,
    this.status,
    this.user,
    this.event,
    this.virtualAccount,
    this.qris,
    this.orderDetail,
  });

  @override
  String toString() {
    return 'Order(id: $id, total: $total, code: $code, isPaid: $isPaid, status: $status, user: $user, event: $event, virtualAccount: $virtualAccount, qris: $qris, orderDetail: $orderDetail)';
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    String? id,
    int? total,
    String? code,
    bool? isPaid,
    String? status,
    User? user,
    Event? event,
    dynamic virtualAccount,
    Qris? qris,
    List<OrderDetail>? orderDetail,
  }) {
    return Order(
      id: id ?? this.id,
      total: total ?? this.total,
      code: code ?? this.code,
      isPaid: isPaid ?? this.isPaid,
      status: status ?? this.status,
      user: user ?? this.user,
      event: event ?? this.event,
      virtualAccount: virtualAccount ?? this.virtualAccount,
      qris: qris ?? this.qris,
      orderDetail: orderDetail ?? this.orderDetail,
    );
  }
}
