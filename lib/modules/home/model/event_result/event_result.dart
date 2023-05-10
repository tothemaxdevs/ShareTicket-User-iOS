import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'pagination.dart';

part 'event_result.g.dart';

@JsonSerializable()
class EventResult {
  List<Event>? events;
  Pagination? pagination;

  EventResult({this.events, this.pagination});

  @override
  String toString() {
    return 'EventResult(events: $events, pagination: $pagination)';
  }

  factory EventResult.fromJson(Map<String, dynamic> json) {
    return _$EventResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventResultToJson(this);

  EventResult copyWith({
    List<Event>? events,
    Pagination? pagination,
  }) {
    return EventResult(
      events: events ?? this.events,
      pagination: pagination ?? this.pagination,
    );
  }
}
