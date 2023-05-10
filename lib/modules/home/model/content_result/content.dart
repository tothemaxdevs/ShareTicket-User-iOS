import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  String? id;
  String? title;
  String? description;
  @JsonKey(name: 'description_text')
  String? descriptionText;
  String? type;
  dynamic price;
  String? thumbnail;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  Content({
    this.id,
    this.title,
    this.description,
    this.descriptionText,
    this.type,
    this.price,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Content(id: $id, title: $title, description: $description, descriptionText: $descriptionText, type: $type, price: $price, thumbnail: $thumbnail, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Content.fromJson(Map<String, dynamic> json) {
    return _$ContentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  Content copyWith({
    String? id,
    String? title,
    String? description,
    String? descriptionText,
    String? type,
    dynamic price,
    String? thumbnail,
    String? createdAt,
    DateTime? updatedAt,
  }) {
    return Content(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      descriptionText: descriptionText ?? this.descriptionText,
      type: type ?? this.type,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
