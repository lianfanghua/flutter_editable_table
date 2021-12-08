library flutter_editable_table;

import 'dart:ui';

import 'package:flutter/material.dart';

import 'entities/row_entity.dart';
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
    this.onRowRemoved,
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

  /// Method
  final ValueChanged<RowEntity>? onRowRemoved;

  @override
  EditableTableState createState() => EditableTableState();
}

class EditableTableState extends State<EditableTable> {
  late final TableEntity _tableEntity;
  late final double _tableWidth;

  TableEntity get currentData => _tableEntity;

  @override
  void initState() {
    _tableEntity = TableEntity.fromJson(widget.data);
    final screenWidth = window.physicalSize.width / window.devicePixelRatio;
    final tablePadding = widget.tablePadding != null && widget.tablePadding is EdgeInsets ? ((widget.tablePadding as EdgeInsets).left + (widget.tablePadding as EdgeInsets).right) : 0.0;
    _tableWidth = _tableEntity.columns.where((column) => column.display).map((column) => column.widthFactor * screenWidth).reduce((value, element) => value + element) - tablePadding + (_tableEntity.removable ? 32.0 : 0.0);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_tableEntity.captionLayout != null)
              EditableTableCaption(
                captionLayoutEntity: _tableEntity.captionLayout!,
                captionWidth: _tableWidth - (_tableEntity.removable ? 32.0 : 0.0),
                captionPadding: widget.captionPadding,
                captionBorder: widget.captionBorder,
                captionTextStyle: widget.captionTextStyle,
                captionHintTextStyle: widget.captionHintTextStyle,
                captionInputDecorationContentPadding: widget.captionInputDecorationContentPadding,
                captionInputDecorationBorder: widget.captionTextFieldBorder,
                captionInputDecorationFocusBorder: widget.captionTextFieldFocusBorder,
              ),
            if (_tableEntity.columns.isNotEmpty)
              EditableTableHeader(
                columnsEntity: _tableEntity.columns,
                headerWidth: _tableWidth - (_tableEntity.removable ? 32.0 : 0.0),
                headerBorder: widget.headerBorder,
                headerTextStyle: widget.headerTextStyle,
              ),
            if (_tableEntity.rows.isNotEmpty)
              EditableTableBody(
                bodyEntity: _tableEntity.rows,
                removable: _tableEntity.removable,
                rowWidth: _tableWidth,
                rowBorder: widget.rowBorder,
                cellTextStyle: widget.cellTextStyle,
                cellContentPadding: widget.cellTextPadding,
                cellHintTextStyle: widget.cellHintTextStyle,
                cellInputDecorationContentPadding: widget.cellTextFieldContentPadding,
                cellInputDecorationBorder: widget.cellTextFieldBorder,
                cellInputDecorationFocusBorder: widget.cellTextFieldFocusBorder,
                onRowRemoved: (RowEntity row) {
                  setState(() {
                    _tableEntity.rows.remove(row);
                    _tableEntity.updateAutoIncreaseColumn();
                  });
                  if (widget.onRowRemoved != null) widget.onRowRemoved!(row);
                },
              ),
          ],
        ),
      ),
    );
  }
}
