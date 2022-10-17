import 'package:freezed_annotation/freezed_annotation.dart';

class EmptyMapToStringConverter implements JsonConverter<String, Object> {
  const EmptyMapToStringConverter();

  @override
  String fromJson(Object json) {
    if (json is Map) return '';
    return json.toString();
  }

  @override
  Object toJson(String object) {
    if (object == '') return {};
    return object;
  }
}
