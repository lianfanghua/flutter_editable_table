import 'dart:convert';

import 'column_entity.dart';

class CellEntity {
  CellEntity({
    this.value,
    required this.columnInfo,
  });

  dynamic value;
  ColumnEntity columnInfo;

  @override
  String toString() {
    return jsonEncode(this);
  }

  CellEntity copy() {
    return CellEntity(
      value: value,
      columnInfo: columnInfo,
    );
  }
}
