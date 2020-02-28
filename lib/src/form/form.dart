import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class FlyFormController {
  void onChanged(VoidCallback callback);
  bool validate();
  void save();
}

class FlyForm<T> extends StatefulWidget {
  final T model;
  final bool autovalidate;
  final Widget Function(
      BuildContext context, FlyFormController controller, T model) builder;

  FlyForm(
      {@required this.builder,
      @required this.model,
      this.autovalidate = false});

  @override
  FlyFormState<T> createState() {
    return FlyFormState<T>();
  }
}

class FlyFormState<T> extends State<FlyForm<T>> implements FlyFormController {
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
