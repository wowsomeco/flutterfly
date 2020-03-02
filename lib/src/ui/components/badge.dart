import 'package:flutter/material.dart';

class FlyBadge extends StatefulWidget {
  final Icon icon;
  final String badgeContent;
  final void Function() onPressed;

  FlyBadge({@required this.icon, @required this.onPressed, this.badgeContent});

  @override
  _FlyBadgeState createState() => _FlyBadgeState();
}

class _FlyBadgeState extends State<FlyBadge> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
        onTap: widget.onPressed,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: widget.icon,
            ),
            if (widget.badgeContent != null && widget.badgeContent.isNotEmpty)
              Positioned(
                  top: 5,
                  right: 5,
                  child: Material(
                    type: MaterialType.circle,
                    elevation: 1,
                    color: theme.errorColor,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(widget.badgeContent,
                          style: TextStyle(color: Colors.white)),
                    ),
                  ))
          ],
        ));
  }
}
