import 'dart:convert';

import 'package:drift/drift.dart';

class LocalizedStringConverter extends TypeConverter<Map<String, String>, String> {
  @override
  String toSql(Map<String, String> value) {
    return jsonEncode(value);
  }

  @override
  Map<String, String> fromSql(String fromDb) {
    return jsonDecode(fromDb);
  }
}
