import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../example/lib/main.dart';

void main() {
  group('Form', () {
    testWidgets('Fill Model Test', (WidgetTester tester) async {
      TestApp app = TestApp(
        model: FormModel(),
      );

      await tester.pumpWidget(app);

      Finder fieldString = find.byKey(Key(FieldString));
      await tester.enterText(fieldString, 'Jemmy Irawan');
      await tester.tap(find.byKey(Key(FieldCheckbox)));
      await tester.pumpAndSettle();

      expect(app.model.id, null);
      expect(app.model.testString, 'Jemmy Irawan');
    });
  });
}
