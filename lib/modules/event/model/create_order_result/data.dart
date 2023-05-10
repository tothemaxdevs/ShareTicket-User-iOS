import 'package:json_annotation/json_annotation.dart';

import 'order.dart';
import 'order_detail.dart';
import 'virtual_account.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Order? order;
  @JsonKey(name: 'order_detail')
  List<OrderDetail>? orderDetail;
  @JsonKey(name: 'virtual_account')
  VirtualAccount? virtualAccount;

  Data({this.order, this.orderDetail, this.virtualAccount});

  @override
  String toString() {
    return 'Data(order: $order, orderDetail: $orderDetail, virtualAccount: $virtualAccount)';
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  Data copyWith({
    Order? order,
    List<OrderDetail>? orderDetail,
    VirtualAccount? virtualAccount,
  }) {
    return Data(
      order: order ?? this.order,
      orderDetail: orderDetail ?? this.orderDetail,
      virtualAccount: virtualAccount ?? this.virtualAccount,
    );
  }
}
