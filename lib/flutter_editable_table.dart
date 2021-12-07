library flutter_editable_table;

import 'dart:ui';

import 'package:flutter/material.dart';

import 'entities/table_entity.dart';
import 'widget/body.dart';
import 'widget/caption.dart';
import 'widget/header.dart';

class EditableTable extends StatefulWidget {
  const EditableTable({
    Key? key,
    required this.data,
    this.tablePadding,
    this.captionBorder,
    this.captionPadding,
    this.captionTextStyle,
    this.captionHintTextStyle,
    this.captionInputDecorationContentPadding,
    this.captionTextFieldBorder,
    this.captionTextFieldFocusBorder,
    this.headerBorder,
    this.headerTextStyle,
    this.rowBorder,
    this.cellTextStyle,
    this.cellTextPadding,
    this.cellHintTextStyle,
    this.cellTextFieldContentPadding,
    this.cellTextFieldBorder,
    this.cellTextFieldFocusBorder,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final EdgeInsetsGeometry? tablePadding;

  /// Caption Config
  final EdgeInsetsGeometry? captionPadding;
  final Border? captionBorder;
  final TextStyle? captionTextStyle;
  final TextStyle? captionHintTextStyle;
  final EdgeInsetsGeometry? captionInputDecorationContentPadding;
  final InputBorder? captionTextFieldBorder;
  final InputBorder? captionTextFieldFocusBorder;

  /// Header Config
  final Border? headerBorder;
  final TextStyle? headerTextStyle;

  /// Body Config
  final Border? rowBorder;
  final TextStyle? cellTextStyle;
  final EdgeInsetsGeometry? cellTextPadding;
  final TextStyle? cellHintTextStyle;
  final EdgeInsetsGeometry? cellTextFieldContentPadding;
  final InputBorder? cellTextFieldBorder;
  final InputBorder? cellTextFieldFocusBorder;

  @override
  EditableTableState createState() => EditableTableState();
}

class EditableTableState extends State<EditableTable> {
  late final TableEntity _originalTaleEntity;
  late final double _tableWidth;

  TableEntity get currentData => _originalTaleEntity;

  @override
  void initState() {
    _originalTaleEntity = TableEntity.fromJson(widget.data);
    final screenWidth = window.physicalSize.width / window.devicePixelRatio;
    final tablePadding = widget.tablePadding != null && widget.tablePadding is EdgeInsets ? ((widget.tablePadding as EdgeInsets).left + (widget.tablePadding as EdgeInsets).right) : 0.0;
    _tableWidth = _originalTaleEntity.columns.where((column) => column.display).map((column) => column.widthFactor * screenWidth).reduce((value, element) => value + element) - tablePadding;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: widget.tablePadding,
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: _tableWidth,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_originalTaleEntity.captionLayout != null)
              EditableTableCaption(
                captionLayoutEntity: _originalTaleEntity.captionLayout!,
                captionWidth: _tableWidth,
                captionPadding: widget.captionPadding,
                captionBorder: widget.captionBorder,
                captionTextStyle: widget.captionTextStyle,
                captionHintTextStyle: widget.captionHintTextStyle,
                captionInputDecorationContentPadding: widget.captionInputDecorationContentPadding,
                captionInputDecorationBorder: widget.captionTextFieldBorder,
                captionInputDecorationFocusBorder: widget.captionTextFieldFocusBorder,
              ),
            if (_originalTaleEntity.columns.isNotEmpty)
              EditableTableHeader(
                columnsEntity: _originalTaleEntity.columns,
                headerWidth: _tableWidth,
                headerBorder: widget.headerBorder,
                headerTextStyle: widget.headerTextStyle,
              ),
            if (_originalTaleEntity.rows.isNotEmpty)
              EditableTableBody(
                rowsEntity: _originalTaleEntity.rows,
                rowWidth: _tableWidth,
                rowBorder: widget.rowBorder,
                cellTextStyle: widget.cellTextStyle,
                cellTextPadding: widget.cellTextPadding,
                cellHintTextStyle: widget.cellHintTextStyle,
                cellInputDecorationContentPadding: widget.cellTextFieldContentPadding,
                cellInputDecorationBorder: widget.cellTextFieldBorder,
                cellInputDecorationFocusBorder: widget.cellTextFieldFocusBorder,
              ),
          ],
        ),
      ),
    );
  }
}
