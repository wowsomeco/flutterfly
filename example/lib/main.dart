import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'global_state.dart';
import 'shopping_cart_page.dart';
import 'home_page.dart';
import 'form_page.dart';
import 'products_page.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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
    ProductsPage(),
    FormPage(
      model: TestFormModel(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form Test',
        theme: flyThemeData(),
        navigatorObservers: [routeObserver],
        home: Builder(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black87),
                    actions: [
                      FlyBadge(
                        icon: Icon(Icons.shopping_cart),
                        badgeContent:
                            GlobalState().shoppingCarts.length.toString(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingCartPage()),
                          );
                        },
                      ),
                      FlyBadge(
                        icon: Icon(Icons.notifications),
                        onPressed: () {},
                      )
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
                          icon: Icon(Icons.shopping_basket),
                          title: Text('Products')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), title: Text('Profile')),
                    ],
                  ),
                )));
  }
}
