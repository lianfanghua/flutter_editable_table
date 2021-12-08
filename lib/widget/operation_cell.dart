import 'package:flutter/material.dart';

class EditableTableOperationCell extends StatefulWidget {
  const EditableTableOperationCell({
    Key? key,
    this.cellContentPadding,
    this.onRowRemoved,
  }) : super(key: key);

  final EdgeInsetsGeometry? cellContentPadding;

  final VoidCallback? onRowRemoved;

  @override
  _EditableTableOperationCellState createState() => _EditableTableOperationCellState();
}

class _EditableTableOperationCellState extends State<EditableTableOperationCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
        if (widget.onRowRemoved != null) widget.onRowRemoved!();
      },
      child: Container(
        width: 32.0,
        padding: widget.cellContentPadding ?? EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Icon(
          Icons.remove_circle,
          color: Theme.of(context).errorColor,
          size: 24.0,
        ),
      ),
    );
  }
}
