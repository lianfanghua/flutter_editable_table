import 'package:flutter/material.dart';

import '../entities/row_entity.dart';
import 'data_cell.dart';
import 'operation_cell.dart';

class EditableTableRow extends StatefulWidget {
  const EditableTableRow({
    Key? key,
    required this.rowEntity,
    this.removable = false,
    required this.rowWidth,
    this.rowBorder,
    this.cellContentPadding,
    this.cellInputDecorationContentPadding,
    this.cellHintTextStyle,
    this.cellInputDecorationBorder,
    this.cellInputDecorationFocusBorder,
    this.cellTextStyle,
    this.removeRowIcon,
    this.removeRowIconPadding,
    this.removeRowIconAlignment,
    this.removeRowIconContainerBackgroundColor,
    this.onRowRemoved,
  }) : super(key: key);

  final RowEntity rowEntity;
  final bool removable;
  final double rowWidth;
  final Border? rowBorder;
  final EdgeInsetsGeometry? cellContentPadding;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final TextStyle? cellHintTextStyle;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;
  final TextStyle? cellTextStyle;
  final Widget? removeRowIcon;
  final EdgeInsetsGeometry? removeRowIconPadding;
  final Alignment? removeRowIconAlignment;
  final Color? removeRowIconContainerBackgroundColor;

  final ValueChanged<RowEntity>? onRowRemoved;

  @override
  _EditableTableRowState createState() => _EditableTableRowState();
}

class _EditableTableRowState extends State<EditableTableRow> {
  late final double _actualWidth;

  @override
  void initState() {
    _actualWidth = (widget.rowWidth - (widget.removable ? 32.0 : 0.0) - (widget.rowBorder != null ? widget.rowBorder!.left.width + widget.rowBorder!.right.width : 0.0)) / widget.rowEntity.cells!.where((cell) => cell.columnInfo.display).map((cell) => cell.columnInfo.widthFactor).reduce((value, element) => value + element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.removable
        ? Container(
            width: widget.rowWidth,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRow(),
                EditableTableOperationCell(
                  removeRowIcon: widget.removeRowIcon,
                  removeRowIconPadding: widget.removeRowIconPadding,
                  removeRowIconAlignment: widget.removeRowIconAlignment,
                  removeRowIconContainerBackgroundColor: widget.removeRowIconContainerBackgroundColor,
                  onRowRemoved: () {
                    if (widget.onRowRemoved != null) widget.onRowRemoved!(widget.rowEntity);
                  },
                ),
              ],
            ),
          )
        : _buildRow();
  }

  Widget _buildRow() {
    return Container(
      width: widget.rowWidth - (widget.removable ? 32.0 : 0.0),
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
        children: widget.rowEntity.cells!
            .where((cell) => cell.columnInfo.display)
            .map(
              (cell) => EditableTableDataCell(
                cellEntity: cell,
                cellWidth: cell.columnInfo.widthFactor * _actualWidth,
              ),
            )
            .toList(),
      ),
    );
  }
}
