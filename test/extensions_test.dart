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
      expect(testStr.formatDate(fmt: 'dd MMM yy'), '01 Jan 12');
      testStr = '2012-02-27 13:27:00';
      expect(testStr.formatDate(), '2012-02-27');
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
  });

  group('map_extensions', () {
    test('mapper', () {
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
}
