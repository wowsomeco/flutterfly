import 'package:flutter/material.dart';
import 'home_page.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() => runApp(FlyApp());

class FlyApp extends StatefulWidget {
  @override
  _FlyAppState createState() => _FlyAppState();
}

class _FlyAppState extends State<FlyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'JosefinSans'),
        title: 'View Test',
        navigatorObservers: [routeObserver],
        home: _Layout());
  }
}

class _Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: HomePage(),
      )),
    );
  }
}
