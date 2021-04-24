import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/flutterfly.dart';

void main() {
  group('utils', () {
    test('conn', () async {
      bool connected = await ConnUtil.checkConnection();
      expect(connected, true);
    });
  });
}
