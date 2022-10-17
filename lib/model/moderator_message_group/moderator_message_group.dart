import 'package:freezed_annotation/freezed_annotation.dart';

part 'moderator_message_group.freezed.dart';
part 'moderator_message_group.g.dart';

@freezed
class ModeratorMessageGroup with _$ModeratorMessageGroup {
  factory ModeratorMessageGroup({
    @Default('') dynamic UserID,
    @Default('') dynamic CustomerID,
    @Default('') dynamic UserName,
    @Default('') dynamic UserEmail,
    @Default('') dynamic Status,
  }) = _ModeratorMessageGroup;

  factory ModeratorMessageGroup.fromJson(Map<String, dynamic> json) =>
      _$ModeratorMessageGroupFromJson(json);
}
