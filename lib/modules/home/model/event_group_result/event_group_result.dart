import 'package:json_annotation/json_annotation.dart';

import 'event_group.dart';

part 'event_group_result.g.dart';

@JsonSerializable()
class EventGroupResult {
  @JsonKey(name: 'event_groups')
  List<EventGroup>? eventGroups;

  EventGroupResult({this.eventGroups});

  @override
  String toString() => 'EventGroupResult(eventGroups: $eventGroups)';

  factory EventGroupResult.fromJson(Map<String, dynamic> json) {
    return _$EventGroupResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventGroupResultToJson(this);

  EventGroupResult copyWith({
    List<EventGroup>? eventGroups,
  }) {
    return EventGroupResult(
      eventGroups: eventGroups ?? this.eventGroups,
    );
  }
}
