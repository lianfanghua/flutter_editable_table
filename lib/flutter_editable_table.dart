library flutter_editable_table;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_editable_table/widget/footer.dart';
import 'package:flutter_editable_table/widget/operation_row.dart';

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
    this.headerContentPadding,
    this.rowBorder,
    this.cellContentPadding,
    this.cellTextStyle,
    this.cellHintTextStyle,
    this.cellInputDecorationContentPadding,
    this.cellInputDecorationBorder,
    this.cellInputDecorationFocusBorder,
    this.footerBorder,
    this.footerPadding,
    this.footerTextStyle,
    this.footerHintTextStyle,
    this.footerInputDecorationContentPadding,
    this.footerInputDecorationBorder,
    this.footerInputDecorationFocusBorder,
    this.onRowRemoved,
    this.onRowAdded,
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
  final EdgeInsetsGeometry? headerContentPadding;

  /// Body Config
  final Border? rowBorder;
  final EdgeInsetsGeometry? cellContentPadding;
  final TextStyle? cellTextStyle;
  final TextStyle? cellHintTextStyle;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;

  /// Footer Config
  final Border? footerBorder;
  final TextStyle? footerTextStyle;
  final EdgeInsetsGeometry? footerPadding;
  final TextStyle? footerHintTextStyle;
  final EdgeInsetsGeometry? footerInputDecorationContentPadding;
  final InputBorder? footerInputDecorationBorder;
  final InputBorder? footerInputDecorationFocusBorder;

  /// Method
  final ValueChanged<RowEntity>? onRowRemoved;
  final VoidCallback? onRowAdded;

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
                headerContentPadding: widget.headerContentPadding,
              ),
            if (_tableEntity.rows.isNotEmpty)
              EditableTableBody(
                bodyEntity: _tableEntity.rows,
                removable: _tableEntity.removable,
                rowWidth: _tableWidth,
                rowBorder: widget.rowBorder,
                cellTextStyle: widget.cellTextStyle,
                cellContentPadding: widget.cellContentPadding,
                cellHintTextStyle: widget.cellHintTextStyle,
                cellInputDecorationContentPadding: widget.cellInputDecorationContentPadding,
                cellInputDecorationBorder: widget.cellInputDecorationBorder,
                cellInputDecorationFocusBorder: widget.cellInputDecorationFocusBorder,
                onRowRemoved: (RowEntity row) {
                  setState(() {
                    _tableEntity.rows.remove(row);
                    _tableEntity.updateAutoIncreaseColumn();
                  });
                  if (widget.onRowRemoved != null) widget.onRowRemoved!(row);
                },
              ),
            if (_tableEntity.addable)
              EditableTableOperationRow(
                rowWidth: _tableWidth - (_tableEntity.removable ? 32.0 : 0.0),
                rowBorder: widget.rowBorder,
                onRowAdded: () {
                  addRow();
                },
              ),
            if (_tableEntity.footerLayout != null && _tableEntity.footerLayout!.footerContent != null && _tableEntity.footerLayout!.footerContent!.isNotEmpty)
              EditableTableFooter(
                footerLayoutEntity: _tableEntity.footerLayout!,
                footerWidth: _tableWidth - (_tableEntity.removable ? 32.0 : 0.0),
                footerPadding: widget.footerPadding,
                footerBorder: widget.footerBorder,
                footerTextStyle: widget.footerTextStyle,
                footerHintTextStyle: widget.footerHintTextStyle,
                footerInputDecorationContentPadding: widget.footerInputDecorationContentPadding,
                footerInputDecorationBorder: widget.footerInputDecorationBorder,
                footerInputDecorationFocusBorder: widget.footerInputDecorationFocusBorder,
              ),
          ],
        ),
      ),
    );
  }

  void addRow() {
    setState(() {
      _tableEntity.rows.add(RowEntity(columns: _tableEntity.columns));
      _tableEntity.updateAutoIncreaseColumn();
    });
    if (widget.onRowAdded != null) widget.onRowAdded!;
  }
}
