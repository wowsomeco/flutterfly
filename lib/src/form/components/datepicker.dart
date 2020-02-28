import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '_input_decorator.dart';

/// Handles Input for Date
/// the model is String of Date
class FlyDatepicker extends StatefulWidget {
  /// the label of the [FlyDatepicker]
  final String label;

  /// the model
  final String initialValue;
  final FormFieldValidator<String> validator;
  final bool autovalidate;
  final void Function(String v) onChanged;

  /// the left limit of the [showDatePicker]
  final DateTime firstDate;

  /// the right limit of the [showDatePicker]
  final DateTime lastDate;

  /// the format for the date to be shown in the input field
  final String labelFormat;

  /// the format for the [initialValue]
  final String valueFormat;

  FlyDatepicker(
      {Key key,
      @required this.onChanged,
      this.label,
      this.initialValue,
      this.autovalidate = false,
      this.validator,
      this.labelFormat = 'dd MMM yyyy',
      this.valueFormat = 'yyyy-MM-dd',
      DateTime firstDate,
      DateTime lastDate})
      : firstDate = firstDate ?? DateTime(1920),
        lastDate = lastDate ?? DateTime.now().add(Duration(days: 1)),
        super(key: key);

  @override
  _FlyDatepickerState createState() => _FlyDatepickerState();
}

class _FlyDatepickerState extends State<FlyDatepicker> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = DateFormat(widget.labelFormat)
          .format(DateTime.parse(widget.initialValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      decoration: flyInputDecor(context).copyWith(labelText: widget.label),
      readOnly: true,
      onTap: () => showPicker(context),
    );
  }

  Future<void> showPicker(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    // show the datepicker
    DateTime newValue = await showDatePicker(
        context: context,
        initialDate: widget.initialValue == null
            ? DateTime.now()
            : DateTime.parse(widget.initialValue),
        firstDate: widget.firstDate,
        lastDate: widget.lastDate);
    // update value from the datepicker only if it's not null
    if (newValue != null) {
      // the formatted date string of the model
      String dateStr = DateFormat(widget.valueFormat).format(newValue);
      // update the input text according to what's defined in the labelFormat
      _controller.text =
          DateFormat(widget.labelFormat).format(DateTime.parse(dateStr));
      widget.onChanged(dateStr);
    }
  }
}
