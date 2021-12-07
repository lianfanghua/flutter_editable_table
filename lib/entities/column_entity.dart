import 'dart:convert';

import 'constrains_entity.dart';
import 'input_decoration_entity.dart';
import 'style_entity.dart';
import 'utils/utils.dart';

class ColumnEntity {
  const ColumnEntity({
    this.primaryKey = false,
    this.autoIncrease = false,
    this.name,
    this.title = '',
    this.type,
    this.format,
    this.description = '',
    this.display = true,
    this.editable = true,
    this.widthFactor = 0.2,
    this.inputDecoration,
    this.constrains,
    this.style,
  });

  factory ColumnEntity.fromJson(Map<String, dynamic> jsonRes) => ColumnEntity(
        primaryKey: asT<bool?>(jsonRes['primary_key']) ?? false,
        autoIncrease: asT<bool?>(jsonRes['auto_increase']) ?? false,
        name: asT<String?>(jsonRes['name']),
        title: asT<String?>(jsonRes['title']) ?? '',
        type: asT<String?>(jsonRes['type']),
        format: asT<String?>(jsonRes['format']),
        description: asT<String?>(jsonRes['description']) ?? '',
        display: asT<bool?>(jsonRes['display']) ?? true,
        editable: asT<bool?>(jsonRes['editable']) ?? true,
        widthFactor: asT<double?>(jsonRes['width_factor']) ?? 0.2,
        inputDecoration: jsonRes['input_decoration'] == null ? null : InputDecorationEntity.fromJson(asT<Map<String, dynamic>>(jsonRes['input_decoration'])!),
        constrains: jsonRes['constrains'] == null ? null : ConstrainsEntity.fromJson(asT<Map<String, dynamic>>(jsonRes['constrains'])!),
        style: jsonRes['style'] == null ? null : StyleEntity.fromJson(asT<Map<String, dynamic>>(jsonRes['style'])!),
      );

  final bool primaryKey;
  final bool autoIncrease;
  final String? name;
  final String title;
  final String? type;
  final String? format;
  final String description;
  final bool display;
  final bool editable;
  final double widthFactor;
  final InputDecorationEntity? inputDecoration;
  final ConstrainsEntity? constrains;
  final StyleEntity? style;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'primary_key': primaryKey,
        'auto_increase': autoIncrease,
        'name': name,
        'title': title,
        'type': type,
        'format': format,
        'description': description,
        'display': display,
        'editable': editable,
        'width_factor': widthFactor,
        'input_decoration': inputDecoration,
        'constrains': constrains,
        'style': style,
      };

  ColumnEntity copy() {
    return ColumnEntity(
      primaryKey: primaryKey,
      autoIncrease: autoIncrease,
      name: name,
      title: title,
      type: type,
      format: format,
      description: description,
      display: display,
      editable: editable,
      widthFactor: widthFactor,
      inputDecoration: inputDecoration?.copy(),
      constrains: constrains?.copy(),
      style: style?.copy(),
    );
  }
}
