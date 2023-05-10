import 'package:json_annotation/json_annotation.dart';

import 'city.dart';

part 'city_result.g.dart';

@JsonSerializable()
class CityResult {
  List<City>? cities;

  CityResult({this.cities});

  @override
  String toString() => 'CityResult(cities: $cities)';

  factory CityResult.fromJson(Map<String, dynamic> json) {
    return _$CityResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityResultToJson(this);

  CityResult copyWith({
    List<City>? cities,
  }) {
    return CityResult(
      cities: cities ?? this.cities,
    );
  }
}
