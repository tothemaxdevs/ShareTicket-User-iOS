import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String? id;
  String? name;
  String? code;
  String? icon;
  dynamic type;
  @JsonKey(name: 'event_count')
  int? eventCount;

  Category({
    this.id,
    this.name,
    this.code,
    this.icon,
    this.type,
    this.eventCount,
  });

  @override
  String toString() {
    return 'Category(id: $id, name: $name, code: $code, icon: $icon, type: $type, eventCount: $eventCount)';
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  Category copyWith({
    String? id,
    String? name,
    String? code,
    String? icon,
    dynamic type,
    int? eventCount,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      eventCount: eventCount ?? this.eventCount,
    );
  }
}
