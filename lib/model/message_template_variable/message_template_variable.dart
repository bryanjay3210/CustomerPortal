import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_template_variable.freezed.dart';
part 'message_template_variable.g.dart';

@freezed
class MessageTemplateVariable with _$MessageTemplateVariable {
  factory MessageTemplateVariable({
    @Default('') dynamic VariableName,
    @Default('') dynamic VariableSub,
  }) = _MessageTemplateVariable;

  factory MessageTemplateVariable.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateVariableFromJson(json);
}
