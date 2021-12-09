# flutter_editable_table

Language: [English](README.md) | [简体中文](README-ZH.md)

A flutter package providing customizable and editable table from json.

## Getting started

* add library to your pubspec.yaml

```yaml
dependencies:
  flutter_editable_table: any
```

* import library in dart file

```dart
import 'package:flutter_editable_table/flutter_editable_table.dart';
```

## API

### Create Editable Table

To create a new editable table, use the `EditableTable()` widget and provide the json data as follows.

```dart
EditableTable(
  key: _editableTableKey,
  data: data,
  // entity: TableEntity.fromJson(data),
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

### Data source

```dart
// If both `data` and `entity` are provided, `entity` will be used first
EditableTable(
  // Use `Map<String, dynamic>` as data source
  data: data,
  // Use `TableEntity` as data source
  entity: TableEntity.fromJson(data),
  ...
)
```

### Data Interpretation

```json5
{
  "column_count": null, // Number of columns (the number of columns that are automatically created when [columns] is empty, [column_count] and [columns] are both empty at the same time, 1 column will be created)
  "row_count": null, // Number of rows (the number of rows created automatically when [rows] is empty, and 1 row will be created if both [row_count] and [rows] are empty at the same time)
  "addable": true, // Allow add new row
  "removable": true, // Allow remove row
  "caption": { // Table caption
    "layout_direction": "row", // Caption layout direction, support [row] and [column]
    "main_caption": { // Main caption
      "title": "Caption", // Caption title for display
      "display": true, // Specify the caption display or not
      "editable": false, // Specify the caption is editable, if [true], the caption will show as [TextFormField]
      "input_decoration": { // [TextFormField] arguments，if [editable] is [true], the argument will take effect
        "min_lines": 1, // Same as [TextFormField] [minLines]
        "max_lines": 1, // Same as [TextFormField] [maxLines]
        "max_length": 64, // Same as [TextFormField]的 maxLength]
        "hint_text": "Please input the caption", // Same as [TextFormField] [hintText]
        "fill_color": null // Same as [TextFormField] [fillColor]
      },
      "style": { // Text style, basically the same as [TextStyle]
        "font_weight": "bold",
        "font_size": 18.0,
        "font_color": "#333333", // Font color, format is `#RRGGBB`
        "background_color": null, // The background color of the text container [color]
        "horizontal_alignment": "center", // The alignment of the text container [alignment]，see `lib/constants.dart` - `editableHorizontalAlignment`
        "vertical_alignment": "center", // Vertical alignment, not work now
        "text_align": "center" // The text align, same as [Text] [textAlign], see `lib/constants.dart` -`editableCellTextAlign`
      }
    },
    "sub_caption": {
      "title": null,
      "display": true,
      "editable": true,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input the sub-caption", "fill_color": null},
      "style": {"font_weight": "normal", "font_size": 14.0, "font_color": "#333333", "background_color": null, "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    }
  },
  "columns": [ // Column
    {
      "primary_key": true, // Specify the row is  primary key or not, just for specify the data identification, it has no effect on the structure and display of the table
      "auto_increase": false,
      "name": "id", // Key of the rows data, see [rows]
      "title": null, // Column name for display
      "type": "int", // Column data type, to specifies how to convert the value after edit(if the type is integer/float, the value will be [minimum] in [constrains] when convert failed)
      "format": null,
      "description": null, // Column description, if not [null] or blank, it will display a tooltip with this description when `Long Press` the header
      "display": false,
      "editable": false,
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input"},
      "constrains": { // [TextFormField] constrains, when [type] is int/float, and [editable] is [true], it will take effect
        "minimum": 0, // The minimum value to input, when input less then this value will replaced with this value(it will affect the keyboard type)
        "maximum": 99999999 // The maximum value to input, when input grater then this value will replaced with this value
      },
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": true, // Specify this column is increase automatically or not, use in conjunction with [format]
      "name": null,
      "title": null,
      "type": "int",
      "format": "Step __VALUE__", // The display format of the auto-increase data, the number will replace [__VALUE__]
      "description": null,
      "display": true,
      "editable": false,
      "width_factor": 0.2, // Column width factor, calculated according to the screen percentage, if the sum of all columns is greater than 1, the table will exceed the screen, and the table supports horizontal sliding
      "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input"},
      "constrains": {"minimum": 0, "maximum": 99999999},
      "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
    },
    {
      "primary_key": false,
      "auto_increase": false,
      "name": "name",
      "title": "Name",
      "type": "string", // Data types support [integer/int], [float/double/decimal], [bool], [date], [datetime], [string], different types have different interaction behaviors and keyboard
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
  "footer": { // Table footer
    "layout_direction": "row", // Table footer layout direction, support [row] and [column]
    "content": [ // Content in table footer, it will be lay out according to [layout_direction]
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

### Customization

```dart
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

  /// Body Config
  final bool showAddRow; // Display the operation row or not
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
```

### Callback

```dart
  /// Callback
  final ValueChanged<RowEntity>? onRowRemoved;
  final VoidCallback? onRowAdded;
```

## Get Data

```dart
final _editableTableKey = GlobalKey<EditableTableState>();
...
EditableTable(key: _editableTableKey)
...
print(_editableTableKey.currentState?.currentData);
```

## Add Row

```dart
final _editableTableKey = GlobalKey<EditableTableState>();
...
EditableTable(key: _editableTableKey)
...
_editableTableKey.currentState?.addRow();
```

## Read Only Mode

```dart
EditableTable(
  readOnly: true
)
```

Dynamically change the read-only mode

```dart
final _editableTableKey = GlobalKey<EditableTableState>();
...
EditableTable(key: _editableTableKey)
...
_editableTableKey.currentState?.readOnly = true;
```

## Example

See [Example](example/lib/main.dart)