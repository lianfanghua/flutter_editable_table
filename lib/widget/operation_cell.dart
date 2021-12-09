import 'package:flutter/material.dart';

class EditableTableOperationCell extends StatelessWidget {
  const EditableTableOperationCell({
    Key? key,
    this.removeRowIcon,
    this.removeRowIconPadding,
    this.removeRowIconAlignment,
    this.removeRowIconContainerBackgroundColor,
    this.onRowRemoved,
  }) : super(key: key);

  final Widget? removeRowIcon;
  final EdgeInsetsGeometry? removeRowIconPadding;
  final Alignment? removeRowIconAlignment;
  final Color? removeRowIconContainerBackgroundColor;

  final VoidCallback? onRowRemoved;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
        if (onRowRemoved != null) onRowRemoved!();
      },
      child: Container(
        width: 32.0,
        padding: removeRowIconPadding ?? EdgeInsets.all(4.0),
        alignment: removeRowIconAlignment ?? Alignment.center,
        color: removeRowIconContainerBackgroundColor,
        child: removeRowIcon ??
            Icon(
              Icons.remove_circle,
              color: Theme.of(context).errorColor,
              size: 24.0,
            ),
      ),
    );
  }
}
