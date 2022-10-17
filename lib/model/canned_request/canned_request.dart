import 'package:freezed_annotation/freezed_annotation.dart';

part 'canned_request.freezed.dart';
part 'canned_request.g.dart';

@freezed
class CannedRequest with _$CannedRequest {
  factory CannedRequest({
    @Default('') dynamic RequestID,
    @Default('') dynamic BuildingID,
    @Default('') dynamic RequestTitle,
    @Default('') dynamic RequestTarget,
  }) = _CannedRequest;

  factory CannedRequest.fromJson(Map<String, dynamic> json) =>
      _$CannedRequestFromJson(json);
}
