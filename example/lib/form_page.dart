import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';

const String FieldString = 'Field String';
const String FieldCheckbox = 'Field Checkbox';
const String FieldDatepicker = 'Field Datepicker';
const String FieldDropdownString = 'Field Dropdown String';
const String FieldDropdownInt = 'Field Dropdown Int';

final Widget gutter = Padding(
  padding: EdgeInsets.all(5),
);

class TestDropdownModel {
  int id;
  String name;

  TestDropdownModel({this.id, this.name});
}

class TestFormModel {
  int id;
  String testString;
  String testDate;
  bool testBool;
  String testDropdownString;
  int testDropdownInt;
}

class FormPage extends StatefulWidget {
  final TestFormModel model;

  FormPage({this.model});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    Widget form = FlyForm<TestFormModel>(
      model: widget.model,
      builder: (context, controller, model) {
        Widget formFields = Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlyButton(
                  loading: _submitting,
                  icon: Icons.check,
                  onPressed: () {
                    if (controller.validate()) {
                      setState(() {
                        _submitting = true;
                        Future.delayed(Duration(seconds: 1),
                            () => setState(() => _submitting = false));
                      });
                    }
                  },
                  label: 'Validate',
                ),
              ],
            ),
            gutter,
            TextFormField(
                key: Key(FieldString),
                decoration: InputDecoration(labelText: FieldString),
                initialValue: model.testString,
                validator: FlyFormValidator.required(),
                onChanged: (value) {
                  controller.onChanged(() {
                    model.testString = value;
                  });
                }),
            gutter,
            FlyCheckbox(
              key: Key(FieldCheckbox),
              label: FieldCheckbox,
              tristate: true,
              initialValue: model.testBool,
              onChanged: (v) {
                controller.onChanged(() {
                  model.testBool = v;
                });
              },
              validator: FlyFormValidator.required(),
            ),
            gutter,
            FlyDatepicker(
              key: Key(FieldDatepicker),
              label: FieldDatepicker,
              initialValue: model.testDate,
              onChanged: (v) {
                controller.onChanged(() {
                  model.testDate = v;
                });
              },
              validator: FlyFormValidator.required(),
            ),
            gutter,
            FlyDropdown<String, String>(
                label: FieldDropdownString,
                validator: FlyFormValidator.required(),
                initialValue: model.testDropdownString,
                onChanged: (v) {
                  controller.onChanged(() {
                    model.testDropdownString = v;
                  });
                },
                optionKey: (v) => v,
                optionValue: (v) => v,
                options: () async => <String>['Test 1', 'Test 2']),
            gutter,
            FlyDropdown<int, TestDropdownModel>(
              label: FieldDropdownInt,
              validator: FlyFormValidator.required(),
              initialValue: model.testDropdownInt,
              onChanged: (v) {
                controller.onChanged(() {
                  model.testDropdownInt = v.id;
                });
              },
              optionValue: (v) => v?.name,
              optionKey: (v) => v?.id,
              options: () async {
                // here we're trying to mimic the delay of fetching the data from the server
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
    // return widget
    return Padding(
      padding: EdgeInsets.all(15),
      child: form,
    );
  }

  List<TestDropdownModel> _buildDropdownModelOptions() {
    List<TestDropdownModel> options = [];
    for (int i = 0; i < 15; i++) {
      options.add(TestDropdownModel(id: i + 1, name: 'Test Name ${i + 1}'));
    }
    return options;
  }
}
