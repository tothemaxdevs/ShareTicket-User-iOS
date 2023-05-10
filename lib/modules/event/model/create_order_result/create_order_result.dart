import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'create_order_result.g.dart';

@JsonSerializable()
class CreateOrderResult {
  bool? status;
  Data? data;

  CreateOrderResult({this.status, this.data});

  @override
  String toString() => 'CreateOrderResult(status: $status, data: $data)';

  factory CreateOrderResult.fromJson(Map<String, dynamic> json) {
    return _$CreateOrderResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateOrderResultToJson(this);

  CreateOrderResult copyWith({
    bool? status,
    Data? data,
  }) {
    return CreateOrderResult(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
