import 'dart:convert';

import 'cell_entity.dart';
import 'column_entity.dart';
import 'utils/utils.dart';

class RowEntity {
  RowEntity({
    required List<ColumnEntity> columns,
    List<CellEntity>? cells,
    this.isDeleted = false,
  }) {
    if (cells != null) {
      this.cells = cells;
    } else {
      this.cells = columns
          .map((e) => CellEntity(value: null, columnInfo: e))
          .toList(growable: false);
    }
    this._columns = columns;
  }

  factory RowEntity.fromJson(
      Map<String, dynamic> jsonRes, List<ColumnEntity> columns) {
    return RowEntity(
      cells: columns
          .map((e) => CellEntity(value: jsonRes[e.name], columnInfo: e))
          .toList(growable: false),
      columns: columns,
      isDeleted: asT<bool?>(jsonRes['is_deleted']) ?? true,
    );
  }

  late List<CellEntity>? cells;
  late List<ColumnEntity> _columns;
  bool isDeleted;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (cells != null) {
      for (var cell in cells!) {
        if (cell.columnInfo.name == null) continue;
        json[cell.columnInfo.name!] = cell.value;
      }
    }
    return json;
  }

  RowEntity copy() {
    return RowEntity(
      cells: cells?.map((e) => e.copy()).toList(),
      columns: _columns.map((e) => e.copy()).toList(),
    );
  }
}
