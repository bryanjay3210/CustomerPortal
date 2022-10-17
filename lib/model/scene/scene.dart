import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'scene_item/scene_item.dart';
part 'scene.freezed.dart';
part 'scene.g.dart';

@freezed
class Scene with _$Scene {
  factory Scene({
    @Default('') dynamic SceneID,
    @Default('') dynamic SceneName,
    required List<SceneItem> Items,
  }) = _Scene;

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
}
