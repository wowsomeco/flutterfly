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

  FlyNumeric(
      {Key key,
      @required this.initialValue,
      @required this.onChanged,
      this.direction = Axis.vertical,
      this.min = 0,
      this.max = 100})
      : super(key: key) {
    assert(initialValue != null);
    assert(onChanged != null);
  }

  @override
  _FlyNumericState createState() => _FlyNumericState();
}

class _FlyNumericState extends State<FlyNumeric> {
  @override
  Widget build(BuildContext context) {
    return FlyCard(
      padding: EdgeInsets.all(5.0),
      direction: widget.direction,
      verticalDirection: widget.direction == Axis.vertical
          ? VerticalDirection.up
          : VerticalDirection.down,
      children: <Widget>[
        InkWell(
          child: Icon(Icons.remove),
          onTap: () => widget.onChanged(
              (widget.initialValue - 1).clamp(widget.min, widget.max)),
        ),
        Padding(
          child: Text(widget.initialValue.toString()),
          padding: EdgeInsets.all(5.0),
        ),
        InkWell(
          child: Icon(Icons.add),
          onTap: () => widget.onChanged(
              (widget.initialValue + 1).clamp(widget.min, widget.max)),
        )
      ],
    );
  }
}
