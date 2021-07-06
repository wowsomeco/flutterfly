import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/flutterfly.dart';
import 'package:flutterfly/src/common/utils/dynamic_utils.dart';

class ObjectTest {
  late String value;
  late int number;

  ObjectTest(Map json) {
    value = json['value'];
    number = json['number'];
  }
}

void main() {
  group('strings', () {
    test('capitalize', () {
      String? testStr;
      expect(testStr.capitalize(), null);
      testStr = 'abcdefghi';
      expect(testStr.capitalize(), 'Abcdefghi');
      testStr = 'abc def ghi jkl mno pqr stu vwx yz';
      final stopwatch = Stopwatch()..start();
      expect(testStr.capitalize(), 'Abc Def Ghi Jkl Mno Pqr Stu Vwx Yz');
      print('${stopwatch.elapsed}');
      testStr = 'ab-ab-ab';
      expect(testStr.capitalize(separator: '-', replaceWith: '-'), 'Ab-Ab-Ab');
      testStr = 'abc-def';
      expect(testStr.capitalize(separator: '-'), 'Abc Def');
    });

    test('formatDate', () {
      String? testStr;
      expect(testStr.formatDate(), null);
      testStr = '2012-01-01';
      expect(testStr.formatDate(fmt: 'dd MMM yy', strict: false), '01 Jan 12');
      testStr = '2012-02-27 13:27:00';
      expect(testStr.formatDate(strict: false), '2012-02-27');
      testStr = '2020-02-22';
      expect(testStr.formatDate(fmt: 'dd MMM yy', strict: false), '22 Feb 20');
    });

    test('isValidDate', () {
      String? testStr;
      expect(testStr.isValidDate(), false);
      testStr = '2012-01-01';
      expect(testStr.isValidDate(), true);
      testStr = '2012-02-27 13:27:00';
      expect(testStr.isValidDate(fmt: 'yyyy-MM-dd HH:mm:ss'), true);
      testStr = '2012-02-27-21';
      expect(testStr.isValidDate(), false);
      testStr = '2012-21-13';
      expect(testStr.isValidDate(), false);
      testStr = '2010-30-30';
      expect(testStr.isValidDate(), false);
      testStr = '2020-13-10';
      expect(testStr.isValidDate(), false);
      testStr = '2020-02-28';
      expect(testStr.isValidDate(), true);
    });

    test('intersects', () {
      String str1 = 'table';
      String str2 = 'bad';
      expect(str1.intersects(str2), true);
      expect(str2.intersects(str1), true);
      str2 = 'xy';
      expect(str1.intersects(str2), false);
      expect(str2.intersects(str1), false);
    });

    test('containsDigit', () {
      String? testStr;
      expect(testStr.containsDigit(), false);
      testStr = '2012-01-01';
      expect(testStr.containsDigit(), true);
      testStr = 'Test !@#^&*()_+';
      expect(testStr.containsDigit(), false);
      testStr = 'Test <>?|[]~';
      expect(testStr.containsDigit(), false);
      testStr = 'Test123';
      expect(testStr.containsDigit(), true);
      testStr = 'I like to eat apples and bananas';
      expect(testStr.containsDigit(), false);
    });

    test('digitsOnly', () {
      String? testStr;
      expect(testStr.isDigitOnly(), false);
      testStr = '2012-01-01';
      expect(testStr.isDigitOnly(), false);
      testStr = 'Test !@#^&*()_+';
      expect(testStr.isDigitOnly(), false);
      testStr = '12345678910';
      expect(testStr.isDigitOnly(), true);
      testStr = 'Test123';
      expect(testStr.isDigitOnly(), false);
      testStr = 'I like 123 456';
      expect(testStr.isDigitOnly(), false);
    });

    test('isValidEmail', () {
      String? testStr;
      expect(testStr.isValidEmail(), false);
      testStr = 'aaa@';
      expect(testStr.isValidEmail(), false);
      testStr = 'aaa@a';
      expect(testStr.isValidEmail(), false);
      testStr = 'aaa@a.com';
      expect(testStr.isValidEmail(), true);
    });

    test('containsAny', () {
      String? testStr = 'abc def';
      expect(testStr.containsAny(' '), true);
      testStr = 'aaabbbccc!@#';
      expect(testStr.containsAny(' '), false);
      testStr = 'aaa bbb ccc! @#';
      expect(testStr.containsAny(' '), true);
      testStr = 'aaa bbb ccc *()#';
      expect(testStr.containsAny('-+=!'), false);
      expect(testStr.containsAny('()'), true);
      expect(testStr.containsAny('#'), true);
      expect(testStr.containsAny('*'), true);
    });
  });

  group('map_extensions', () {
    test('hasValue', () {
      Map m = {'id': 1, 'name': 'A'};
      expect(m.hasValue('id'), true);
      expect(m.hasValue('name'), true);
      expect(m.hasValue('nama'), false);
    });

    test('tryCast', () {
      Map m = {
        'id': 1,
        'test': {'value': 'A', 'number': 1}
      };
      ObjectTest? t = m.tryCast('test', (item) => ObjectTest(item));

      expect(t != null, true);
      expect(t!.value, 'A');
      expect(t.number, 1);

      ObjectTest? u = m.tryCast('tests', (item) => ObjectTest(item));
      expect(u == null, true);
    });

    test('toList', () {
      String jsonStr = """
      {
        "id": "file",
        "value": "File",
        "strings": ["foo", "bar", "baz"],
        "ints": [0,1,2,3],
        "objects": [
          {"value": "New", "number": 1},
          {"value": "Open", "number": 2},
          {"value": "Close", "number": 3}
        ]
      }      
      """;

      Map m = json.decode(jsonStr);

      // test parse string
      List<String>? strings = m.toList('strings', (item) => item);
      expect(strings!.length, 3);
      expect(strings, ["foo", "bar", "baz"]);

      // test parse int
      List<int>? ints =
          m.toList('ints', (item) => DynamicUtils.tryCast<int>(item) ?? -1);
      expect(ints!.length, 4);
      expect(ints, [0, 1, 2, 3]);
      expect(ints.fold<int>(0, (p, cur) => p + cur), 6);

      // test parse to a class
      List<ObjectTest>? objects =
          m.toList('objects', (item) => ObjectTest(item));
      expect(objects!.length, 3);
      objects.forEach((element) {
        expect(element.number, isNot(0));
        expect(element.value, isNotEmpty);
      });
      expect(objects.fold<int>(0, (p, element) => p + element.number), 6);

      // try to convert the key that exists but is not an array type
      List<String>? id = m.toList('id', (item) => item.toString());
      expect(id, null);

      // try to convert the key that dont exist, it must return `[]` since no fallback is defined
      List<String>? nameList =
          m.toList('name', (item) => item.toString(), fallback: []);
      expect(nameList!.length, 0);
      expect(nameList, []);
    });
  });

  group('datetime_extensions', () {
    test('age', () {
      String? dateStr = '2000-10-10';
      // assuming today is year 07-05-2021
      DateTime now = DateTime.parse('2021-05-07');
      expect(dateStr.toDateTime().age(until: now), 21);
      dateStr = '2001-05-07';
      expect(dateStr.toDateTime().age(until: now), 20);
      dateStr = '2001-05-06';
      expect(dateStr.toDateTime().age(until: now), 19);
      dateStr = '2001-05-01';
      expect(dateStr.toDateTime().age(until: now), 19);
      dateStr = '2001-05-08';
      expect(dateStr.toDateTime().age(until: now), 20);
      dateStr = '1001-10-10';
      expect(dateStr.toDateTime().age(until: now), 1020);
      dateStr = '1901-10-10';
      expect(dateStr.toDateTime().age(until: now), 120);
      dateStr = '2012-02-27 13:27:00';
      expect(dateStr.toDateTime().age(until: now), 9);
      dateStr = '2011-02-27 13:27:00.123456789z';
      expect(dateStr.toDateTime().age(until: now), 10);
      dateStr = '+19870227';
      expect(dateStr.toDateTime().age(until: now), 34);
      dateStr = '1880-02-27T14Z';
      expect(dateStr.toDateTime().age(until: now), 141);
      // test null
      dateStr = null;
      expect(dateStr.toDateTime().age(until: now), null);
      // test invalid date should return null
      dateStr = '2001-110-110';
      expect(dateStr.toDateTime().age(until: now), null);
    });
  });
}
