import 'package:json_annotation/json_annotation.dart';

import 'event.dart';

part 'one_event_result.g.dart';

@JsonSerializable()
class OneEventResult {
  Event? event;

  OneEventResult({this.event});

  @override
  String toString() => 'OneEventResult(event: $event)';

  factory OneEventResult.fromJson(Map<String, dynamic> json) {
    return _$OneEventResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OneEventResultToJson(this);

  OneEventResult copyWith({
    Event? event,
  }) {
    return OneEventResult(
      event: event ?? this.event,
    );
  }
}
