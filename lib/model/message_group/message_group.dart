import 'package:freezed_annotation/freezed_annotation.dart';

import '../customer/customer.dart';
import '../map_to_json.dart';

part 'message_group.freezed.dart';
part 'message_group.g.dart';

@freezed
class MessageGroup with _$MessageGroup {
  factory MessageGroup({
    @Default('') dynamic GroupID,
    @Default('') dynamic GroupName,
    @Default('') dynamic GroupType,
    @Default('') dynamic GroupAccess,
    @Default('') dynamic GroupDesc,
    @Default('') dynamic DefaultAcceptMessage,
    @Default('') dynamic DefaultRejectMessage,
    @Default('') dynamic ModeratorsEmail,
    @Default('') dynamic ReplyEmail,
    @Default('') dynamic CanReply,
    @Default('') dynamic ModeratorCustomerID,
    @Default('') dynamic ModeratorUserID,
    @Default('') dynamic ModeratorUsername,
    required List<Customer> CustomerList,
  }) = _MessageGroup;

  factory MessageGroup.fromJson(Map<String, dynamic> json) =>
      _$MessageGroupFromJson(json);
}
