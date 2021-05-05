import 'dart:async';

/// Forces a function to wait a certain amount of [delay] time before running again
///
/// ### Example
///
/// ```dart
/// class Foo {
///   final Debounce _debounce = Debounce();
///
///   void doSomethingValueChange() {
///     // this func gets called after postponing it for every 250ms delay.
///     _debounce.exec(() => fetchFromTheServer());
///   }
///
///   void fetchFromTheServer() {
///     // call http request here...
///   }
/// }
/// ```
class Debounce {
  Timer? _timer;

  void exec(Function callback, {int delay = 250}) {
    cancel();
    _timer = Timer(Duration(milliseconds: delay), () => callback());
  }

  void cancel() => _timer?.cancel();
}
