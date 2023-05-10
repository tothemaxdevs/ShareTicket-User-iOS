import 'package:json_annotation/json_annotation.dart';

import 'content.dart';

part 'content_result.g.dart';

@JsonSerializable()
class ContentResult {
  List<Content>? contents;

  ContentResult({this.contents});

  @override
  String toString() => 'ContentResult(contents: $contents)';

  factory ContentResult.fromJson(Map<String, dynamic> json) {
    return _$ContentResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContentResultToJson(this);

  ContentResult copyWith({
    List<Content>? contents,
  }) {
    return ContentResult(
      contents: contents ?? this.contents,
    );
  }
}
