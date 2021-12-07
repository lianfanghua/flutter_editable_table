import 'package:flutter/material.dart';

import '../entities/cell_entity.dart';
import '../entities/row_entity.dart';

class EditableTableBody extends StatefulWidget {
  const EditableTableBody({
    Key? key,
    required this.rowsEntity,
    required this.rowWidth,
    this.rowBorder,
    this.cellTextStyle,
    this.cellTextPadding,
    this.cellHintTextStyle,
    this.cellInputDecorationContentPadding,
    this.cellInputDecorationBorder,
    this.cellInputDecorationFocusBorder,
  }) : super(key: key);

  final List<RowEntity> rowsEntity;
  final double rowWidth;
  final Border? rowBorder;
  final TextStyle? cellTextStyle;
  final EdgeInsetsGeometry? cellTextPadding;
  final TextStyle? cellHintTextStyle;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;

  @override
  _EditableTableBodyState createState() => _EditableTableBodyState();
}

class _EditableTableBodyState extends State<EditableTableBody> {
  late final double _actualWidth;
  late final List<CellEntity> _displayCells;

  @override
  void initState() {
    _displayCells = widget.rowsEntity[0].cells!.where((cell) => cell.columnInfo.display).toList();
    _actualWidth = (widget.rowWidth - (widget.rowBorder != null ? widget.rowBorder!.left.width + widget.rowBorder!.right.width : 0.0)) / _displayCells.map((cell) => cell.columnInfo.widthFactor).reduce((value, element) => value + element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.rowsEntity
          .map(
            (row) => _buildRow(context, row),
          )
          .toList(),
    );
  }

  Widget _buildRow(BuildContext context, RowEntity row) {
    return Container(
      constraints: BoxConstraints(minWidth: widget.rowWidth),
      decoration: BoxDecoration(
        border: widget.rowBorder != null
            ? Border(
                left: widget.rowBorder!.left,
                right: widget.rowBorder!.right,
                bottom: widget.rowBorder!.bottom,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // TODO: Add operation column
        children: row.cells!.where((cell) => cell.columnInfo.display).toList().asMap().entries.map((e) => _buildCell(context, e.value, e.key)).toList(),
      ),
    );
  }

  Widget _buildCell(BuildContext context, CellEntity cell, int index) {
    return Container(
      width: cell.columnInfo.widthFactor * _actualWidth,
      padding: widget.cellTextPadding ?? EdgeInsets.all(4.0),
      child: !cell.columnInfo.autoIncrease && cell.columnInfo.editable
          ?
          // TODO: Present different controls according to different types
          TextFormField(
              initialValue: cell.value.toString(),
              minLines: cell.columnInfo.inputDecoration?.minLines,
              maxLines: cell.columnInfo.inputDecoration?.maxLines,
              maxLength: cell.columnInfo.inputDecoration?.maxLength,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: widget.cellInputDecorationContentPadding ?? EdgeInsets.all(8.0),
                hintText: cell.columnInfo.inputDecoration?.hintText,
                hintStyle: widget.cellHintTextStyle,
                hintMaxLines: cell.columnInfo.inputDecoration?.maxLines,
                counterText: '',
                border: widget.cellInputDecorationBorder ??
                    OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                focusedBorder: widget.cellInputDecorationFocusBorder ??
                    OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                filled: cell.columnInfo.inputDecoration?.fillColor != null,
                fillColor: cell.columnInfo.inputDecoration?.fillColor,
              ),
              style: widget.cellTextStyle ??
                  Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: cell.columnInfo.style?.fontSize,
                        color: cell.columnInfo.style?.fontColor,
                      ),
              keyboardAppearance: MediaQuery.of(context).platformBrightness,
              onChanged: (value) {
                // TODO: Convert to the type specified by the column
                cell.value = value;
              },
            )
          : Text(
              cell.value != null ? cell.value.toString() : '',
              style: widget.cellTextStyle ??
                  Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: cell.columnInfo.style?.fontSize,
                        color: cell.columnInfo.style?.fontColor,
                      ),
              textAlign: cell.columnInfo.style?.textAlign,
            ),
    );
  }
}
