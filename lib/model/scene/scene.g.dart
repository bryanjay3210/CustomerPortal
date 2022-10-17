// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Scene _$$_SceneFromJson(Map<String, dynamic> json) => _$_Scene(
      SceneID: json['SceneID'] ?? '',
      SceneName: json['SceneName'] ?? '',
      Items: (json['Items'] as List<dynamic>)
          .map((e) => SceneItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SceneToJson(_$_Scene instance) => <String, dynamic>{
      'SceneID': instance.SceneID,
      'SceneName': instance.SceneName,
      'Items': instance.Items,
    };
