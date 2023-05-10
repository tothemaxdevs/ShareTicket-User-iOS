import 'package:json_annotation/json_annotation.dart';

import 'event_category.dart';

part 'category_result.g.dart';

@JsonSerializable()
class CategoryResult {
  @JsonKey(name: 'event_categories')
  List<EventCategory>? eventCategories;

  CategoryResult({this.eventCategories});

  @override
  String toString() => 'CategoryResult(eventCategories: $eventCategories)';

  factory CategoryResult.fromJson(Map<String, dynamic> json) {
    return _$CategoryResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryResultToJson(this);

  CategoryResult copyWith({
    List<EventCategory>? eventCategories,
  }) {
    return CategoryResult(
      eventCategories: eventCategories ?? this.eventCategories,
    );
  }
}
