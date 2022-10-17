import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_template_widget.freezed.dart';
part 'message_template_widget.g.dart';

@freezed
class MessageTemplateWidget with _$MessageTemplateWidget {
  factory MessageTemplateWidget({
    @Default('') String TemplateID,
    @Default('') String TemplateName,
    @Default('') String TemplateText,
    required bool isSelected,
  }) = _MessageTemplateWidget;

  factory MessageTemplateWidget.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateWidgetFromJson(json);
}
