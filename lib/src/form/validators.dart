import 'package:flutter/widgets.dart';

/// A Collection of the common validators for the Form Field.
class FlyFormValidator {
  /// Checks the value of the Form Field.
  /// If it's null, it returns the [errText]
  /// [errText] is defaulted to 'Required'
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
