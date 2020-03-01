import 'package:flutter/material.dart';

/// A Widget that wraps [Card] internally.
///
/// Inside the card, there is a [Container] that can have [padding]
/// then the [Container] itself contains [Flex] where the direction is determined by [direction]
///
/// This widget has [direction] Axis that is defaulted to [Axis.vertical]
class FlyCard extends StatefulWidget {
  /// direction of the card, either vertical or horizontal
  final Axis direction;

  /// the content(s) of the card
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry margin;

  /// internal padding of the card
  final EdgeInsetsGeometry padding;

  /// the border of the card. it uses the default border defined in [CardTheme] when not defined
  final ShapeBorder border;

  FlyCard(
      {Key key,
      this.direction = Axis.vertical,
      this.children = const <Widget>[],
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.padding = EdgeInsets.zero,
      this.margin = EdgeInsets.zero,
      this.border})
      : super(key: key);

  @override
  _FlyCardState createState() => _FlyCardState();
}

class _FlyCardState extends State<FlyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: widget.margin,
        shape: widget.border,
        child: Container(
            padding: widget.padding,
            child: Flex(
              direction: widget.direction,
              children: widget.children,
              mainAxisAlignment: widget.mainAxisAlignment,
              crossAxisAlignment: widget.crossAxisAlignment,
            )));
  }
}
