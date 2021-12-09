import 'package:flutter/material.dart';
import 'package:flutter_editable_table/entities/footer_entity.dart';

import '../entities/footer_layout_entity.dart';

class EditableTableFooter extends StatefulWidget {
  const EditableTableFooter({
    Key? key,
    required this.footerLayoutEntity,
    required this.footerWidth,
    this.footerPadding,
    this.footerBorder,
    this.footerTextStyle,
    this.footerHintTextStyle,
    this.footerInputDecorationContentPadding,
    this.footerInputDecorationBorder,
    this.footerInputDecorationFocusBorder,
    this.readOnly = false,
  }) : super(key: key);

  final FooterLayoutEntity footerLayoutEntity;
  final double footerWidth;
  final EdgeInsetsGeometry? footerPadding;
  final Border? footerBorder;
  final TextStyle? footerTextStyle;
  final TextStyle? footerHintTextStyle;
  final EdgeInsetsGeometry? footerInputDecorationContentPadding;
  final InputBorder? footerInputDecorationBorder;
  final InputBorder? footerInputDecorationFocusBorder;

  final bool readOnly;

  @override
  _EditableTableFooterState createState() => _EditableTableFooterState();
}

class _EditableTableFooterState extends State<EditableTableFooter> {
  late final List<FooterEntity> _displayFooters;

  @override
  void initState() {
    _displayFooters = widget.footerLayoutEntity.footerContent!
        .where((footer) => footer.display)
        .toList(growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.footerWidth,
      padding:
          widget.footerLayoutEntity.layoutDirection.toLowerCase() == 'column'
              ? (widget.footerPadding ?? EdgeInsets.all(8.0))
              : null,
      decoration: BoxDecoration(
        border: widget.footerLayoutEntity.layoutDirection.toLowerCase() ==
                    'column' &&
                widget.footerBorder != null
            ? Border(
                left: widget.footerBorder!.left,
                right: widget.footerBorder!.right,
                bottom: widget.footerBorder!.bottom,
              )
            : null,
      ),
      child: widget.footerLayoutEntity.layoutDirection.toLowerCase() == 'row'
          ? IntrinsicHeight(
              child: Row(
                children: _displayFooters
                    .asMap()
                    .entries
                    .map((e) => _buildRowItem(e.value, e.key))
                    .toList(growable: false),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: _displayFooters
                  .asMap()
                  .entries
                  .map((e) => _buildColumnItem(e.value, e.key))
                  .toList(growable: false),
            ),
    );
  }

  Widget _buildColumnItem(FooterEntity? footerEntity, int index) {
    if (footerEntity == null) return SizedBox();
    return footerEntity.display
        ? (!widget.readOnly && footerEntity.editable
            ? Flexible(
                child: Container(
                  padding: index != _displayFooters.length - 1
                      ? EdgeInsets.only(bottom: 8.0)
                      : null,
                  color: footerEntity.style?.backgroundColor,
                  child: TextFormField(
                    initialValue: footerEntity.title,
                    minLines: footerEntity.inputDecoration?.minLines,
                    maxLines: footerEntity.inputDecoration?.maxLines,
                    maxLength: footerEntity.inputDecoration?.maxLength,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          widget.footerInputDecorationContentPadding ??
                              EdgeInsets.all(8.0),
                      hintText: footerEntity.inputDecoration?.hintText,
                      hintStyle: widget.footerHintTextStyle,
                      hintMaxLines: footerEntity.inputDecoration?.maxLines,
                      counterText: '',
                      border: widget.footerInputDecorationBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                      focusedBorder: widget.footerInputDecorationFocusBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                      filled: footerEntity.inputDecoration?.fillColor != null,
                      fillColor: footerEntity.inputDecoration?.fillColor,
                    ),
                    style: widget.footerTextStyle ??
                        Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: footerEntity.style?.fontSize,
                              fontWeight: footerEntity.style?.fontWeight,
                              color: footerEntity.style?.fontColor,
                            ),
                    keyboardAppearance:
                        MediaQuery.of(context).platformBrightness,
                    onChanged: (value) {
                      footerEntity.title = value;
                    },
                  ),
                ),
              )
            : Flexible(
                child: Container(
                  color: footerEntity.style?.backgroundColor,
                  width:
                      widget.footerLayoutEntity.layoutDirection.toLowerCase() ==
                              'column'
                          ? widget.footerWidth
                          : null,
                  padding: index != _displayFooters.length - 1
                      ? EdgeInsets.only(bottom: 8.0)
                      : null,
                  alignment: footerEntity.style?.horizontalAlignment,
                  child: Text(
                    footerEntity.title ?? '',
                    style: widget.footerTextStyle ??
                        Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: footerEntity.style?.fontSize,
                              fontWeight: footerEntity.style?.fontWeight,
                              color: footerEntity.style?.fontColor,
                            ),
                    textAlign: footerEntity.style?.textAlign,
                  ),
                ),
              ))
        : SizedBox();
  }

  Widget _buildRowItem(FooterEntity? footerEntity, int index) {
    if (footerEntity == null) return SizedBox();
    return footerEntity.display
        ? (!widget.readOnly && footerEntity.editable
            ? Flexible(
                child: Container(
                  padding: widget.footerPadding ??
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    border: index == 0
                        ? (widget.footerBorder != null
                            ? Border(
                                left: widget.footerBorder!.left,
                                right: widget.footerBorder!.right,
                                bottom: widget.footerBorder!.bottom,
                              )
                            : null)
                        : (widget.footerBorder != null
                            ? Border(
                                right: widget.footerBorder!.right,
                                bottom: widget.footerBorder!.bottom,
                              )
                            : null),
                    color: footerEntity.style?.backgroundColor,
                  ),
                  child: TextFormField(
                    initialValue: footerEntity.title,
                    minLines: footerEntity.inputDecoration?.minLines,
                    maxLines: footerEntity.inputDecoration?.maxLines,
                    maxLength: footerEntity.inputDecoration?.maxLength,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          widget.footerInputDecorationContentPadding ??
                              EdgeInsets.all(8.0),
                      hintText: footerEntity.inputDecoration?.hintText,
                      hintStyle: widget.footerHintTextStyle,
                      hintMaxLines: footerEntity.inputDecoration?.maxLines,
                      counterText: '',
                      border: widget.footerInputDecorationBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                      focusedBorder: widget.footerInputDecorationFocusBorder ??
                          OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                      filled: footerEntity.inputDecoration?.fillColor != null,
                      fillColor: footerEntity.inputDecoration?.fillColor,
                    ),
                    style: widget.footerTextStyle ??
                        Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: footerEntity.style?.fontSize,
                              fontWeight: footerEntity.style?.fontWeight,
                              color: footerEntity.style?.fontColor,
                            ),
                    keyboardAppearance:
                        MediaQuery.of(context).platformBrightness,
                    onChanged: (value) {
                      footerEntity.title = value;
                    },
                  ),
                ),
              )
            : Flexible(
                child: Container(
                  width:
                      widget.footerLayoutEntity.layoutDirection.toLowerCase() ==
                              'column'
                          ? widget.footerWidth
                          : null,
                  padding: widget.footerPadding ?? EdgeInsets.all(8.0),
                  alignment: footerEntity.style?.horizontalAlignment,
                  decoration: BoxDecoration(
                    border: index == 0
                        ? (widget.footerBorder != null
                            ? Border(
                                left: widget.footerBorder!.left,
                                right: widget.footerBorder!.right,
                                bottom: widget.footerBorder!.bottom,
                              )
                            : null)
                        : (widget.footerBorder != null
                            ? Border(
                                right: widget.footerBorder!.right,
                                bottom: widget.footerBorder!.bottom,
                              )
                            : null),
                    color: footerEntity.style?.backgroundColor,
                  ),
                  child: Text(
                    footerEntity.title ?? '',
                    style: widget.footerTextStyle ??
                        Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: footerEntity.style?.fontSize,
                              fontWeight: footerEntity.style?.fontWeight,
                              color: footerEntity.style?.fontColor,
                            ),
                    textAlign: footerEntity.style?.textAlign,
                  ),
                ),
              ))
        : SizedBox();
  }
}
