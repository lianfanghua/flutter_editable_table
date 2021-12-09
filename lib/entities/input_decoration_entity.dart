import 'dart:convert';
import 'dart:ui';

import 'utils/utils.dart';

class InputDecorationEntity {
  const InputDecorationEntity({
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.fillColor,
  });

  factory InputDecorationEntity.fromJson(Map<String, dynamic> jsonRes) =>
      InputDecorationEntity(
        minLines: asT<int?>(jsonRes['min_lines']),
        maxLines: asT<int?>(jsonRes['max_lines']),
        maxLength: asT<int?>(jsonRes['max_length']),
        hintText: asT<String?>(jsonRes['hint_text']),
        fillColor: hexStringToColor(asT<String?>(jsonRes['fill_color'])),
      );

  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final Color? fillColor;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'min_lines': minLines,
        'max_lines': maxLines,
        'max_length': maxLength,
        'hint_text': hintText,
        'fill_color': colorToHexString(fillColor),
      };

  InputDecorationEntity copy() {
    return InputDecorationEntity(
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      hintText: hintText,
      fillColor: fillColor,
    );
  }
}
