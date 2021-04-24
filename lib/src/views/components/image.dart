import 'package:flutter/material.dart';

/// A Widget for URL Image.
/// it calls [Image.network] internally.
/// while it's being loaded, it shows [CircularProgressIndicator] indicating the current download progress.
/// Currently it has limitation where it might crash the app when the url can't be found.
/// https://github.com/flutter/flutter/issues/20910
class FlyImage extends StatefulWidget {
  /// the http url path of the image to download
  final String? url;

  /// the aspect ratio of the image. you might set it to 16.0 / 9.0 for instance to make it 16:9
  final double aspectRatio;

  /// will cache the image if it's set to true so it will load faster for the next time.
  final bool shouldCache;

  /// the error icon to show when the url is null, the default is [Icons.insert_photo] if not provided
  final Widget? errorIcon;

  FlyImage(
      {Key? key,
      @required this.url,
      this.aspectRatio = 16.0 / 9.0,
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
      precacheImage(NetworkImage(widget.url!), context);
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
            widget.url!,
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
                              progress.expectedTotalBytes!
                          : null));
            },
          );
    return AspectRatio(aspectRatio: widget.aspectRatio, child: img);
  }
}
