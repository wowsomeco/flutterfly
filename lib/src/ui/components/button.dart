import 'package:flutter/material.dart';

/// A flat button that calls [RawMaterialButton] internally
/// We decided to make this component in order to simplify things whereby
/// we wanted to have one universal button that can have label and icon in it.
///
/// If both of the [label] and [icon] are provided OR if only [label] is defined,
/// this by default will create a button with [RoundedRectangleBorder] with radius 20.0
///
/// If only [icon] is provided,
/// this class will create a rounded button with [CircularBorder]
///
/// If [outlined] is true,
/// this created an outlined button with this [color] OR [ThemeData.primaryColor] if the [color] is null
///
/// Otherwise it creates a filled button with this [color] OR [ThemeData.primaryColor] if the [color] is null
class FlyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final ValueChanged<bool> onHighlightChanged;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final bool autofocus;
  final MaterialTapTargetSize materialTapTargetSize;
  final IconData icon;
  final String label;
  final bool loading;

  /// defines the fill color if (!outlined), outline color if (outlined)
  final Color color;

  /// size of the content, default is the labelStyle defined in [ThemeData.inputDecorationTheme]
  final double size;

  /// determines whether the button should be outlined or not
  final bool outlined;

  /// content's padding
  final EdgeInsets padding;
  final double borderRadius;

  const FlyButton(
      {Key key,
      @required this.onPressed,
      this.onLongPress,
      this.onHighlightChanged,
      this.clipBehavior = Clip.none,
      this.focusNode,
      this.autofocus = false,
      this.materialTapTargetSize,
      this.color,
      this.size,
      this.outlined = false,
      this.padding =
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      this.borderRadius = 20.0,
      this.icon,
      this.label,
      this.loading = false})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color bgColor = outlined ? Colors.white : color ?? theme.primaryColor;
    Color textColor = outlined ? color ?? theme.primaryColor : Colors.white;
    double textSize = size ?? theme.inputDecorationTheme.labelStyle.fontSize;
    BorderSide borderSide =
        outlined ? BorderSide(color: textColor, width: 1.5) : BorderSide.none;
    ShapeBorder border = label != null
        ? RoundedRectangleBorder(
            side: borderSide, borderRadius: BorderRadius.circular(borderRadius))
        : CircleBorder(side: borderSide);
    return RawMaterialButton(
      onPressed: loading ? null : onPressed,
      onLongPress: loading ? null : onLongPress,
      onHighlightChanged: onHighlightChanged,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      fillColor: bgColor.withAlpha(loading ? 200 : 255),
      focusElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      elevation: 0,
      shape: border,
      padding: padding,
      constraints: BoxConstraints(
          minWidth: textSize + padding.horizontal,
          minHeight: textSize + padding.vertical),
      child: _buildContent(textColor, textSize),
    );
  }

  Widget _buildContent(Color textColor, double textSize) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null)
              Icon(
                icon,
                size: textSize,
                color: textColor.withAlpha(loading ? 0 : 255),
              ),
            if (icon != null && label != null)
              SizedBox(
                width: 10.0,
              ),
            if (label != null)
              Text(
                label,
                style: TextStyle(
                  color: textColor.withAlpha(loading ? 0 : 255),
                ),
              )
          ],
        ),
        if (loading)
          SizedBox(
              width: textSize,
              height: textSize,
              child: CircularProgressIndicator(
                backgroundColor: textColor,
                strokeWidth: 2.0,
              ))
      ],
    );
  }
}
