import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DatepickerFormField extends StatefulWidget {
  final String initialValue;
  final FormFieldValidator<String> validator;
  final InputDecoration decoration;
  final bool autovalidate;
  final void Function(String v) onChanged;
  final DateTime firstDate;
  final DateTime lastDate;
  final String labelFormat;
  final String valueFormat;

  DatepickerFormField(
      {Key key,
      this.initialValue,
      this.autovalidate = false,
      this.validator,
      this.decoration = const InputDecoration(),
      this.labelFormat = 'dd MMM yyyy',
      this.valueFormat = 'yyyy-MM-dd',
      @required this.onChanged,
      @required this.firstDate,
      @required this.lastDate})
      : super(key: key);

  @override
  _DatepickerFormFieldState createState() => _DatepickerFormFieldState();
}

class _DatepickerFormFieldState extends State<DatepickerFormField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration =
        widget.decoration.applyDefaults(Theme.of(context).inputDecorationTheme);
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      decoration: effectiveDecoration,
      readOnly: true,
      onTap: () => showPicker(context),
    );
  }

  Future<void> showPicker(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime newValue = await showDatePicker(
        context: context,
        initialDate: widget.initialValue == null
            ? DateTime.now()
            : DateTime.parse(widget.initialValue),
        firstDate: widget.firstDate,
        lastDate: widget.lastDate);
    // update value only if it's not null
    if (newValue != null) {
      String dateStr = DateFormat(widget.valueFormat).format(newValue);
      _controller.text =
          DateFormat(widget.labelFormat).format(DateTime.parse(dateStr));
      widget.onChanged(dateStr);
    }
  }
}
