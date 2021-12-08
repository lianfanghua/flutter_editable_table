import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../constants.dart';
import 'utils/utils.dart';

class StyleEntity {
  const StyleEntity({
    this.fontWeight,
    this.fontSize,
    this.fontColor,
    this.backgroundColor,
    this.horizontalAlignment,
    this.verticalAlignment,
    this.textAlign,
  });

  factory StyleEntity.fromJson(Map<String, dynamic> jsonRes) => StyleEntity(
        fontWeight: editableCellFontWeight[asT<String?>(jsonRes['font_weight']) ?? 'normal'],
        fontSize: asT<double?>(jsonRes['font_size']),
        fontColor: hexStringToColor(asT<String?>(jsonRes['font_color'])),
        backgroundColor: hexStringToColor(asT<String?>(jsonRes['background_color'])),
        horizontalAlignment: editableHorizontalAlignment[asT<String?>(jsonRes['horizontal_alignment'])],
        verticalAlignment: editableCellVerticalAlignment[asT<String?>(jsonRes['vertical_alignment'])],
        textAlign: editableCellTextAlign[asT<String?>(jsonRes['text_align'])],
      );

  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final Color? backgroundColor;
  final Alignment? horizontalAlignment;
  final CrossAxisAlignment? verticalAlignment;
  final TextAlign? textAlign;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'font_weight': editableCellFontWeight.keys.firstWhere((key) => editableCellFontWeight[key] == fontWeight, orElse: () => 'normal'),
        'font_size': fontSize,
        'font_color': colorToHexString(fontColor),
        'background_color': colorToHexString(backgroundColor),
        'horizontal_alignment': editableHorizontalAlignment.keys.firstWhere((key) => editableHorizontalAlignment[key] == horizontalAlignment, orElse: () => 'top-left'),
        'vertical_alignment': editableCellVerticalAlignment.keys.firstWhere((key) => editableCellVerticalAlignment[key] == verticalAlignment, orElse: () => 'start'),
        'text_align': editableCellTextAlign.keys.firstWhere((element) => editableCellTextAlign[element] == textAlign, orElse: () => 'left'),
      };

  StyleEntity copy() {
    return StyleEntity(
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontColor: fontColor,
      backgroundColor: backgroundColor,
      horizontalAlignment: horizontalAlignment,
      verticalAlignment: verticalAlignment,
      textAlign: textAlign,
    );
  }
}
