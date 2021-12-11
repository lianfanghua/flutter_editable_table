import 'dart:convert';

import 'utils/utils.dart';

class ConstrainsEntity {
  const ConstrainsEntity({
    this.required,
    this.minimum,
    this.maximum,
  });

  factory ConstrainsEntity.fromJson(Map<String, dynamic> jsonRes) =>
      ConstrainsEntity(
        required: asT<bool?>(jsonRes['required']),
        minimum: asT<int?>(jsonRes['minimum']),
        maximum: asT<int?>(jsonRes['maximum']),
      );

  final bool? required;
  final int? minimum;
  final int? maximum;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'required': required,
        'minimum': minimum,
        'maximum': maximum,
      };

  ConstrainsEntity copy() {
    return ConstrainsEntity(
      required: required,
      minimum: minimum,
      maximum: maximum,
    );
  }
}
