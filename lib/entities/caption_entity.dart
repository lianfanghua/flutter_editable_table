import 'dart:convert';

import 'constrains_entity.dart';
import 'input_decoration_entity.dart';
import 'style_entity.dart';
import 'utils/utils.dart';

class CaptionEntity {
  CaptionEntity({
    this.title,
    this.display = true,
    this.editable = true,
    this.inputDecoration,
    this.constrains,
    this.style,
  });

  factory CaptionEntity.fromJson(Map<String, dynamic> jsonRes) => CaptionEntity(
        title: asT<String?>(jsonRes['title']),
        display: asT<bool?>(jsonRes['display']) ?? true,
        editable: asT<bool?>(jsonRes['editable']) ?? true,
        inputDecoration: jsonRes['input_decoration'] == null
            ? null
            : InputDecorationEntity.fromJson(
                asT<Map<String, dynamic>>(jsonRes['input_decoration'])!),
        constrains: jsonRes['constrains'] == null
            ? null
            : ConstrainsEntity.fromJson(
                asT<Map<String, dynamic>>(jsonRes['constrains'])!),
        style: jsonRes['style'] == null
            ? null
            : StyleEntity.fromJson(
                asT<Map<String, dynamic>>(jsonRes['style'])!),
      );

  String? title;
  final bool display;
  final bool editable;
  final InputDecorationEntity? inputDecoration;
  final ConstrainsEntity? constrains;
  final StyleEntity? style;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'display': display,
        'editable': editable,
        'input_decoration': inputDecoration?.toJson(),
        'constrains': constrains?.toJson(),
        'style': style?.toJson(),
      };

  CaptionEntity copy() {
    return CaptionEntity(
      title: title,
      display: display,
      editable: editable,
      inputDecoration: inputDecoration?.copy(),
      constrains: constrains?.copy(),
      style: style?.copy(),
    );
  }

  bool get required => constrains != null && constrains!.required == true;

  bool get isFilled =>
      !editable || !required || (title != null && title!.isNotEmpty);
}
