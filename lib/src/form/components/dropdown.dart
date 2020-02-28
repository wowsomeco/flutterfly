import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlyDropdown<T, U> extends StatefulWidget {
  final String label;
  final T initialValue;
  final bool autovalidate;
  final FormFieldValidator<T> validator;
  final T Function(U) onChanged;
  final String Function(U) optionKey;
  final Future<List<U>> Function() options;

  FlyDropdown(
      {Key key,
      this.initialValue,
      this.autovalidate = false,
      this.validator,
      @required this.label,
      @required this.onChanged,
      @required this.optionKey,
      @required this.options})
      : super(
          key: key,
        );

  @override
  _FlyDropdownState<T, U> createState() => _FlyDropdownState<T, U>();
}

class _FlyDropdownState<T, U> extends State<FlyDropdown<T, U>> {
  List<U> _options;
  U _selected;
  bool _loading = false;

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
                prefixText: widget.optionKey(_selected),
                suffix: _loading == true ? _buildLoading() : null,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                ));
        return InkWell(
            onTap: () => showOptions(context, state),
            child: InputDecorator(
              decoration: effectiveDecoration,
            ));
      },
    );
  }

  Future<void> showOptions(
      BuildContext context, FormFieldState<T> state) async {
    // grab the options
    if (_options == null) {
      // set loading, just in case the options need to be fetched from a server
      setState(() {
        _loading = true;
      });
      // set the options
      _options = await widget.options();
      // loading = false on done fetching
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
    // set focus
    FocusScope.of(context).requestFocus(FocusNode());
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setter) {
            if (_options == null) {
              return _buildLoading();
            }
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
    for (int i = 0; i < _options.length; i++) {
      widgets.add(
        InkWell(
          onTap: () {
            selected(_options[i]);
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
                            widget.optionKey(_options[i]),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (_selected == _options[i])
                            Icon(
                              Icons.check,
                              color: theme.accentColor,
                            )
                        ],
                      ),
                      Divider(),
                    ],
                  ))),
        ),
      );
    }
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
