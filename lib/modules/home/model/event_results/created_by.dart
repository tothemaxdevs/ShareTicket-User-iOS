import 'package:json_annotation/json_annotation.dart';

part 'created_by.g.dart';

@JsonSerializable()
class CreatedBy {
  String? id;
  String? fullname;

  CreatedBy({this.id, this.fullname});

  @override
  String toString() => 'CreatedBy(id: $id, fullname: $fullname)';

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return _$CreatedByFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  CreatedBy copyWith({
    String? id,
    String? fullname,
  }) {
    return CreatedBy(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
    );
  }
}
