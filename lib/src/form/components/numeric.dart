import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';

/// Handles range number input ranged from [min] to [max]
/// It uses [FlyCard] internally as the wrapper.
///
/// Vertical looks (default) :
///
/// -----
/// | + |
/// | 0 |
/// | - |
/// -----
///
/// Horizontal looks :
///
/// -----------
/// | -  0  + |
/// -----------
class FlyNumeric extends StatefulWidget {
  /// the model
  final int initialValue;

  /// the callback that is called whenever the [initialValue] changes.
  /// the parent where this widget resides, should process the new value provided
  /// and re-render its state accordingly
  final void Function(int) onChanged;

  /// direction of the widget, default is [Axis.vertical]
  final Axis direction;
  final int min;
  final int max;
  final ShapeBorder border;

  FlyNumeric(
      {Key key,
      @required this.initialValue,
      @required this.onChanged,
      this.direction = Axis.vertical,
      this.min = 0,
      this.max = 100,
      this.border})
      : super(key: key) {
    assert(initialValue != null);
    assert(onChanged != null);
  }

  @override
  _FlyNumericState createState() => _FlyNumericState();
}

class _FlyNumericState extends State<FlyNumeric> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder inputBorder = UnderlineInputBorder();
    ThemeData theme = Theme.of(context);
    return FlyCard(
      padding: EdgeInsets.all(5.0),
      direction: widget.direction,
      border: widget.border,
      verticalDirection: widget.direction == Axis.vertical
          ? VerticalDirection.up
          : VerticalDirection.down,
      children: <Widget>[
        InkWell(
          child: Icon(Icons.remove_circle_outline,
              color: widget.initialValue == widget.min
                  ? Colors.black87
                  : theme.accentColor),
          onTap: () => _changeValue(widget.initialValue - 1),
        ),
        Container(
          width: 60.0,
          child: TextFormField(
            controller: _controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                enabledBorder: inputBorder,
                focusedBorder: inputBorder.copyWith(
                    borderSide: BorderSide(color: theme.primaryColor))),
            keyboardType: TextInputType.number,
            onEditingComplete: () {
              _changeValue(int.parse(_controller.text));
              FocusScope.of(context).requestFocus(FocusNode());
            },
            // dont update parent widget until editing complete
            onChanged: (v) =>
                _changeValue(int.parse(v), shouldUpdateWidget: false),
          ),
        ),
        InkWell(
          child: Icon(
            Icons.add_circle_outline,
            color: theme.accentColor,
          ),
          onTap: () => _changeValue(widget.initialValue + 1),
        )
      ],
    );
  }

  void _changeValue(int v, {bool shouldUpdateWidget = true}) {
    int newValue = v.clamp(widget.min, widget.max);
    _controller.text = newValue.toString();
    if (shouldUpdateWidget) {
      widget.onChanged(newValue);
    }
  }
}
