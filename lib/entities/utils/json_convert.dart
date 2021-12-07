import 'dart:convert';

class JsonConvert {
  JsonConvert._();

  static T? Function<T extends Object?>(dynamic value) convert = <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}
