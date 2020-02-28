import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';

final Widget gutter = Padding(
  padding: EdgeInsets.all(5),
);

void main() => runApp(TestApp(
      model: FormModel(),
    ));

const String FieldString = 'Field String';
const String FieldCheckbox = 'Field Checkbox';
const String FieldDatepicker = 'Field Datepicker';
const String FieldDropdownString = 'Field Dropdown String';
const String FieldDropdownInt = 'Field Dropdown Int';

class DropdownModel {
  int id;
  String name;

  DropdownModel({this.id, this.name});
}

class FormModel {
  int id;
  String testString;
  String testDate;
  bool testBool;
  String testDropdownString;
  int testDropdownInt;
}

class TestApp extends StatefulWidget {
  final FormModel model;

  TestApp({@required this.model});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form Test',
        theme: flutterflyThemeData(),
        home: Scaffold(
            appBar: AppBar(),
            body: Padding(
              child: _buildForm(),
              padding: EdgeInsets.all(15),
            )));
  }

  Widget _buildForm() {
    return FormBuilder<FormModel>(
      model: widget.model,
      builder: (context, controller, model) {
        Widget formFields = Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.check),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => controller.validate(),
                  label: Text(
                    'Validate',
                  ),
                ),
              ],
            ),
            gutter,
            TextFormField(
                key: Key(FieldString),
                decoration: InputDecoration(labelText: FieldString),
                initialValue: model.testString,
                validator: FormValidators.required(),
                onChanged: (value) {
                  controller.onChanged(() {
                    model.testString = value;
                  });
                }),
            gutter,
            CheckboxFormField(
              key: Key(FieldCheckbox),
              label: FieldCheckbox,
              tristate: true,
              initialValue: model.testBool,
              onChanged: (v) {
                controller.onChanged(() {
                  model.testBool = v;
                });
              },
              validator: FormValidators.required(),
            ),
            gutter,
            DatepickerFormField(
              key: Key(FieldDatepicker),
              decoration: InputDecoration(labelText: FieldDatepicker),
              initialValue: model.testDate,
              firstDate: DateTime(1900),
              lastDate: DateTime.now().add(Duration(days: 1)),
              onChanged: (v) {
                controller.onChanged(() {
                  model.testDate = v;
                });
              },
              validator: FormValidators.required(),
            ),
            gutter,
            DropdownFormField<String, String>(
                label: FieldDropdownString,
                validator: FormValidators.required(),
                initialValue: model.testDropdownString,
                onChanged: (v) {
                  controller.onChanged(() {
                    model.testDropdownString = v;
                  });
                  return v;
                },
                optionKey: (v) => v,
                options: () async => <String>['Test 1', 'Test 2']),
            gutter,
            DropdownFormField<int, DropdownModel>(
              label: FieldDropdownInt,
              validator: FormValidators.required(),
              initialValue: model.testDropdownInt,
              onChanged: (v) {
                controller.onChanged(() {
                  model.testDropdownInt = v.id;
                });
                return model.testDropdownInt;
              },
              optionKey: (v) => v?.name,
              options: () async {
                await Future.delayed(Duration(seconds: 1));
                return _buildDropdownModelOptions();
              },
            )
          ],
        );
        return SingleChildScrollView(
          child: formFields,
        );
      },
    );
  }

  List<DropdownModel> _buildDropdownModelOptions() {
    List<DropdownModel> options = [];
    for (int i = 0; i < 15; i++) {
      options.add(DropdownModel(id: i + 1, name: 'Test Name ${i + 1}'));
    }
    return options;
  }
}
