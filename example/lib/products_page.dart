import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsModel {
  String title;

  _ProductsModel({this.title});

  String get description =>
      'lorem ipsum dolor sit amet consectetur adipiscing elit';

  String get imgUrl =>
      'https://randomuser.me/api/portraits/lego/${Random().nextInt(7)}.jpg';
}

class _ProductsPageState extends State<ProductsPage> {
  final List<_ProductsModel> models = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 15; i++) {
      models.add(_ProductsModel(title: 'Item $i'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, idx) {
          return FlyCard(
            border: Border.all(style: BorderStyle.none),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.horizontal,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    models[idx].title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    models[idx].description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Colors.grey),
                  )
                ],
              )),
              Container(
                width: 80,
                child: FlyImage(
                  url: models[idx].imgUrl,
                  aspectRatio: 1.0,
                ),
              )
            ],
          );
        });
  }
}
