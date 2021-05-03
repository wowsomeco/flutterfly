import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/flutterfly.dart';
import 'package:flutterfly/src/common/validators/validator_number.dart';
import 'package:flutterfly/src/common/validators/validator_string.dart';

void main() {
  group('validators', () {
    test('base', () {
      Validator validator =
          Validator('Test').validate((v) => v!.length < 5 ? 'err' : null);
      // error since length < 5
      expect(validator.build(), 'err');
      // optional, wont return error
      expect(validator.unless((v) => v == 'Test').build(), null);
      // test optional method
      validator = Validator(null)
          .validate((v) => v!.length < 5 ? 'err' : null)
          .optional();
      expect(validator.build(), null);
    });

    test('number', () {
      ValidatorNumber validator = ValidatorNumber(-1).positive();
      expect(validator.build(), 'Must be positive');

      validator = ValidatorNumber(null).positive();
      expect(validator.build(), 'Must be positive');

      validator = ValidatorNumber('-1').positive();
      expect(validator.build(), 'Must be positive');

      validator = ValidatorNumber('9').between(10, 20,
          errMsg: (min, max) => 'Must be between $min and $max');
      expect(validator.build(), 'Must be between 10 and 20');
    });

    test('string', () {
      ValidatorString validator = ValidatorString('test 123').noDigits();
      expect(validator.build(), 'Can not contain any digits');

      validator = ValidatorString('test abc def').noDigits();
      expect(validator.build(), null);

      validator = ValidatorString('test abc def 12345').digitsOnly();
      expect(validator.build(), 'Digits only');

      validator = ValidatorString('19201010112345').digitsOnly();
      expect(validator.build(), null);

      expect(validator.minLen(14).build(), null);
      expect(validator.minLen(15).build(), 'Min length is 15');

      validator = ValidatorString('abc def');
      expect(validator.noWhitespace().build(), 'Can not contain white space');

      validator = ValidatorString('10/111.222-333');
      expect(validator.noSpecialChars('_').build(), null);

      validator = ValidatorString('10/111.222-333');
      expect(validator.noSpecialChars('/-').build(),
          'Can not contain special characters /-');
    });
  });
}
