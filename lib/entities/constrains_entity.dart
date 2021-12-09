import 'dart:convert';

import 'utils/utils.dart';

class ConstrainsEntity {
  const ConstrainsEntity({
    this.minimum,
    this.maximum,
    this.pattern,
  });

  factory ConstrainsEntity.fromJson(Map<String, dynamic> jsonRes) =>
      ConstrainsEntity(
        minimum: asT<int?>(jsonRes['minimum']),
        maximum: asT<int?>(jsonRes['maximum']),
        pattern: asT<String?>(jsonRes['pattern']),
      );

  final int? minimum;
  final int? maximum;
  final String? pattern;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'minimum': minimum,
        'maximum': maximum,
        'pattern': pattern,
      };

  ConstrainsEntity copy() {
    return ConstrainsEntity(
      minimum: minimum,
      maximum: maximum,
      pattern: pattern,
    );
  }
}
