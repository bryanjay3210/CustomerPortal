import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_template.freezed.dart';
part 'message_template.g.dart';

@freezed
class MessageTemplate with _$MessageTemplate {
  factory MessageTemplate({
    @Default('') dynamic TemplateID,
    @Default('') dynamic TemplateName,
    @Default('') dynamic TemplateText,
  }) = _MessageTemplate;

  factory MessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateFromJson(json);
}
