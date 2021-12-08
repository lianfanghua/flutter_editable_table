import 'package:flutter/material.dart';
import 'package:flutter_editable_table/flutter_editable_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Editable Table',
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
          },
          child: child,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _editableTableKey = GlobalKey<EditableTableState>();
  final data = {
    "column_count": null,
    "row_count": null,
    "addable": true,
    "removable": true,
    "caption": {
      "layout_direction": "row",
      "main_caption": {
        "title": "Caption",
        "display": true,
        "editable": false,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input the caption", "fill_color": null},
        "style": {"font_weight": "bold", "font_size": 18.0, "font_color": "#333333", "background_color": null, "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      },
      "sub_caption": {
        "title": null,
        "display": true,
        "editable": true,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input the sub-caption", "fill_color": null},
        "style": {"font_weight": "normal", "font_size": 14.0, "font_color": "#333333", "background_color": null, "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      }
    },
    "columns": [
      {
        "primary_key": true,
        "auto_increase": false,
        "name": "id",
        "title": null,
        "type": "int",
        "format": null,
        "description": null,
        "display": false,
        "editable": false,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input"},
        "constrains": {"minimum": 0, "maximum": 99999999, "pattern": ""},
        "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      },
      {
        "primary_key": false,
        "auto_increase": true,
        "name": null,
        "title": null,
        "type": "int",
        "format": "Step __VALUE__",
        "description": null,
        "display": true,
        "editable": false,
        "width_factor": 0.2,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 64, "hint_text": "Please input"},
        "constrains": {"minimum": 0, "maximum": 99999999, "pattern": ""},
        "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      },
      {
        "primary_key": false,
        "auto_increase": false,
        "name": "name",
        "title": "Name",
        "type": "string",
        "format": null,
        "description": "User Name",
        "display": true,
        "editable": true,
        "width_factor": 0.4,
        "input_decoration": {"min_lines": 3, "max_lines": null, "max_length": 128, "hint_text": "Please input the name"},
        "constrains": {"minimum": 0, "maximum": 99999999, "pattern": "\\w{128}"},
        "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      },
      {
        "primary_key": false,
        "auto_increase": false,
        "name": "age",
        "title": "Age",
        "type": "int",
        "format": null,
        "description": "Age",
        "display": true,
        "editable": true,
        "width_factor": 0.2,
        "input_decoration": {"min_lines": 1, "max_lines": 1, "max_length": 128, "hint_text": "Please input the age"},
        "constrains": {"minimum": 1, "maximum": 100, "pattern": "\\w{128}"},
        "style": {"font_weight": "bold", "font_size": 14.0, "font_color": "#333333", "background_color": "#b5cfd2", "horizontal_alignment": "center", "vertical_alignment": "center", "text_align": "center"}
      }
    ],
    "rows": [
      {"id": 0, "name": "Tom", "age": 18},
      {"id": 1, "name": "Sam", "age": 20},
      {"id": 2, "name": "Jan", "age": 21},
      {"id": 3, "name": "Ava", "age": 25},
      {"id": 4, "name": "Emma", "age": 22},
      {"id": 5, "name": "Mia", "age": 21},
      {"id": 6, "name": "Charlotte", "age": 19},
      {"id": 7, "name": "Olivia", "age": 25},
      {"id": 8, "name": "Liam", "age": 23},
      {"id": 9, "name": "David", "age": 26},
      {"id": 10, "name": "Charlotte", "age": 20},
      {"id": 11, "name": "Maeve", "age": 27},
      {"id": 12, "name": "Alice", "age": 25},
      {"id": 13, "name": "Lydia", "age": 22},
      {"id": 14, "name": "Julia", "age": 28},
      {"id": 15, "name": "Josephine", "age": 19},
      {"id": 16, "name": "Zoe", "age": 23},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.print),
          onPressed: () {
            print(_editableTableKey.currentState?.currentData.toJson());
          },
        ),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: EditableTable(
          key: _editableTableKey,
          data: data,
          tablePadding: EdgeInsets.all(8.0),
          captionBorder: Border(
            top: BorderSide(color: Color(0xFF999999)),
            left: BorderSide(color: Color(0xFF999999)),
            right: BorderSide(color: Color(0xFF999999)),
          ),
          headerBorder: Border.all(color: Color(0xFF999999)),
          rowBorder: Border.all(color: Color(0xFF999999)),
        ),
      ),
    );
  }
}
