import 'package:flutter/material.dart';

/// A Dropdown Form Component
///
/// This widget takes a generic [initialValue]
/// where the options can be the same type as the [initialValue]
/// or can also differ where it could be used to
/// build a List of class based dropdown model
class FlyDropdown<T, U> extends StatefulWidget {
  final String label;
  final T initialValue;
  final bool autovalidate;
  final FormFieldValidator<T> validator;
  final T Function(U) onChanged;
  final T Function(U) optionKey;
  final String Function(U) optionValue;
  final Future<List<U>> Function() options;

  FlyDropdown(
      {Key key,
      this.initialValue,
      this.autovalidate = false,
      this.validator,
      @required this.label,
      @required this.optionValue,
      @required this.onChanged,
      @required this.optionKey,
      @required this.options})
      : super(
          key: key,
        );

  @override
  _FlyDropdownState<T, U> createState() => _FlyDropdownState<T, U>();
}

/// The current state of the [FlyDropdown]
class _FlyDropdownState<T, U> extends State<FlyDropdown<T, U>> {
  Map<T, U> _options = {};
  U _selected;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // fetch the select options on init
    fetchOptions();
  }

  void fetchOptions() async {
    // set loading, just in case the options need to be fetched from a server
    setState(() {
      _loading = true;
    });
    // map the options to <T,U> accordingly
    List<U> options = await widget.options();
    for (int i = 0; i < options.length; i++) {
      U u = options[i];
      T k = widget.optionKey(u);
      _options[k] = u;
      // check against the initial value
      if (widget.initialValue == k) {
        _selected = u;
      }
    }
    // loading = false on done fetching
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      builder: (FormFieldState<T> state) {
        final InputDecoration effectiveDecoration = InputDecoration()
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(
                errorText: state.errorText,
                labelText: widget.label,
                prefixText: widget.optionValue(_selected),
                suffix: _loading == true ? _buildLoading() : null,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                ));
        return InkWell(
            onTap: () {
              // only show the option dialog when the options have been loaded successfully
              if (!_loading) showOptions(context, state);
            },
            child: InputDecorator(
              decoration: effectiveDecoration,
            ));
      },
    );
  }

  Future<void> showOptions(
      BuildContext context, FormFieldState<T> state) async {
    // set focus
    FocusScope.of(context).requestFocus(FocusNode());
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setter) {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: _buildOptions(context, (selected) {
                            _selected = selected;
                            state.didChange(widget.onChanged(selected));
                          }),
                        ),
                      ),
                    )
                  ],
                ));
          });
        });
  }

  List<Widget> _buildOptions(BuildContext context, Function(U) selected) {
    List<Widget> widgets = [];
    ThemeData theme = Theme.of(context);
    _options.forEach((k, v) {
      widgets.add(InkWell(
        onTap: () {
          selected(v);
          Navigator.pop(context);
        },
        child: Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.optionValue(v),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (_selected == v)
                          Icon(
                            Icons.check,
                            color: theme.accentColor,
                          )
                      ],
                    ),
                    Divider(),
                  ],
                ))),
      ));
    });
    return widgets;
  }

  Widget _buildLoading() {
    double size = 12.0;
    return Container(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ));
  }
}
