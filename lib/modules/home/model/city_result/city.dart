import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  int? id;
  @JsonKey(name: 'province_id')
  String? provinceId;
  String? name;

  City({this.id, this.provinceId, this.name});

  @override
  String toString() => 'City(id: $id, provinceId: $provinceId, name: $name)';

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  City copyWith({
    int? id,
    String? provinceId,
    String? name,
  }) {
    return City(
      id: id ?? this.id,
      provinceId: provinceId ?? this.provinceId,
      name: name ?? this.name,
    );
  }
}
