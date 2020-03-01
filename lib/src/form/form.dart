import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// The [FlyForm] controller.
abstract class FlyFormController {
  /// Rebuilds the state of the [FlyForm] when called.
  /// normally it gets called when one of the fields changes its value
  void onChanged(VoidCallback callback);

  /// Validates the Form Fields in [FlyForm] when called.
  /// Returns false when there are more than one field that's still not valid.
  /// Returns true if otherwise
  bool validate();
}

/// A wrapper for Flutter Material [Form]
///
/// ideally it is used to build a form
/// that takes a generic model that is generally a class
class FlyForm<T> extends StatefulWidget {
  /// The generic model of the form.
  final T model;
  final bool autovalidate;

  /// the callback function that returns [BuildContext], [FlyFormController], and the [model] itself.
  ///
  final Widget Function(
      BuildContext context, FlyFormController controller, T model) builder;

  FlyForm(
      {@required this.builder,
      @required this.model,
      this.autovalidate = false});

  @override
  _FlyFormState<T> createState() {
    return _FlyFormState<T>();
  }
}

class _FlyFormState<T> extends State<FlyForm<T>> implements FlyFormController {
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
}
