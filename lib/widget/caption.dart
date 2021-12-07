import 'package:flutter/material.dart';

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

  @override
  _EditableTableCaptionState createState() => _EditableTableCaptionState();
}

class _EditableTableCaptionState extends State<EditableTableCaption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.captionWidth,
      padding: widget.captionPadding ?? EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: widget.captionBorder,
      ),
      child: widget.captionLayoutEntity.layoutDirection.toLowerCase() == 'row'
          ? Row(
              children: [
                _buildCaption(widget.captionLayoutEntity.mainCaption),
                if (widget.captionLayoutEntity.mainCaption != null) SizedBox(width: 8.0),
                _buildCaption(widget.captionLayoutEntity.subCaption),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCaption(widget.captionLayoutEntity.mainCaption),
                if (widget.captionLayoutEntity.mainCaption != null) SizedBox(height: 8.0),
                _buildCaption(widget.captionLayoutEntity.subCaption),
              ],
            ),
    );
  }

  Widget _buildCaption(CaptionEntity? captionEntity) {
    if (captionEntity == null) return SizedBox();
    return captionEntity.display
        ? (captionEntity.editable
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
                      contentPadding: widget.captionInputDecorationContentPadding ?? EdgeInsets.all(8.0),
                      hintText: captionEntity.inputDecoration?.hintText,
                      hintStyle: widget.captionHintTextStyle,
                      hintMaxLines: captionEntity.inputDecoration?.maxLines,
                      counterText: '',
                      border: widget.captionInputDecorationBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          ),
                      focusedBorder: widget.captionInputDecorationFocusBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          ),
                      filled: captionEntity.inputDecoration?.fillColor != null,
                      fillColor: captionEntity.inputDecoration?.fillColor,
                    ),
                    style: widget.captionTextStyle ??
                        Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: captionEntity.style?.fontSize,
                              fontWeight: captionEntity.style?.fontWeight,
                              color: captionEntity.style?.fontColor,
                            ),
                    keyboardAppearance: MediaQuery.of(context).platformBrightness,
                    onChanged: (value) {
                      captionEntity.title = value;
                    },
                  ),
                ),
              )
            : Container(
                color: captionEntity.style?.backgroundColor,
                width: widget.captionWidth,
                alignment: captionEntity.style?.horizontalAlignment,
                child: Text(
                  captionEntity.title ?? '',
                  style: widget.captionTextStyle ??
                      Theme.of(context).textTheme.headline6?.copyWith(
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
