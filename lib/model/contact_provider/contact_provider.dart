import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_provider.freezed.dart';
part 'contact_provider.g.dart';

@freezed
class ContactProvider with _$ContactProvider {
  factory ContactProvider({
    @Default('') dynamic ProviderID,
    @Default('') dynamic ProviderName,
    @Default('') dynamic ProviderSMSEmail,
    @Default('') dynamic OptionID,
    @Default('') dynamic OptionEmail,
    @Default('') dynamic OptionSMS,
    @Default('') dynamic MessageApp,
    @Default('') dynamic MessageEmail,
    @Default('') dynamic MessageSMS,
  }) = _ContactProvider;

  factory ContactProvider.fromJson(Map<String, dynamic> json) =>
      _$ContactProviderFromJson(json);
}
