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

      validator = ValidatorNumber(null).required();
      expect(validator.build(), 'Field is required');

      validator = ValidatorNumber(10).required();
      expect(validator.build(), null);

      validator = ValidatorNumber(-1).required();
      expect(validator.build(), null);
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

      validator = ValidatorString(null);
      expect(validator.validDate().build(), 'Not a valid date');

      validator = ValidatorString('2021-30-02');
      expect(validator.validDate().build(), 'Not a valid date');

      validator = ValidatorString('2021-02-28');
      expect(validator.validDate().build(), null);

      validator = ValidatorString('20/01/2021');
      expect(validator.validDate(format: 'dd/MM/yyyy').build(), null);

      Validator v = ValidatorString('test').length(min: 10);
      expect(v.build(), 'Length must be greater than 10');

      v = ValidatorString(null).length(min: 10);
      expect(v.build(), 'Length must be greater than 10');

      v = ValidatorString('abc de').length(min: 1, max: 5);
      expect(v.build(), 'Length must be between 1 and 5');

      v = ValidatorString('abc def').contains('def');
      expect(v.build(), null);

      v = ValidatorString(null).contains('def');
      expect(v.build(), 'Must contain def');

      v = ValidatorString('abc de').contains('def');
      expect(v.build(), 'Must contain def');

      v = ValidatorString(null).required();
      expect(v.build(), 'Field is required');

      v = ValidatorString('').required();
      expect(v.build(), 'Field is required');

      v = ValidatorString('a').required();
      expect(v.build(), null);
    });
  });
}
