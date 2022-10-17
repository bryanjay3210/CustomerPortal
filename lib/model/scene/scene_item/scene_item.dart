import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'scene_item.freezed.dart';
part 'scene_item.g.dart';

@freezed
class SceneItem with _$SceneItem {
  factory SceneItem({
    @Default('') dynamic ItemName,
    @Default('') dynamic ItemValue,
  }) = _SceneItem;

  factory SceneItem.fromJson(Map<String, dynamic> json) =>
      _$SceneItemFromJson(json);
}
