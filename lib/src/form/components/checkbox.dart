import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              final InputDecoration effectiveDecoration = InputDecoration()
                  .applyDefaults(Theme.of(state.context).inputDecorationTheme)
                  .copyWith(
                      errorText: state.errorText,
                      prefixText: label,
                      suffixIcon: Checkbox(
                        tristate: tristate,
                        value: initialValue,
                        onChanged: (v) {
                          state.didChange(v);
                          onChanged(v);
                        },
                      ));
              return InputDecorator(
                decoration: effectiveDecoration,
              );
            });
}
