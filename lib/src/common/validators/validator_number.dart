import 'package:flutterfly/flutterfly.dart';

class ValidatorNumber extends Validator {
  ValidatorNumber(dynamic value) : super(value);

  ValidatorNumber positive({String errMsg = 'Must be positive'}) {
    validate((v) {
      num? number = num.tryParse(value.toString());
      return null == number || number < 0 ? errMsg : null;
    });

    return this;
  }

  ValidatorNumber between(num min, num max,
      {String Function(num min, num max)? errMsg}) {
    validate((v) {
      num? number = num.tryParse(value.toString());
      if (!number.isBetween(min, max)) {
        return errMsg == null
            ? 'Must be between $min and $max'
            : errMsg(min, max);
      }

      return null;
    });

    return this;
  }

  /// Greater than comparison
  ValidatorNumber gt(num limit, {String Function(num limit)? errMsg}) {
    _compare(limit, (v) => v > limit, 'greater');
    return this;
  }

  /// Less than comparison
  ValidatorNumber lt(num limit, {String Function(num limit)? errMsg}) {
    _compare(limit, (v) => v < limit, 'less');
    return this;
  }

  _compare(num limit, bool Function(num cur) comparer, String type,
      {String Function(num lim)? errMsg}) {
    validate((v) {
      num? number = num.tryParse(value.toString());
      if (number == null || !comparer(number)) {
        return errMsg != null ? errMsg(limit) : 'Must be $type than $limit';
      }

      return null;
    });
  }
}
