import 'package:flutter/material.dart';

import '../constants.dart';
import '../entities/caption_entity.dart';
import '../entities/caption_layout_entity.dart';

class EditableTableCaption extends StatefulWidget {
  const EditableTableCaption({
    Key? key,
    required this.captionLayoutEntity,
    required this.captionWidth,
    this.captionBorder,
    this.captionPadding,
    this.captionTextStyle,
    this.captionHintTextStyle,
    this.captionInputDecorationContentPadding,
    this.captionInputDecorationBorder,
    this.captionInputDecorationFocusBorder,
    this.formFieldAutoValidateMode,
    this.readOnly = false,
    this.onFilling,
    this.onSubmitted,
  }) : super(key: key);

  final CaptionLayoutEntity captionLayoutEntity;
  final double captionWidth;
  final EdgeInsetsGeometry? captionPadding;
  final Border? captionBorder;
  final TextStyle? captionTextStyle;
  final TextStyle? captionHintTextStyle;
  final EdgeInsetsGeometry? captionInputDecorationContentPadding;
  final InputBorder? captionInputDecorationBorder;
  final InputBorder? captionInputDecorationFocusBorder;
  final AutovalidateMode? formFieldAutoValidateMode;
  final bool readOnly;

  final TableFiledFilled<String>? onFilling;
  final TableFiledFilled<String>? onSubmitted;

  @override
  _EditableTableCaptionState createState() => _EditableTableCaptionState();
}

class _EditableTableCaptionState extends State<EditableTableCaption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.captionWidth,
      padding: widget.captionPadding ?? EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: widget.captionBorder),
      child: widget.captionLayoutEntity.layoutDirection.toLowerCase() == 'row'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCaption(widget.captionLayoutEntity.mainCaption),
                if (widget.captionLayoutEntity.mainCaption != null &&
                    widget.captionLayoutEntity.subCaption != null)
                  SizedBox(width: 8.0),
                _buildCaption(widget.captionLayoutEntity.subCaption),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCaption(widget.captionLayoutEntity.mainCaption),
                if (widget.captionLayoutEntity.mainCaption != null &&
                    widget.captionLayoutEntity.subCaption != null)
                  SizedBox(height: 8.0),
                _buildCaption(widget.captionLayoutEntity.subCaption),
              ],
            ),
    );
  }

  Widget _buildCaption(CaptionEntity? captionEntity) {
    if (captionEntity == null) return SizedBox();
    return captionEntity.display
        ? (!widget.readOnly && captionEntity.editable
            ? Flexible(
                child: Container(
                  color: captionEntity.style?.backgroundColor,
                  child: TextFormField(
                    initialValue: captionEntity.title,
                    minLines: captionEntity.inputDecoration?.minLines,
                    maxLines: captionEntity.inputDecoration?.maxLines,
                    maxLength: captionEntity.inputDecoration?.maxLength,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          widget.captionInputDecorationContentPadding ??
                              EdgeInsets.all(8.0),
                      hintText: captionEntity.inputDecoration?.hintText,
                      hintStyle: widget.captionHintTextStyle,
                      hintMaxLines: captionEntity.inputDecoration?.maxLines,
                      counterText: '',
                      errorMaxLines: 1,
                      errorStyle: TextStyle(fontSize: 0.0, height: 0.0),
                      border: widget.captionInputDecorationBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).disabledColor,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                      enabledBorder: widget.captionInputDecorationBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).disabledColor,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                      focusedBorder: widget.captionInputDecorationFocusBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                      filled: captionEntity.inputDecoration?.fillColor != null,
                      fillColor: captionEntity.inputDecoration?.fillColor,
                    ),
                    style: widget.captionTextStyle ??
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: captionEntity.style?.fontSize,
                              fontWeight: captionEntity.style?.fontWeight,
                              color: captionEntity.style?.fontColor,
                            ),
                    keyboardAppearance:
                        MediaQuery.of(context).platformBrightness,
                    validator: (value) {
                      return captionEntity.required
                          ? (value != null && value.isNotEmpty ? null : '')
                          : null;
                    },
                    autovalidateMode: widget.formFieldAutoValidateMode,
                    onChanged: (value) {
                      captionEntity.title = value;
                      if (widget.onFilling != null) {
                        widget.onFilling!(FillingArea.caption, value);
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (widget.onSubmitted != null) {
                        widget.onSubmitted!(FillingArea.caption, value);
                      }
                    },
                  ),
                ),
              )
            : Container(
                color: captionEntity.style?.backgroundColor,
                width:
                    widget.captionLayoutEntity.layoutDirection.toLowerCase() ==
                            'column'
                        ? widget.captionWidth
                        : null,
                alignment: captionEntity.style?.horizontalAlignment,
                child: Text(
                  captionEntity.title ?? '',
                  style: widget.captionTextStyle ??
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: captionEntity.style?.fontSize,
                            fontWeight: captionEntity.style?.fontWeight,
                            color: captionEntity.style?.fontColor,
                          ),
                  textAlign: captionEntity.style?.textAlign,
                ),
              ))
        : SizedBox();
  }
}
