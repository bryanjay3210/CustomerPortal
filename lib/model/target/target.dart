import 'package:freezed_annotation/freezed_annotation.dart';

part 'target.freezed.dart';
part 'target.g.dart';

@freezed
class Target with _$Target {
  factory Target({
    @Default('') dynamic TargetID,
    @Default('') dynamic TargetEmail,
    @Default('') dynamic ResidentName,
  }) = _Target;

  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);
}
