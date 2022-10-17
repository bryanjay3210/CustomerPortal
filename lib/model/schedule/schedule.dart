import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../map_to_json.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  factory Schedule({
    @Default('') dynamic ScheduleID,
    @Default('') dynamic UnitID,
    @Default('') dynamic SceneID,
    @Default('') dynamic DayList,
    @Default('') dynamic Time,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
