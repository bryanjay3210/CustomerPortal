import 'package:freezed_annotation/freezed_annotation.dart';

part 'sent_message.freezed.dart';
part 'sent_message.g.dart';

@freezed
class SentMessageModel with _$SentMessageModel {
  factory SentMessageModel({
    @Default('') dynamic MessageID,
    @Default('') dynamic MessageDate,
    @Default('') dynamic CreatorID,
    @Default('') dynamic CreatorName,
    @Default('') dynamic Subject,
    @Default('') dynamic Message,
    @Default('') dynamic Ack,
  }) = _SentMessageModel;

  factory SentMessageModel.fromJson(Map<String, dynamic> json) => _$SentMessageModelFromJson(json);
}