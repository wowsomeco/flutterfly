import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/flutterfly.dart';

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
}
