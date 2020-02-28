import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'package:flutterfly_example/home_page.dart';
import 'form_page.dart';

void main() => runApp(FlyApp(
      model: TestFormModel(),
    ));

class FlyApp extends StatefulWidget {
  final TestFormModel model;

  FlyApp({@required this.model});

  @override
  _FlyAppState createState() => _FlyAppState();
}

class _FlyAppState extends State<FlyApp> {
  int _curIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    FormPage(
      model: TestFormModel(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form Test',
        theme: flyThemeData(),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              FlyBadge(
                icon: Icon(
                  Icons.notifications,
                  size: 32,
                  color: Colors.black87,
                ),
                badgeContent: '3',
                onPressed: () {},
              ),
              FlyBadge(
                icon: Icon(
                  Icons.notifications,
                  size: 32,
                  color: Colors.black87,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: _pages[_curIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (idx) {
              setState(() {
                _curIndex = idx;
              });
            },
            currentIndex: _curIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile'))
            ],
          ),
        ));
  }
}
