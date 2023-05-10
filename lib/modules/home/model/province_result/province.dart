import 'package:json_annotation/json_annotation.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  @override
  String toString() => 'Province(id: $id, name: $name)';

  factory Province.fromJson(Map<String, dynamic> json) {
    return _$ProvinceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);

  Province copyWith({
    int? id,
    String? name,
  }) {
    return Province(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
