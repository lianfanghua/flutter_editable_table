import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
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
    this.formFieldAutoValidateMode,
    this.readOnly = false,
    this.onFilling,
    this.onSubmitted,
  }) : super(key: key);

  final CellEntity cellEntity;
  final double cellWidth;
  final EdgeInsetsGeometry? cellContentPadding;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final TextStyle? cellHintTextStyle;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;
  final TextStyle? cellTextStyle;
  final AutovalidateMode? formFieldAutoValidateMode;
  final bool readOnly;

  final TableFiledFilled<dynamic>? onFilling;
  final TableFiledFilled<dynamic>? onSubmitted;

  @override
  _EditableTableDataCellState createState() => _EditableTableDataCellState();
}

class _EditableTableDataCellState extends State<EditableTableDataCell> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.cellEntity.value != null
        ? widget.cellEntity.value.toString()
        : '';
    return Container(
      width: widget.cellWidth,
      padding: widget.cellContentPadding ?? EdgeInsets.all(4.0),
      alignment: widget.cellEntity.columnInfo.style?.horizontalAlignment,
      child: !widget.readOnly &&
              !widget.cellEntity.columnInfo.autoIncrease &&
              widget.cellEntity.columnInfo.editable
          ? _buildWidget(context)
          : (widget.cellEntity.columnInfo.type.toLowerCase() == 'bool'
              ? _buildCheckBox(readOnly: true)
              : Text(
                  widget.cellEntity.value != null
                      ? widget.cellEntity.value.toString()
                      : '',
                  style: widget.cellTextStyle ??
                      Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize:
                                widget.cellEntity.columnInfo.style?.fontSize,
                            color:
                                widget.cellEntity.columnInfo.style?.fontColor,
                          ),
                  textAlign: widget.cellEntity.columnInfo.style?.textAlign,
                )),
    );
  }

  Widget _buildWidget(BuildContext context) {
    switch (widget.cellEntity.columnInfo.type.toLowerCase()) {
      case 'bool':
        return _buildCheckBox();
      case 'date':
        return _buildDatePicker(context);
      case 'datetime':
        return _buildDateTimePicker(context);
      case 'integer':
      case 'int':
      case 'float':
      case 'double':
      case 'decimal':
      case 'string':
      default:
        return _buildTextFormField(context);
    }
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      minLines: widget.cellEntity.columnInfo.inputDecoration?.minLines,
      maxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
      maxLength: widget.cellEntity.columnInfo.inputDecoration?.maxLength,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            widget.cellInputDecorationContentPadding ?? EdgeInsets.all(8.0),
        hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
        hintStyle: widget.cellHintTextStyle,
        hintMaxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
        counterText: '',
        errorMaxLines: 1,
        errorStyle: TextStyle(fontSize: 0.0, height: 0.0),
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
          Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                color: widget.cellEntity.columnInfo.style?.fontColor,
              ),
      keyboardAppearance: MediaQuery.of(context).platformBrightness,
      validator: (value) {
        return widget.cellEntity.required
            ? (value != null && value.isNotEmpty ? null : '')
            : null;
      },
      autovalidateMode: widget.formFieldAutoValidateMode,
      readOnly: true,
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          onConfirm: (date) {
            final dateString = DateFormat('yyyy-MM-dd').format(date);
            widget.cellEntity.value = dateString;
            _textEditingController.text = dateString;
            if (widget.onFilling != null) {
              widget.onFilling!(FillingArea.body, dateString);
            }
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(FillingArea.body, dateString);
            }
          },
          onCancel: () {
            widget.cellEntity.value = null;
            _textEditingController.clear();
            if (widget.onFilling != null) {
              widget.onFilling!(FillingArea.body, null);
            }
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(FillingArea.body, null);
            }
          },
          currentTime: widget.cellEntity.value != null
              ? (DateTime.tryParse(widget.cellEntity.value.toString()) ??
                  DateTime.now())
              : DateTime.now(),
          locale: WidgetsBinding.instance?.window.locale.countryCode == 'CN' &&
                  WidgetsBinding.instance?.window.locale.languageCode == 'zh'
              ? LocaleType.zh
              : LocaleType.en,
        );
      },
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      minLines: widget.cellEntity.columnInfo.inputDecoration?.minLines,
      maxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
      maxLength: widget.cellEntity.columnInfo.inputDecoration?.maxLength,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            widget.cellInputDecorationContentPadding ?? EdgeInsets.all(8.0),
        hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
        hintStyle: widget.cellHintTextStyle,
        hintMaxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
        counterText: '',
        errorMaxLines: 1,
        errorStyle: TextStyle(fontSize: 0.0, height: 0.0),
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
          Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                color: widget.cellEntity.columnInfo.style?.fontColor,
              ),
      keyboardAppearance: MediaQuery.of(context).platformBrightness,
      validator: (value) {
        return widget.cellEntity.required
            ? (value != null && value.isNotEmpty ? null : '')
            : null;
      },
      autovalidateMode: widget.formFieldAutoValidateMode,
      readOnly: true,
      onTap: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onConfirm: (date) {
            final dateString = DateFormat('yyyy-MM-dd HH:mm').format(date);
            widget.cellEntity.value = dateString;
            _textEditingController.text = dateString;
            if (widget.onFilling != null) {
              widget.onFilling!(FillingArea.body, dateString);
            }
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(FillingArea.body, dateString);
            }
          },
          onCancel: () {
            widget.cellEntity.value = null;
            _textEditingController.clear();
            if (widget.onFilling != null) {
              widget.onFilling!(FillingArea.body, null);
            }
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(FillingArea.body, null);
            }
          },
          currentTime: widget.cellEntity.value != null
              ? (DateTime.tryParse(widget.cellEntity.value.toString()) ??
                  DateTime.now())
              : DateTime.now(),
          locale: WidgetsBinding.instance?.window.locale.countryCode == 'CN' &&
                  WidgetsBinding.instance?.window.locale.languageCode == 'zh'
              ? LocaleType.zh
              : LocaleType.en,
        );
      },
    );
  }

  Widget _buildCheckBox({bool readOnly = false}) {
    return Checkbox(
      value: widget.cellEntity.value != null && widget.cellEntity.value is bool
          ? widget.cellEntity.value
          : false,
      onChanged: readOnly
          ? null
          : (value) {
              setState(() {
                widget.cellEntity.value = value;
              });
              if (widget.onFilling != null) {
                widget.onFilling!(FillingArea.body, value);
              }
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(FillingArea.body, value);
              }
            },
    );
  }

  Widget _buildTextFormField(BuildContext context) {
    TextInputType? textInputType;
    switch (widget.cellEntity.columnInfo.type.toLowerCase()) {
      case 'integer':
      case 'int':
        textInputType = TextInputType.numberWithOptions(
            signed: widget.cellEntity.columnInfo.constrains != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum! >= 0
                ? false
                : true);
        break;
      case 'float':
      case 'double':
      case 'decimal':
        textInputType = TextInputType.numberWithOptions(
            signed: widget.cellEntity.columnInfo.constrains != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum != null &&
                    widget.cellEntity.columnInfo.constrains!.minimum! >= 0
                ? false
                : true,
            decimal: true);
        break;
    }
    return TextFormField(
      controller: _textEditingController,
      minLines: widget.cellEntity.columnInfo.inputDecoration?.minLines,
      maxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
      maxLength: widget.cellEntity.columnInfo.inputDecoration?.maxLength,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            widget.cellInputDecorationContentPadding ?? EdgeInsets.all(8.0),
        hintText: widget.cellEntity.columnInfo.inputDecoration?.hintText,
        hintStyle: widget.cellHintTextStyle,
        hintMaxLines: widget.cellEntity.columnInfo.inputDecoration?.maxLines,
        counterText: '',
        errorMaxLines: 1,
        errorStyle: TextStyle(fontSize: 0.0, height: 0.0),
        border: widget.cellInputDecorationBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
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
          Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: widget.cellEntity.columnInfo.style?.fontSize,
                color: widget.cellEntity.columnInfo.style?.fontColor,
              ),
      keyboardAppearance: MediaQuery.of(context).platformBrightness,
      keyboardType: textInputType,
      validator: (value) {
        return widget.cellEntity.required
            ? (value != null && value.isNotEmpty ? null : '')
            : null;
      },
      autovalidateMode: widget.formFieldAutoValidateMode,
      onChanged: (String value) {
        if (widget.onFilling != null) {
          widget.onFilling!(FillingArea.body, value);
        }
        if (value.isEmpty) {
          widget.cellEntity.value = null;
          return;
        }
        if (['integer', 'int']
            .contains(widget.cellEntity.columnInfo.type.toLowerCase())) {
          final finalValue = int.tryParse(value);
          if (finalValue != null) {
            if (widget.cellEntity.columnInfo.constrains != null &&
                widget.cellEntity.columnInfo.constrains!.maximum != null &&
                finalValue >
                    widget.cellEntity.columnInfo.constrains!.maximum!) {
              widget.cellEntity.value =
                  widget.cellEntity.columnInfo.constrains!.maximum!;
            } else {
              widget.cellEntity.value = finalValue;
            }
          } else {
            widget.cellEntity.value = 0;
            _textEditingController.text = 0.toString();
          }
        } else if (['float', 'double', 'decimal']
            .contains(widget.cellEntity.columnInfo.type.toLowerCase())) {
          final finalValue = double.tryParse(value);
          if (finalValue != null) {
            if (widget.cellEntity.columnInfo.constrains != null &&
                widget.cellEntity.columnInfo.constrains!.maximum != null &&
                finalValue >
                    widget.cellEntity.columnInfo.constrains!.maximum!) {
              widget.cellEntity.value =
                  widget.cellEntity.columnInfo.constrains!.maximum!;
            } else {
              widget.cellEntity.value = finalValue;
            }
          } else {
            widget.cellEntity.value = 0.0;
            _textEditingController.text = (0.0).toString();
          }
        } else {
          widget.cellEntity.value = value;
        }
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(FillingArea.body, value);
        }
      },
    );
  }
}
