import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'channel.freezed.dart';
part 'channel.g.dart';

@freezed
class Channel with _$Channel {
  factory Channel({
    @Default('') dynamic Name,
    @Default('') dynamic Number,
    @Default('') dynamic ID,
    @Default('') dynamic Icon,
    @Default('') dynamic Stream,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}
