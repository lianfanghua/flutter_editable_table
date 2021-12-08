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
        "constrains": {"minimum": 0, "maximum": 99999999},
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
        "constrains": {"minimum": 0, "maximum": 99999999},
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
        "constrains": {"minimum": 1, "maximum": 100, "pattern": "\\w{128}"},
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
    "rows": [
      {"id": 0, "name": "Tom", "age": 18, "desc": "I'm Tom, Tom, Tom", "salary": 1000.5, "married": false, "d_o_m": null, "l_s_t": "2021-10-02 14:30:50"},
      {"id": 1, "name": "Sam", "age": 20, "desc": null, "salary": 1234.5, "married": false, "d_o_m": null, "l_s_t": "2021-06-23 11:28:00"},
      {"id": 2, "name": "Jan", "age": 21, "desc": null, "salary": 1800.0, "married": false, "d_o_m": null, "l_s_t": "2021-02-16 10:30:00"},
      {"id": 3, "name": "Ava", "age": 25, "desc": null, "salary": 2500.0, "married": false, "d_o_m": null, "l_s_t": "2020-12-25 13:00:00"},
      {"id": 4, "name": "Emma", "age": 22, "desc": null, "salary": 1700.0, "married": false, "d_o_m": null, "l_s_t": "2021-07-02 09:30:00"},
      {"id": 5, "name": "Mia", "age": 21, "desc": null, "salary": 2000.0, "married": false, "d_o_m": null, "l_s_t": "2021-05-01 10:20:43"},
      {"id": 6, "name": "Charlotte", "age": 19, "desc": null, "salary": 1500.0, "married": false, "d_o_m": null, "l_s_t": "2021-08-18 13:40:10"},
      {"id": 7, "name": "Olivia", "age": 25, "desc": null, "salary": 2500.0, "married": true, "d_o_m": "2020-10-01", "l_s_t": "2021-01-08 20:20:00"},
      {"id": 8, "name": "Liam", "age": 23, "desc": null, "salary": 3000.0, "married": true, "d_o_m": "2018-08-01", "l_s_t": "2021-11-11 18:10:20"},
      {"id": 9, "name": "David", "age": 26, "desc": null, "salary": 2300.0, "married": true, "d_o_m": "2019-03-05", "l_s_t": "2021-12-08 21:30:50"},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.print),
          onPressed: () {
            print(_editableTableKey.currentState?.currentData.rows);
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
          onRowRemoved: (row) {
            print('row removed: ${row.toString()}');
          },
          onRowAdded: () {
            print('row added');
          },
        ),
      ),
    );
  }
}
