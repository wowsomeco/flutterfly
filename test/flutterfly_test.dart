import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/flutterfly.dart';
import '../example/lib/form_page.dart';

class TestApp extends StatefulWidget {
  final TestFormModel model;

  TestApp({@required this.model});

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form Test',
        theme: flyThemeData(),
        home: Scaffold(
          appBar: AppBar(),
          body: FormPage(
            model: widget.model,
          ),
        ));
  }
}

void main() {
  group('Form', () {
    testWidgets('Fill Model Test', (WidgetTester tester) async {
      TestApp app = TestApp(
        model: TestFormModel(),
      );

      await tester.pumpWidget(app);

      Finder fieldString = find.byKey(Key(FieldString));
      await tester.enterText(fieldString, 'Jemmy Irawan');

      expect(app.model.id, null);
      expect(app.model.testString, 'Jemmy Irawan');
    });
  });
}
