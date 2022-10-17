import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'thing.freezed.dart';
part 'thing.g.dart';

@freezed
class Thing with _$Thing {
  factory Thing({
    @Default('') dynamic ItemLabel,
    @Default('') dynamic ThingHumanName,
    @Default('') dynamic ItemState,
    @Default('') dynamic ItemCategory,
    @Default('') dynamic ItemName,
    @Default('') dynamic ThingUUID,
    @Default('') dynamic ThingID,
    @Default('') dynamic ItemID,
    @Default('') dynamic ChannelUUID,
  }) = _Thing;

  factory Thing.fromJson(Map<String, dynamic> json) => _$ThingFromJson(json);
}
