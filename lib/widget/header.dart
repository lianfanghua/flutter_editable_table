import 'package:flutter/material.dart';

import '../entities/column_entity.dart';

class EditableTableHeader extends StatefulWidget {
  const EditableTableHeader({
    Key? key,
    required this.columnsEntity,
    required this.headerWidth,
    this.headerBorder,
    this.headerTextStyle,
    this.headerContentPadding,
  }) : super(key: key);

  final List<ColumnEntity> columnsEntity;
  final double headerWidth;
  final Border? headerBorder;
  final TextStyle? headerTextStyle;
  final EdgeInsetsGeometry? headerContentPadding;

  @override
  _EditableTableHeaderState createState() => _EditableTableHeaderState();
}

class _EditableTableHeaderState extends State<EditableTableHeader> {
  late final double _actualWidth;
  late final List<ColumnEntity> _displayColumns;

  @override
  void initState() {
    _displayColumns = widget.columnsEntity.where((column) => column.display).toList(growable: false);
    _actualWidth = widget.headerWidth / _displayColumns.map((column) => column.widthFactor).reduce((value, element) => value + element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.headerWidth,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _displayColumns
              .asMap()
              .entries
              .map(
                (e) => e.value.description.isNotEmpty
                    ? Tooltip(
                        message: e.value.description,
                        textStyle: widget.headerTextStyle ??
                            Theme.of(context).tooltipTheme.textStyle?.copyWith(
                                  fontSize: e.value.style?.fontSize,
                                  fontWeight: e.value.style?.fontWeight,
                                ),
                        child: _buildColumn(context, e.value, e.key),
                      )
                    : _buildColumn(context, e.value, e.key),
              )
              .toList(growable: false),
        ),
      ),
    );
  }

  Widget _buildColumn(BuildContext context, ColumnEntity column, int index) {
    return Container(
      width: column.widthFactor * _actualWidth,
      padding: widget.headerContentPadding ?? EdgeInsets.symmetric(vertical: 4.0),
      alignment: column.style?.horizontalAlignment,
      decoration: BoxDecoration(
        border: index == 0
            ? widget.headerBorder
            : (widget.headerBorder != null
                ? Border(
                    top: widget.headerBorder!.top,
                    right: widget.headerBorder!.right,
                    bottom: widget.headerBorder!.bottom,
                  )
                : null),
        color: column.style?.backgroundColor,
      ),
      child: Text(
        column.title,
        style: widget.headerTextStyle ??
            Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: column.style?.fontSize,
                  fontWeight: column.style?.fontWeight,
                  color: column.style?.fontColor,
                ),
        textAlign: column.style?.textAlign,
      ),
    );
  }
}
