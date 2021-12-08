import 'package:flutter/widgets.dart';

const Map<String, FontWeight> editableCellFontWeight = {
  'light': FontWeight.w300,
  'normal': FontWeight.normal,
  'bold': FontWeight.bold,
};

const Map<String, Alignment> editableHorizontalAlignment = {
  'top-left': Alignment(-1.0, -1.0),
  'top-center': Alignment(0.0, -1.0),
  'top-right': Alignment(1.0, -1.0),
  'center-left': Alignment(-1.0, 0.0),
  'center': Alignment(0.0, 0.0),
  'center-right': Alignment(1.0, 0.0),
  'bottom-left': Alignment(-1.0, 1.0),
  'bottom-center': Alignment(0.0, 1.0),
  'bottom-right': Alignment(1.0, 1.0),
};

const Map<String, CrossAxisAlignment> editableCellVerticalAlignment = {
  'start': CrossAxisAlignment.start,
  'center': CrossAxisAlignment.center,
  'end': CrossAxisAlignment.end,
};

const Map<String, TextAlign> editableCellTextAlign = {
  'left': TextAlign.left,
  'right': TextAlign.right,
  'center': TextAlign.center,
  'justify': TextAlign.justify,
  'start': TextAlign.start,
  'end': TextAlign.end,
};

const defaultColumnPrefix = 'column_';

const defaultFormatValueSlot = '__VALUE__';

const operationColumnWidthFactor = 0.2;
