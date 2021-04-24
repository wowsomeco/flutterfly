import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestApp extends StatefulWidget {
  TestApp();

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form Test',
        home: Scaffold(
          appBar: AppBar(),
          body: SizedBox.shrink(),
        ));
  }
}

void main() {
  group('Components', () {
    testWidgets('Widget Tests', (WidgetTester tester) async {
      // TODO: properly test the view components later

      // TestApp app = TestApp(
      //   model: TestFormModel(),
      // );
      // await tester.pumpWidget(app);
      // Finder fieldString = find.byKey(Key(FieldString));
      // await tester.enterText(fieldString, 'Jemmy Irawan');
      // expect(app.model.id, null);
      // expect(app.model.testString, 'Jemmy Irawan');
    });
  });
}
