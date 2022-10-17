import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    @Default('') dynamic MessageID,
    @Default('') dynamic MessageDate,
    @Default('') dynamic CreatorID,
    @Default('') dynamic Subject,
    @Default('') dynamic Message,
    @Default('') dynamic Ack,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}


