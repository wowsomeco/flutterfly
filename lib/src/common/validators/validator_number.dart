import 'package:flutterfly/flutterfly.dart';

/// Validators that are specifically for [num] only
class ValidatorNumber extends Validator {
  ValidatorNumber(dynamic value) : super(value);

  ValidatorNumber required({String errMsg = 'Field is required'}) {
    validate((v) => _numValue() == null ? errMsg : null);
    return this;
  }

  /// Ensures the [value] can not be negative
  ValidatorNumber positive({String errMsg = 'Must be positive'}) {
    validate((v) {
      num? number = _numValue();
      return null == number || number < 0 ? errMsg : null;
    });

    return this;
  }

  /// Makes sure the [value] is between [min] and [max]
  ValidatorNumber between(num min, num max,
      {String Function(num min, num max)? errMsg}) {
    validate((v) {
      num? number = _numValue();
      if (!number.isBetween(min, max)) {
        return errMsg == null
            ? 'Must be between $min and $max'
            : errMsg(min, max);
      }

      return null;
    });

    return this;
  }

  /// Greater than [limit] comparison
  ValidatorNumber gt(num limit, {String Function(num limit)? errMsg}) {
    _compare(limit, (v) => v > limit, 'greater');
    return this;
  }

  /// Less than [limit] comparison
  ValidatorNumber lt(num limit, {String Function(num limit)? errMsg}) {
    _compare(limit, (v) => v < limit, 'less');
    return this;
  }

  _compare(num limit, bool Function(num cur) comparer, String type,
      {String Function(num lim)? errMsg}) {
    validate((v) {
      num? number = _numValue();
      if (number == null || !comparer(number)) {
        return errMsg != null ? errMsg(limit) : 'Must be $type than $limit';
      }

      return null;
    });
  }

  num? _numValue() => num.tryParse(value.toString());
}
