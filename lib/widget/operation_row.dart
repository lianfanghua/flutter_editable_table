import 'package:flutter/material.dart';

class EditableTableOperationRow extends StatelessWidget {
  const EditableTableOperationRow({
    Key? key,
    required this.rowWidth,
    this.rowBorder,
    this.onRowAdded,
  }) : super(key: key);

  final double rowWidth;
  final Border? rowBorder;

  final VoidCallback? onRowAdded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onRowAdded,
      child: Container(
        width: rowWidth,
        padding: EdgeInsets.symmetric(vertical: 4.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: rowBorder != null
              ? Border(
                  left: rowBorder!.left,
                  right: rowBorder!.right,
                  bottom: rowBorder!.bottom,
                )
              : null,
        ),
        child: Icon(
          Icons.add,
          size: 24.0,
        ),
      ),
    );
  }
}
