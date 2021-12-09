import 'dart:convert';

import 'input_decoration_entity.dart';
import 'style_entity.dart';
import 'utils/utils.dart';

class FooterEntity {
  FooterEntity({
    this.title,
    this.display = true,
    this.editable = true,
    this.inputDecoration,
    this.style,
  });

  factory FooterEntity.fromJson(Map<String, dynamic> jsonRes) => FooterEntity(
        title: asT<String?>(jsonRes['title']),
        display: asT<bool?>(jsonRes['display']) ?? true,
        editable: asT<bool?>(jsonRes['editable']) ?? true,
        inputDecoration: jsonRes['input_decoration'] == null
            ? null
            : InputDecorationEntity.fromJson(
                asT<Map<String, dynamic>>(jsonRes['input_decoration'])!),
        style: jsonRes['style'] == null
            ? null
            : StyleEntity.fromJson(
                asT<Map<String, dynamic>>(jsonRes['style'])!),
      );

  String? title;
  final bool display;
  final bool editable;
  final InputDecorationEntity? inputDecoration;
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
        'style': style?.toJson(),
      };

  FooterEntity copy() {
    return FooterEntity(
      title: title,
      display: display,
      editable: editable,
      inputDecoration: inputDecoration?.copy(),
      style: style?.copy(),
    );
  }
}
