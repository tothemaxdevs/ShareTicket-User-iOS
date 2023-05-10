import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_version.g.dart';

@JsonSerializable()
class AppVersion extends Equatable {
  final String? id;
  final String? version;
  final String? description;
  final bool? skip;
  @JsonKey(name: 'app_type')
  final String? appType;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'updated_by')
  final dynamic updatedBy;
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;

  const AppVersion({
    this.id,
    this.version,
    this.description,
    this.skip,
    this.appType,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
  });

  factory AppVersion.fromJson(Map<String, dynamic> json) {
    return _$AppVersionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppVersionToJson(this);

  AppVersion copyWith({
    String? id,
    String? version,
    String? description,
    bool? skip,
    String? appType,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    dynamic updatedBy,
    dynamic deletedAt,
  }) {
    return AppVersion(
      id: id ?? this.id,
      version: version ?? this.version,
      description: description ?? this.description,
      skip: skip ?? this.skip,
      appType: appType ?? this.appType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      version,
      description,
      skip,
      appType,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      deletedAt,
    ];
  }
}
