import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class FormController {
  void onChanged(VoidCallback callback);
  bool validate();
  void save();
}

class FormBuilder<T> extends StatefulWidget {
  final T model;
  final bool autovalidate;
  final Widget Function(
      BuildContext context, FormController controller, T model) builder;

  FormBuilder(
      {@required this.builder,
      @required this.model,
      this.autovalidate = false});

  @override
  FormBuilderState<T> createState() {
    return FormBuilderState<T>();
  }
}

class FormBuilderState<T> extends State<FormBuilder<T>>
    implements FormController {
  final _formKey = GlobalKey<FormState>();
  T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidate: widget.autovalidate,
        child: widget.builder(context, this, _model));
  }

  @override
  void onChanged(VoidCallback callback) {
    setState(callback);
  }

  @override
  bool validate() {
    return _formKey.currentState.validate();
  }

  @override
  void save() {
    return _formKey.currentState.save();
  }
}
