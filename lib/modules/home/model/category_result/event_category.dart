import 'package:json_annotation/json_annotation.dart';

part 'event_category.g.dart';

@JsonSerializable()
class EventCategory {
  String? id;
  String? name;
  String? code;
  String? icon;
  dynamic type;
  @JsonKey(name: 'event_count')
  int? eventCount;

  EventCategory({
    this.id,
    this.name,
    this.code,
    this.icon,
    this.type,
    this.eventCount,
  });

  @override
  String toString() {
    return 'EventCategory(id: $id, name: $name, code: $code, icon: $icon, type: $type, eventCount: $eventCount)';
  }

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return _$EventCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventCategoryToJson(this);

  EventCategory copyWith({
    String? id,
    String? name,
    String? code,
    String? icon,
    dynamic type,
    int? eventCount,
  }) {
    return EventCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      eventCount: eventCount ?? this.eventCount,
    );
  }
}
