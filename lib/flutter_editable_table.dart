library flutter_editable_table;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_editable_table/constants.dart';

import 'entities/row_entity.dart';
import 'entities/table_entity.dart';
import 'widget/body.dart';
import 'widget/caption.dart';
import 'widget/footer.dart';
import 'widget/header.dart';
import 'widget/operation_row.dart';

class EditableTable extends StatefulWidget {
  const EditableTable({
    Key? key,
    this.data,
    this.entity,
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
    this.removeRowIcon,
    this.removeRowIconPadding,
    this.removeRowIconAlignment,
    this.removeRowIconContainerBackgroundColor,
    this.showAddRow = true,
    this.addRowIcon,
    this.addRowIconPadding,
    this.addRowIconAlignment,
    this.addRowIconContainerBackgroundColor,
    this.footerBorder,
    this.footerPadding,
    this.footerTextStyle,
    this.footerHintTextStyle,
    this.footerInputDecorationContentPadding,
    this.footerInputDecorationBorder,
    this.footerInputDecorationFocusBorder,
    this.formFieldAutoValidateMode,
    this.readOnly = false,
    this.onRowRemoved,
    this.onRowAdded,
    this.onFilling,
    this.onSubmitted,
  })  : assert(data != null || entity != null,
            'data and entity cannot both be null'),
        super(key: key);

  /// Data Source
  final Map<String, dynamic>? data;
  final TableEntity? entity;

  /// Table Config
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
  final Widget? removeRowIcon;
  final EdgeInsetsGeometry? removeRowIconPadding;
  final Alignment? removeRowIconAlignment;
  final Color? removeRowIconContainerBackgroundColor;

  /// Operation Row Config
  final bool showAddRow;
  final Widget? addRowIcon;
  final EdgeInsetsGeometry? addRowIconPadding;
  final Alignment? addRowIconAlignment;
  final Color? addRowIconContainerBackgroundColor;

  /// Footer Config
  final Border? footerBorder;
  final TextStyle? footerTextStyle;
  final EdgeInsetsGeometry? footerPadding;
  final TextStyle? footerHintTextStyle;
  final EdgeInsetsGeometry? footerInputDecorationContentPadding;
  final InputBorder? footerInputDecorationBorder;
  final InputBorder? footerInputDecorationFocusBorder;

  /// Callback
  final ValueChanged<RowEntity>? onRowRemoved;
  final VoidCallback? onRowAdded;
  final TableFiledFilled<dynamic>? onFilling;
  final TableFiledFilled<dynamic>? onSubmitted;

  /// Main Control
  final bool readOnly;
  final AutovalidateMode? formFieldAutoValidateMode;

  @override
  EditableTableState createState() => EditableTableState();
}

class EditableTableState extends State<EditableTable> {
  late final TableEntity _tableEntity;
  late bool _readOnly;

  TableEntity get currentData => _tableEntity;

  set readOnly(bool value) {
    setState(() {
      _readOnly = value;
    });
  }

  bool get isFilled => _tableEntity.isFilled;

  double get _tablePadding =>
      widget.tablePadding != null && widget.tablePadding is EdgeInsets
          ? ((widget.tablePadding as EdgeInsets).left +
              (widget.tablePadding as EdgeInsets).right)
          : 0.0;

  @override
  void initState() {
    _readOnly = widget.readOnly;
    _tableEntity = widget.entity ?? TableEntity.fromJson(widget.data!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tableWidth = _tableEntity.columns
            .where((column) => column.display)
            .map((column) =>
                column.widthFactor * MediaQuery.of(context).size.width)
            .reduce((value, element) => value + element) -
        _tablePadding +
        (!_readOnly && _tableEntity.removable ? 32.0 : 0.0);
    return SingleChildScrollView(
      padding: widget.tablePadding,
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: BoxConstraints(maxWidth: tableWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_tableEntity.captionLayout != null)
              EditableTableCaption(
                captionLayoutEntity: _tableEntity.captionLayout!,
                captionWidth: tableWidth -
                    (!_readOnly && _tableEntity.removable ? 32.0 : 0.0),
                captionPadding: widget.captionPadding,
                captionBorder: widget.captionBorder,
                captionTextStyle: widget.captionTextStyle,
                captionHintTextStyle: widget.captionHintTextStyle,
                captionInputDecorationContentPadding:
                    widget.captionInputDecorationContentPadding,
                captionInputDecorationBorder: widget.captionTextFieldBorder,
                captionInputDecorationFocusBorder:
                    widget.captionTextFieldFocusBorder,
                formFieldAutoValidateMode: widget.formFieldAutoValidateMode,
                readOnly: _readOnly,
                onFilling: widget.onFilling,
                onSubmitted: widget.onSubmitted,
              ),
            if (_tableEntity.columns.isNotEmpty)
              EditableTableHeader(
                columnsEntity: _tableEntity.columns,
                headerWidth: tableWidth -
                    (!_readOnly && _tableEntity.removable ? 32.0 : 0.0),
                headerBorder: widget.headerBorder,
                headerTextStyle: widget.headerTextStyle,
                headerContentPadding: widget.headerContentPadding,
              ),
            if (_tableEntity.rows.isNotEmpty)
              EditableTableBody(
                bodyEntity: _tableEntity.rows,
                removable: _tableEntity.removable,
                rowWidth: tableWidth + (_readOnly ? 32.0 : 0.0),
                rowBorder: widget.rowBorder,
                cellTextStyle: widget.cellTextStyle,
                cellContentPadding: widget.cellContentPadding,
                cellHintTextStyle: widget.cellHintTextStyle,
                cellInputDecorationContentPadding:
                    widget.cellInputDecorationContentPadding,
                cellInputDecorationBorder: widget.cellInputDecorationBorder,
                cellInputDecorationFocusBorder:
                    widget.cellInputDecorationFocusBorder,
                removeRowIcon: widget.removeRowIcon,
                removeRowIconPadding: widget.removeRowIconPadding,
                removeRowIconAlignment: widget.removeRowIconAlignment,
                removeRowIconContainerBackgroundColor:
                    widget.removeRowIconContainerBackgroundColor,
                formFieldAutoValidateMode: widget.formFieldAutoValidateMode,
                readOnly: _readOnly,
                onRowRemoved: (RowEntity row) {
                  setState(() {
                    _tableEntity.rows.remove(row);
                    _tableEntity.updateAutoIncreaseColumn();
                  });
                  if (widget.onRowRemoved != null) widget.onRowRemoved!(row);
                },
                onFilling: widget.onFilling,
                onSubmitted: widget.onSubmitted,
              ),
            if (!_readOnly && _tableEntity.addable && widget.showAddRow)
              EditableTableOperationRow(
                rowWidth: tableWidth -
                    (!_readOnly && _tableEntity.removable ? 32.0 : 0.0),
                rowBorder: widget.rowBorder,
                addRowIcon: widget.addRowIcon,
                addRowIconPadding: widget.addRowIconPadding,
                addRowIconAlignment: widget.addRowIconAlignment,
                addRowIconContainerBackgroundColor:
                    widget.addRowIconContainerBackgroundColor,
                onRowAdded: () {
                  addRow();
                },
              ),
            if (_tableEntity.footerLayout != null &&
                _tableEntity.footerLayout!.footerContent != null &&
                _tableEntity.footerLayout!.footerContent!.isNotEmpty)
              EditableTableFooter(
                footerLayoutEntity: _tableEntity.footerLayout!,
                footerWidth: tableWidth -
                    (!_readOnly && _tableEntity.removable ? 32.0 : 0.0),
                footerPadding: widget.footerPadding,
                footerBorder: widget.footerBorder,
                footerTextStyle: widget.footerTextStyle,
                footerHintTextStyle: widget.footerHintTextStyle,
                footerInputDecorationContentPadding:
                    widget.footerInputDecorationContentPadding,
                footerInputDecorationBorder: widget.footerInputDecorationBorder,
                footerInputDecorationFocusBorder:
                    widget.footerInputDecorationFocusBorder,
                formFieldAutoValidateMode: widget.formFieldAutoValidateMode,
                readOnly: _readOnly,
                onFilling: widget.onFilling,
                onSubmitted: widget.onSubmitted,
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
    if (widget.onRowAdded != null) widget.onRowAdded!();
  }
}
