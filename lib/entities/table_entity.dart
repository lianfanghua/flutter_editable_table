import 'dart:convert';

import '../constants.dart';
import 'caption_layout_entity.dart';
import 'column_entity.dart';
import 'row_entity.dart';
import 'utils/utils.dart';

class TableEntity {
  const TableEntity({
    this.columnCount,
    this.rowCount,
    this.addable = false,
    this.removable = false,
    this.captionLayout,
    required this.columns,
    required this.rows,
  });

  factory TableEntity.fromJson(Map<String, dynamic> jsonRes) {
    final int? columnCount = asT<int>(jsonRes['column_count']);
    final List<ColumnEntity> columns = [];
    if (jsonRes['columns'] != null) {
      for (final dynamic item in jsonRes['columns']!) {
        if (item != null) {
          tryCatch(() {
            columns.add(ColumnEntity.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    if (columns.isEmpty) {
      for (var i = 0; i < (columnCount != null ? (columnCount > 0 ? columnCount : 1) : 1); ++i) {
        columns.add(ColumnEntity(name: '$defaultColumnPrefix$i'));
      }
    }
    final int? rowCount = asT<int>(jsonRes['row_count']);
    final List<RowEntity> rows = [];
    if (jsonRes['rows'] != null) {
      for (final dynamic item in jsonRes['rows']!) {
        if (item != null) {
          tryCatch(() {
            rows.add(RowEntity.fromJson(asT<Map<String, dynamic>>(item)!, columns));
          });
        }
      }
    }
    if (rows.isEmpty) {
      for (var i = 0; i < (rowCount != null ? (rowCount > 0 ? rowCount : 1) : 1); ++i) {
        rows.add(RowEntity(columns: columns));
      }
    }
    if (rows.isNotEmpty) {
      for (var i = 0; i < rows.length; ++i) {
        rows[i].cells?.forEach((cell) {
          if (cell.columnInfo.autoIncrease) {
            cell.value = cell.columnInfo.format?.replaceAll(defaultFormatValueSlot, (i + 1).toString());
          }
        });
      }
    }
    return TableEntity(
      columnCount: columnCount,
      rowCount: rowCount,
      addable: asT<bool?>(jsonRes['addable']) ?? false,
      removable: asT<bool?>(jsonRes['removable']) ?? false,
      captionLayout: jsonRes['caption'] == null ? null : CaptionLayoutEntity.fromJson(asT<Map<String, dynamic>>(jsonRes['caption'])!),
      columns: columns,
      rows: rows,
    );
  }

  final int? columnCount;
  final int? rowCount;
  final bool addable;
  final bool removable;
  final CaptionLayoutEntity? captionLayout;
  final List<ColumnEntity> columns;
  final List<RowEntity> rows;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'column_count': columnCount,
        'row_count': rowCount,
        'addable': addable,
        'removable': removable,
        'caption': captionLayout?.toJson(),
        'columns': columns.map((e) => e.toJson()).toList(),
        'rows': rows.map((e) => e.toJson()).toList(),
      };

  TableEntity copy() {
    return TableEntity(
      columnCount: columnCount,
      rowCount: rowCount,
      addable: addable,
      removable: removable,
      captionLayout: captionLayout?.copy(),
      columns: columns.map((e) => e.copy()).toList(),
      rows: rows.map((e) => e.copy()).toList(),
    );
  }

  void updateAutoIncreaseColumn() {
    if (rows.isNotEmpty) {
      for (var i = 0; i < rows.length; ++i) {
        rows[i].cells?.forEach((cell) {
          if (cell.columnInfo.autoIncrease) {
            cell.value = cell.columnInfo.format?.replaceAll(defaultFormatValueSlot, (i + 1).toString());
          }
        });
      }
    }
  }
}
