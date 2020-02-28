import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ThumbnailModel> _storeItems = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 7; i++) {
      _storeItems.add(ThumbnailModel(
          id: i,
          name: 'The Greatest Lego of All Time $i',
          imgUrl: 'https://randomuser.me/api/portraits/lego/$i.jpg',
          price: Random().nextInt(1000)));
    }
    // add null img for testing
    _storeItems.add(ThumbnailModel(
        id: _storeItems.length + 1,
        name: 'A Rejected Lego',
        imgUrl: null,
        price: Random().nextInt(1000)));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(primary: false, slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(0),
        sliver: SliverGrid.count(
          childAspectRatio: 100.0 / 170.0,
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          children: _buildStoreList(context),
        ),
      ),
    ]);
  }

  List<Widget> _buildStoreList(BuildContext context) {
    List<Widget> cards = [];
    for (ThumbnailModel item in _storeItems) {
      cards.add(ThumbnailStore(
        imgUrl: item.imgUrl,
        title: item.name,
        price: item.price,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => StoreDetails(model: item)),
          // );
        },
      ));
    }
    return cards;
  }
}

class ThumbnailModel {
  final int id;
  final String name;
  final String imgUrl;
  final int price;

  ThumbnailModel({this.id, this.name, this.imgUrl, this.price});
}

class ThumbnailStore extends StatefulWidget {
  final String imgUrl;
  final double imgAspectRatio;
  final String title;
  final int price;
  final void Function() onTap;

  ThumbnailStore(
      {@required this.imgUrl,
      @required this.title,
      @required this.price,
      @required this.onTap,
      this.imgAspectRatio = 1.0});

  @override
  _ThumbnailStoreState createState() => _ThumbnailStoreState();
}

class _ThumbnailStoreState extends State<ThumbnailStore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )),
              FlyImage(
                url: widget.imgUrl,
                aspectRatio: widget.imgAspectRatio,
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${widget.price} USD',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )))
            ],
          ),
        ));
  }
}
