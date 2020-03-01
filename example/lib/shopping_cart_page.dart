import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartModel {
  String title;

  _ShoppingCartModel({this.title});

  String get description => 'Description for $title';

  String get price => '\$ ${Random().nextInt(1000)}';
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  final List<_ShoppingCartModel> models = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 15; i++) {
      models.add(_ShoppingCartModel(title: 'Item $i'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: models.length,
          itemBuilder: (context, idx) {
            return FlyCard(
              border: Border(
                  bottom: BorderSide(color: Colors.blueGrey.withAlpha(100))),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: Axis.horizontal,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      models[idx].title,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      models[idx].description,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.grey),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      models[idx].price,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(fontWeight: FontWeight.bold),
                    ))
              ],
            );
          }),
    );
  }
}
