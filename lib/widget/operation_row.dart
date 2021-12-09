import 'package:flutter/material.dart';

class EditableTableOperationRow extends StatelessWidget {
  const EditableTableOperationRow({
    Key? key,
    required this.rowWidth,
    this.rowBorder,
    this.addRowIcon,
    this.addRowIconPadding,
    this.addRowIconAlignment,
    this.addRowIconContainerBackgroundColor,
    this.onRowAdded,
  }) : super(key: key);

  final double rowWidth;
  final Border? rowBorder;
  final Widget? addRowIcon;
  final EdgeInsetsGeometry? addRowIconPadding;
  final Alignment? addRowIconAlignment;
  final Color? addRowIconContainerBackgroundColor;

  final VoidCallback? onRowAdded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onRowAdded,
      child: Container(
        width: rowWidth,
        padding: addRowIconPadding ?? EdgeInsets.symmetric(vertical: 4.0),
        alignment: addRowIconAlignment ?? Alignment.center,
        decoration: BoxDecoration(
          color: addRowIconContainerBackgroundColor,
          border: rowBorder != null
              ? Border(
                  left: rowBorder!.left,
                  right: rowBorder!.right,
                  bottom: rowBorder!.bottom,
                )
              : null,
        ),
        child: addRowIcon ??
            Icon(
              Icons.add,
              size: 24.0,
            ),
      ),
    );
  }
}
