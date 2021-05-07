import 'package:flutterfly/flutterfly.dart';

/// Validators that are specifically for [String] only
class ValidatorString extends Validator {
  ValidatorString(dynamic value) : super(value);

  ValidatorString required({String errMsg = 'Field is required'}) {
    validate((v) => v == null || v.toString().isNullOrEmpty ? errMsg : null);
    return this;
  }

  ValidatorString minLen(int min, {String Function(int min)? errMsg}) {
    validate((v) {
      int len = value.toString().length;
      if (len < min) {
        return errMsg == null ? 'Min length is $min' : errMsg(min);
      }

      return null;
    });

    return this;
  }

  ValidatorString noDigits({String errMsg = 'Can not contain any digits'}) {
    validate((v) => value.toString().containsDigit() ? errMsg : null);
    return this;
  }

  ValidatorString digitsOnly({String errMsg = 'Digits only'}) {
    validate((v) => value.toString().isDigitOnly() ? null : errMsg);
    return this;
  }

  ValidatorString noWhitespace(
      {String errMsg = 'Can not contain white space'}) {
    validate((v) => value.toString().containsAny(' ') ? errMsg : null);
    return this;
  }

  ValidatorString noSpecialChars(String chars,
      {String Function(String ex)? errMsg}) {
    validate((v) {
      String err = errMsg != null
          ? errMsg(chars)
          : 'Can not contain special characters $chars';
      return value.toString().notContain(chars) ? null : err;
    });
    return this;
  }

  ValidatorString email({String errMsg = 'Not a valid email'}) {
    validate((v) => value.toString().isValidEmail() ? null : errMsg);
    return this;
  }

  ValidatorString validDate(
      {String format = 'yyyy-MM-dd', String errMsg = 'Not a valid date'}) {
    validate((v) => value.toString().isValidDate(fmt: format) ? null : errMsg);
    return this;
  }

  ValidatorString contains(String subStr,
      {String Function(String subStr)? errMsg}) {
    validate((v) => value.toString().contains(subStr)
        ? null
        : DynamicUtils.checkNull(errMsg, () => 'Must contain $subStr',
            ifNotNull: () => errMsg!(subStr)));
    return this;
  }
}
