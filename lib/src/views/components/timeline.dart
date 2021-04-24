import 'package:flutter/material.dart';

class FlyTimelineItem {
  final Widget? icon;
  final Widget? prefix;
  final Widget? suffix;
  final bool isActive;

  FlyTimelineItem({this.icon, this.prefix, this.suffix, this.isActive = false});

  Widget build(BuildContext context, FlyTimeline t, bool isLast) {
    ThemeData theme = Theme.of(context);
    Color? lineColor = isActive ? theme.primaryColor : Colors.grey[350];
    return Flex(
      direction:
          t.direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prefix ?? SizedBox.shrink(),
        Flex(
          direction: t.direction,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(color: lineColor, shape: BoxShape.circle),
              child: icon ?? SizedBox.shrink(),
            ),
            if (!isLast)
              Container(
                width:
                    t.direction == Axis.horizontal ? t.lineHeight : t.lineWidth,
                height:
                    t.direction == Axis.horizontal ? t.lineWidth : t.lineHeight,
                decoration:
                    BoxDecoration(color: lineColor, shape: BoxShape.rectangle),
              )
          ],
        ),
        suffix ?? SizedBox.shrink(),
      ],
    );
  }
}

class FlyTimeline extends StatefulWidget {
  final Axis direction;
  final List<FlyTimelineItem> children;
  final double lineWidth;
  final double lineHeight;
  final EdgeInsetsGeometry padding;

  FlyTimeline(
      {Key? key,
      this.direction = Axis.vertical,
      this.children = const <FlyTimelineItem>[],
      this.lineHeight = 50.0,
      this.lineWidth = 2.0,
      this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  _FlyTimelineState createState() => _FlyTimelineState();
}

class _FlyTimelineState extends State<FlyTimeline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: widget.direction,
        children: _buildItems(context),
      ),
      padding: widget.padding,
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < widget.children.length; i++) {
      items.add(widget.children[i]
          .build(context, widget, i == widget.children.length - 1));
    }
    return items;
  }
}
