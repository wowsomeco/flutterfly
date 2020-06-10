import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'global_state.dart';
import 'shopping_cart_page.dart';
import 'notif_page.dart';
import 'home_page.dart';
import 'form_page.dart';
import 'products_page.dart';
import 'orders_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form Test',
        theme: flyThemeData('JosefinSans'),
        navigatorObservers: [routeObserver],
        home: _Layout());
  }
}

class _Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  int _curIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ProductsPage(),
    OrdersPage(),
    FormPage(
      model: TestFormModel(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlyBadge(
            icon: Icon(
              Icons.notifications,
              size: 32,
            ),
            badgeContent: GlobalState().newNotifModels.length.toString(),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotifPage()),
            ),
          ),
          FlyBadge(
              icon: Icon(
                Icons.shopping_cart,
                size: 32,
              ),
              badgeContent: GlobalState().shoppingCarts.length.toString(),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                  )),
        ],
      ),
      body: _pages[_curIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            _curIndex = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _curIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), title: Text('Products')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Orders')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),
        ],
      ),
    );
  }
}
