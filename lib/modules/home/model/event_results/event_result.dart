import 'package:json_annotation/json_annotation.dart';

import 'event.dart';

part 'event_result.g.dart';

@JsonSerializable()
class EventResult {
  List<Event>? events;

  EventResult({this.events});

  @override
  String toString() => 'EventResult(events: $events)';

  factory EventResult.fromJson(Map<String, dynamic> json) {
    return _$EventResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventResultToJson(this);

  EventResult copyWith({
    List<Event>? events,
  }) {
    return EventResult(
      events: events ?? this.events,
    );
  }
}
