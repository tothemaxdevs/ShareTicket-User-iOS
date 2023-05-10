import 'package:json_annotation/json_annotation.dart';

import 'province.dart';

part 'province_result.g.dart';

@JsonSerializable()
class ProvinceResult {
  List<Province>? provinces;

  ProvinceResult({this.provinces});

  @override
  String toString() => 'ProvinceResult(provinces: $provinces)';

  factory ProvinceResult.fromJson(Map<String, dynamic> json) {
    return _$ProvinceResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProvinceResultToJson(this);

  ProvinceResult copyWith({
    List<Province>? provinces,
  }) {
    return ProvinceResult(
      provinces: provinces ?? this.provinces,
    );
  }
}
