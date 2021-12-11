# flutter_editable_table

[![pub package](https://img.shields.io/pub/v/flutter_editable_table.svg)](https://pub.dartlang.org/packages/flutter_editable_table)

文档语言： [English](README.md) | [简体中文](README-ZH.md)

根据json数据，构造可编辑、高自定义表格的组件

## 如何使用

* 在`pubspec.yaml`中增加依赖

```yaml
dependencies:
  flutter_editable_table: any
```

* 导入库

```dart
import 'package:flutter_editable_table/flutter_editable_table.dart';
```

## API

### 创建表格

利用`EditableTable()`，即可快速创建可编辑表格

```dart
EditableTable(
  key: _editableTableKey,
  data: data,
  // entity: TableEntity.fromJson(data),
  readOnly: false,
  tablePadding: EdgeInsets.all(8.0),
  captionBorder: Border(
    top: BorderSide(color: Color(0xFF999999)),
    left: BorderSide(color: Color(0xFF999999)),
    right: BorderSide(color: Color(0xFF999999)),
  ),
  headerBorder: Border.all(color: Color(0xFF999999)),
  rowBorder: Border.all(color: Color(0xFF999999)),
  footerBorder: Border.all(color: Color(0xFF999999)),
  removeRowIcon: Icon(
    Icons.remove_circle_outline,
    size: 24.0,
    color: Colors.redAccent,
  ),
  addRowIcon: Icon(
    Icons.add_circle_outline,
    size: 24.0,
    color: Colors.white,
  ),
  addRowIconContainerBackgroundColor: Colors.blueAccent,
  onRowRemoved: (row) {
    print('row removed: ${row.toString()}');
  },
  onRowAdded: () {
    print('row added');
  },
)
```

### 数据源

```dart
// 如果同时提供`data`和`entity`，将优先使用`entity`
EditableTable(
  // 使用`Map<String, dynamic>`作为数据源
  data: data,
  // 使用`Use TableEntity`作为数据源
  entity: TableEntity.fromJson(data),
  ...
)
```

### 数据解释

```json5
{
  "column_count": null, // 列数量（当[columns]为空时自动创建列的数量，[column_count]和[columns]同时为空，会创建1列）
  "row_count": null, // 行数量（当[rows]为空时自动创建行的数量，[row_count]和[rows]同时为空，会创建1行）
  "addable": true, // 是否允许新增行
  "removable": true, // 是否允许删除行
  "caption": { // 标题
    "layout_direction": "row", // 标题布局方式，支持[row]和[column]
    "main_caption": { // 主标题
      "title": "Caption", // 标题内容
      "display": true, // 是否显示
      "editable": false, // 是否可编辑，为[true]时通过[TextFormField]显示
      "input_decoration": { // [TextFormField]的参数，[editable]为[true]时有效
        "min_lines": 1, // [TextFormField]的[minLines]
        "max_lines": 1, // [TextFormField]的[maxLines]
        "max_length": 64, // [TextFormField]的[maxLength]
        "hint_text": "Please input the caption", // [TextFormField]的[hintText]
        "fill_color": null // [TextFormField]的[fillColor]
      },
      "style": { // 样式，基本与[TextStyle]相同
        "font_weight": "bold",
        "font_size": 18.0,
        "font_color": "#333333", // 文字颜色`#RRGGBB`
        "background_color": null, // 文字所在容器的背景颜色[color]
        "horizontal_alignment": "center", // 文字所在容器的对齐方式[alignment]，支持内容见`lib/constants.dart`的`editableHorizontalAlignment`
        "vertical_alignment": "center", // 垂直对齐方式，暂不起作用
        "text_align": "center" // 文字的对齐方式，与[Text]的[textAlign]相同，支持内容见`lib/constants.dart`的`editableCellTextAlign`
      }
    },
    "sub_caption": {
      "title": null,
      "display": true,
      "editable": true,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input the sub-caption", "fill_color": null},
      "constrains": {"required": true},
      "style": {"font_weight": "normal", "font_size": 14.0, "font_color": "#333333", "background_color": null, "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    }
  },
  "columns": [ // 列
    {
      "primary_key": true, // 是否主键，只是为了进行数据标识，对表格的构造与显示不起作用
      "auto_increase": false,
      "name": "id", // 数据映射的标识，与[rows]的[key]映射
      "title": null, // 列名，用于在表头中显示
      "type": "int", // 列数据类型，编辑后的数据会根据该类型进行转换（数字类型转换失败会返回[constrains]最小值）
      "format": null,
      "description": null, // 列描述，不为null或者空字符串时，长按表头会显示该提示
      "display": false,
      "editable": false,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input"},
      "constrains": { // 输入内容约束，[editable]为[true]时有效
        "required": true, // 是否必填，默认值为[false]，如果为[true]但没填写，获取填写`isFilled`状态将返回[false]
        "minimum": 0, // 输入最小值，输入小于该值会被替换为该值（同时影响键盘行为）
        "maximum": 99999999 // 输入最大值，输入大于该值会被替换为该值
      },
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": true, // 是否自增，与[format]联合使用
      "name": null,
      "title": null,
      "type": "int",
      "format": "Step __VALUE__", // 自增数据的显示格式，自增数会替换[__VALUE__]
      "description": null,
      "display": true,
      "editable": false,
      "width_factor": 0.2, // 列宽，根据屏幕百分比计算，所有列之和大于1，表会超出屏幕，表格支持水平滑动
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input"},
      "constrains": {"minimum": 0, "maximum": 99999999},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "name",
      "title": "Name",
      "type": "string", // 数据类型支持[integer/int]，[float/double/decimal]，[bool]，[date]，[datetime]，[string]，不同类型会有不同交互行为和键盘
      "format": null,
      "description": "User Name",
      "display": true,
      "editable": true,
      "width_factor": 0.4,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 128, "hint_text": "Please input the name"},
      "constrains": {"minimum": 0, "maximum": 99999999},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "age",
      "title": "Age",
      "type": "integer",
      "format": null,
      "description": "Age",
      "display": true,
      "editable": true,
      "width_factor": 0.2,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 128, "hint_text": "Please input the age"},
      "constrains": {"minimum": 1, "maximum": 100},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "desc",
      "title": "Description",
      "type": "string",
      "format": null,
      "description": "Description",
      "display": true,
      "editable": true,
      "width_factor": 0.4,
      "input_decoration": {"min_lines": 3, "max_lines": 5, "max_length": 128, "hint_text": "Please input the description"},
      "constrains": {"minimum": 1, "maximum": 100},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "salary",
      "title": "Salary",
      "type": "float",
      "format": null,
      "description": "Salary",
      "display": true,
      "editable": true,
      "width_factor": 0.2,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 128, "hint_text": "Please input the salary"},
      "constrains": {"minimum": -100, "maximum": 10000},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "married",
      "title": "Married",
      "type": "bool",
      "format": null,
      "description": "Is married?",
      "display": true,
      "editable": true,
      "width_factor": 0.1,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 128, "hint_text": "Please select"},
      "constrains": {"minimum": 1, "maximum": 100},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "d_o_m",
      "title": "Date Of Marriage",
      "type": "date",
      "format": null,
      "description": "Date Of Marriage",
      "display": true,
      "editable": true,
      "width_factor": 0.3,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 128, "hint_text": "Please input the date of marriage"},
      "constrains": {"minimum": 1, "maximum": 100},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "l_s_t",
      "title": "Last Shopping Time",
      "type": "datetime",
      "format": null,
      "description": "Last Shopping Time",
      "display": true,
      "editable": true,
      "width_factor": 0.5,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 128, "hint_text": "Please input your last shopping time"},
      "constrains": {"minimum": 1, "maximum": 100},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    }
  ],
  "rows": [ // 行数据，key值与column的name对应
    {"id": 0, "name": "Tom", "age": 18, "desc": "I'm Tom, Tom, Tom", "salary": 1000.5, "married": false, "d_o_m": null, "l_s_t": "2021-10-02 14:30"},
    {"id": 1, "name": "Sam", "age": 20, "desc": null, "salary": 1234.5, "married": false, "d_o_m": null, "l_s_t": "2021-06-23 11:28"},
    {"id": 2, "name": "Olivia", "age": 25, "desc": null, "salary": 2500.0, "married": true, "d_o_m": "2020-10-01", "l_s_t": "2021-01-08 20:20"},
    {"id": 3, "name": "Liam", "age": 23, "desc": null, "salary": 3000.0, "married": true, "d_o_m": "2018-08-01", "l_s_t": "2021-11-11 18:10"},
    {"id": 4, "name": "David", "age": 26, "desc": null, "salary": 2300.0, "married": true, "d_o_m": "2019-03-05", "l_s_t": "2021-12-08 21:30"},
  ],
  "footer": { // 汇总行
    "layout_direction": "row", // 汇总行布局方式，支持[row]和[column]
    "content": [ // 汇总行的内容，与[main_caption]类似
      {
        "title": "Average Age: 22.4",
        "display": true,
        "editable": false,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input the sub-caption", "fill_color": null},
        "style": {"font_weight": "normal", "font_size": 14.0, "font_color": "#333333", "background_color": null, "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      },
      {
        "title": "Married: 3",
        "display": true,
        "editable": false,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input the sub-caption", "fill_color": null},
        "style": {"font_weight": "normal", "font_size": 14.0, "font_color": "#333333", "background_color": null, "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      },
      {
        "title": null,
        "display": true,
        "editable": true,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input identity", "fill_color": null},
        "style": {"font_weight": "normal", "font_size": 14.0, "font_color": "#333333", "background_color": null, "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      }
    ]
  }
}
```

### 自定义

```dart
  /// Table Config
  final EdgeInsetsGeometry? tablePadding; 

  /// Caption Config
  final EdgeInsetsGeometry? captionPadding;
  final Border? captionBorder;
  final TextStyle? captionTextStyle;
  final TextStyle? captionHintTextStyle;
  final EdgeInsetsGeometry? captionInputDecorationContentPadding;
  final InputBorder? captionTextFieldBorder;
  final InputBorder? captionTextFieldFocusBorder;

  /// Header Config
  final Border? headerBorder;
  final TextStyle? headerTextStyle;
  final EdgeInsetsGeometry? headerContentPadding;
  final Color? headerBackgroundColor;

  /// Body Config
  final bool showAddRow; // 是否显示增加操作行
  final Border? rowBorder;
  final EdgeInsetsGeometry? cellContentPadding;
  final TextStyle? cellTextStyle;
  final TextStyle? cellHintTextStyle;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;
  final Widget? removeRowIcon;
  final EdgeInsetsGeometry? removeRowIconPadding;
  final Alignment? removeRowIconAlignment;
  final Color? removeRowIconContainerBackgroundColor;

  /// Operation Row Config
  final Widget? addRowIcon;
  final EdgeInsetsGeometry? addRowIconPadding;
  final Alignment? addRowIconAlignment;
  final Color? addRowIconContainerBackgroundColor;

  /// Footer Config
  final Border? footerBorder;
  final TextStyle? footerTextStyle;
  final EdgeInsetsGeometry? footerPadding;
  final TextStyle? footerHintTextStyle;
  final EdgeInsetsGeometry? footerInputDecorationContentPadding;
  final InputBorder? footerInputDecorationBorder;
  final InputBorder? footerInputDecorationFocusBorder;

  /// Validate Config
  final AutovalidateMode? formFieldAutoValidateMode;
```

### 回调

```dart
  /// Callback
  final ValueChanged<RowEntity>? onRowRemoved;
  final VoidCallback? onRowAdded;
  final TableFiledFilled<dynamic>? onFilling;
  final TableFiledFilled<dynamic>? onSubmitted;
```

## 获取数据

```dart
final _editableTableKey = GlobalKey<EditableTableState>();
...
EditableTable(key: _editableTableKey)
...
print(_editableTableKey.currentState?.currentData);
```

## 增加行

```dart
final _editableTableKey = GlobalKey<EditableTableState>();
...
EditableTable(key: _editableTableKey)
...
_editableTableKey.currentState?.addRow();
```

## 只读模式

```dart
EditableTable(
  readOnly: true
)
```

动态改变只读模式

```dart
final _editableTableKey = GlobalKey<EditableTableState>();
...
EditableTable(key: _editableTableKey)
...
_editableTableKey.currentState?.readOnly = true;
```

## Get Filling Status

如果任何字段的`constants`中的`required`为[true]，并且`TextFormField`为空，则`isFilled`将返回 false。

```dart
final _editableTableKey = GlobalKey<EditableTableState>();
...
EditableTable(key: _editableTableKey)
...
print(_editableTableKey.currentState?.isFilled);
```

## 例子

[完整例子](example/lib/main.dart)