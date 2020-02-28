import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '_input_decorator.dart';

/// Shows an Input Field with a [Checkbox] in it
class FlyCheckbox extends FormField<bool> {
  final String label;
  final void Function(bool v) onChanged;

  FlyCheckbox({
    Key key,
    bool initialValue,
    bool autovalidate = false,
    bool tristate = false,
    FormFieldValidator<bool> validator,
    @required this.label,
    @required this.onChanged,
  }) : super(
            key: key,
            initialValue: initialValue,
            autovalidate: autovalidate,
            validator: validator,
            builder: (FormFieldState<bool> state) {
              return InputDecorator(
                decoration: flyInputDecorWithError(state).copyWith(
                    prefixText: label,
                    suffixIcon: Checkbox(
                      tristate: tristate,
                      value: initialValue,
                      onChanged: (v) {
                        state.didChange(v);
                        onChanged(v);
                      },
                    )),
              );
            });
}
