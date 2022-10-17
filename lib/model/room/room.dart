import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../thing/thing.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  factory Room({
    @Default('') dynamic RoomID,
    @Default('') dynamic CustomerId,
    @Default('') dynamic UnitId,
    @Default('') dynamic RoomName,
    @Default([]) List<Thing> Items,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
