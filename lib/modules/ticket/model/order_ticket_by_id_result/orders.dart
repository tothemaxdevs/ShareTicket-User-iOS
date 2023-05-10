import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'order_detail.dart';
import 'user.dart';
import 'virtual_account.dart';
import 'qris.dart';

part 'orders.g.dart';

@JsonSerializable()
class Orders {
  String? id;
  int? total;
  int? subtotal;
  int? discount;
  String? code;
  @JsonKey(name: 'is_paid')
  bool? isPaid;
  String? status;
  User? user;
  Event? event;
  @JsonKey(name: 'virtual_account')
  VirtualAccount? virtualAccount;
  Qris? qris;
  @JsonKey(name: 'order_detail')
  List<OrderDetail>? orderDetail;

  Orders({
    this.id,
    this.total,
    this.discount,
    this.subtotal,
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
    return 'Orders(id: $id, total: $total, subtotal: $subtotal, discount: $discount code: $code, isPaid: $isPaid, status: $status, user: $user, event: $event, virtualAccount: $virtualAccount, qris: $qris, orderDetail: $orderDetail)';
  }

  factory Orders.fromJson(Map<String, dynamic> json) {
    return _$OrdersFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrdersToJson(this);

  Orders copyWith({
    String? id,
    int? total,
    int? subtotal,
    int? discount,
    String? code,
    bool? isPaid,
    String? status,
    User? user,
    Event? event,
    VirtualAccount? virtualAccount,
    Qris? qris,
    List<OrderDetail>? orderDetail,
  }) {
    return Orders(
      id: id ?? this.id,
      total: total ?? this.total,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
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
