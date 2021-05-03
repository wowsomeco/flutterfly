import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Form form = Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Test No whitespace and digits'),
            validator: (v) =>
                ValidatorString(v).noWhitespace().noDigits().build(),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Test Min Length'),
            validator: (v) => ValidatorString(v).minLen(5).build(),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Test Special Characters'),
            validator: (v) =>
                ValidatorString(v).noSpecialChars("!@#\$%^&*()").build(),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Test Number Between 10 and 20'),
            keyboardType: TextInputType.number,
            validator: (v) => ValidatorNumber(v).between(10, 20).build(),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Test Less Than 5 and Positive'),
            keyboardType: TextInputType.number,
            validator: (v) => ValidatorNumber(v).lt(5).positive().build(),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Test Optional Less Than 10'),
            keyboardType: TextInputType.number,
            validator: (v) => ValidatorNumber(v).lt(10).optional().build(),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Test Greater Than 5'),
            keyboardType: TextInputType.number,
            validator: (v) => ValidatorNumber(v).gt(5).build(),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Test Optional Greater Than 10'),
            keyboardType: TextInputType.number,
            validator: (v) => ValidatorNumber(v).gt(10).optional().build(),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Test Positive value'),
            keyboardType: TextInputType.number,
            validator: (v) => ValidatorNumber(v).positive().build(),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Test Optional Positive value'),
            keyboardType: TextInputType.number,
            validator: (v) => ValidatorNumber(v).positive().optional().build(),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Test Email'),
            validator: (v) => ValidatorString(v).email().build(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      child: form,
    );
  }
}
