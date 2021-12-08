import 'package:flutter/material.dart';

import '../entities/cell_entity.dart';

class EditableTableDataCell extends StatefulWidget {
  const EditableTableDataCell({
    Key? key,
    required this.cellEntity,
    required this.cellWidth,
    this.cellContentPadding,
    this.cellInputDecorationContentPadding,
    this.cellHintTextStyle,
    this.cellInputDecorationBorder,
    this.cellInputDecorationFocusBorder,
    this.cellTextStyle,
  }) : super(key: key);

  final CellEntity cellEntity;
  final double cellWidth;
  final EdgeInsetsGeometry? cellContentPadding;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final TextStyle? cellHintTextStyle;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;
  final TextStyle? cellTextStyle;

  @override
  _EditableTableDataCellState createState() => _EditableTableDataCellState();
}

class _EditableTableDataCellState extends State<EditableTableDataCell> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.cellEntity.value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.cellEntity.value.toString();
    return Container(
      width: widget.cellWidth,
      padding: widget.cellContentPadding ?? EdgeInsets.all(4.0),
      alignment: widget.cellEntity.columnInfo.style?.horizontalAlignment,
      child: !widget.cellEntity.columnInfo.autoIncrease && widget.cellEntity.columnInfo.editable
          ?
          // TODO: Present different controls according to different types
          TextFormField(
              controller: _textEditingController,
              minLines: widget.cellEntity.columnInfo.inputDecoration?.minLines,
              maxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
              maxLength: widget.cellEntity.columnInfo.inputDecoration?.maxLength,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: widget.cellInputDecorationContentPadding ?? EdgeInsets.all(8.0),
                hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
                hintStyle: widget.cellHintTextStyle,
                hintMaxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
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
                filled: widget.cellEntity.columnInfo.inputDecoration?.fillColor != null,
                fillColor: widget.cellEntity.columnInfo.inputDecoration?.fillColor,
              ),
              style: widget.cellTextStyle ??
                  Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                        color: widget.cellEntity.columnInfo.style?.fontColor,
                      ),
              keyboardAppearance: MediaQuery.of(context).platformBrightness,
              onChanged: (value) {
                // TODO: Convert to the type specified by the column
                widget.cellEntity.value = value;
              },
            )
          : Text(
              widget.cellEntity.value != null ? widget.cellEntity.value.toString() : '',
              style: widget.cellTextStyle ??
                  Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                        color: widget.cellEntity.columnInfo.style?.fontColor,
                      ),
              textAlign: widget.cellEntity.columnInfo.style?.textAlign,
            ),
    );
  }
}
