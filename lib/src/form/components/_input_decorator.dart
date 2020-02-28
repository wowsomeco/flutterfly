import 'package:flutter/material.dart';

final InputDecoration Function(BuildContext) flyInputDecor = (context) =>
    InputDecoration().applyDefaults(Theme.of(context).inputDecorationTheme);

final InputDecoration Function(FormFieldState) flyInputDecorWithError =
    (state) =>
        flyInputDecor(state.context).copyWith(errorText: state.errorText);
