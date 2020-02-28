import 'package:flutter/widgets.dart';

class FlyFormValidator {
  static FormFieldValidator required({String errText = 'Required'}) {
    return (v) {
      if (v == null ||
          ((v is Iterable || v is String || v is Map) && v.length == 0)) {
        return errText;
      }
      return null;
    };
  }
}
