import 'package:flutter/material.dart';

class FlyImage extends StatefulWidget {
  final String url;
  final double aspectRatio;
  final bool shouldCache;
  final Widget errorIcon;

  FlyImage(
      {Key key,
      @required this.url,
      @required this.aspectRatio,
      this.shouldCache = false,
      this.errorIcon})
      : super(key: key);

  @override
  _FlyImageState createState() => _FlyImageState();
}

class _FlyImageState extends State<FlyImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // check whether the image should be cached ?
    if (widget.url != null && widget.shouldCache) {
      precacheImage(NetworkImage(widget.url), context);
    }
    // if the widget url is null, show the default icon
    Widget img = widget.url == null
        ? widget.errorIcon ??
            Icon(
              Icons.insert_photo,
              size: 64,
              color: Colors.grey.withAlpha(128),
            )
        : Image.network(
            widget.url,
            fit: BoxFit.fill,
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) {
                return child;
              }
              return Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes
                          : null));
            },
          );
    return AspectRatio(aspectRatio: widget.aspectRatio, child: img);
  }
}
