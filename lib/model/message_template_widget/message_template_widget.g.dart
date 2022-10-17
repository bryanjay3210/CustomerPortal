// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_template_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageTemplateWidget _$$_MessageTemplateWidgetFromJson(
        Map<String, dynamic> json) =>
    _$_MessageTemplateWidget(
      TemplateID: json['TemplateID'] as String? ?? '',
      TemplateName: json['TemplateName'] as String? ?? '',
      TemplateText: json['TemplateText'] as String? ?? '',
      isSelected: json['isSelected'] as bool,
    );

Map<String, dynamic> _$$_MessageTemplateWidgetToJson(
        _$_MessageTemplateWidget instance) =>
    <String, dynamic>{
      'TemplateID': instance.TemplateID,
      'TemplateName': instance.TemplateName,
      'TemplateText': instance.TemplateText,
      'isSelected': instance.isSelected,
    };
