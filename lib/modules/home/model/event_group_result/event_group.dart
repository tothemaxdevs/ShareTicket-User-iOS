import 'package:json_annotation/json_annotation.dart';

part 'event_group.g.dart';

@JsonSerializable()
class EventGroup {
  String? id;
  String? name;
  String? code;
  String? icon;
  String? type;
  @JsonKey(name: 'event_count')
  int? eventCount;

  EventGroup({
    this.id,
    this.name,
    this.code,
    this.icon,
    this.type,
    this.eventCount,
  });

  @override
  String toString() {
    return 'EventGroup(id: $id, name: $name, code: $code, icon: $icon, type: $type, eventCount: $eventCount)';
  }

  factory EventGroup.fromJson(Map<String, dynamic> json) {
    return _$EventGroupFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventGroupToJson(this);

  EventGroup copyWith({
    String? id,
    String? name,
    String? code,
    String? icon,
    String? type,
    int? eventCount,
  }) {
    return EventGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      eventCount: eventCount ?? this.eventCount,
    );
  }
}
