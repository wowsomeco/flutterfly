import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'package:flutterfly_example/global_state.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    for (StoreModel item in GlobalState().storeModels) {
      cards.add(ThumbnailStore(
        model: item,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(model: item)),
          );
        },
      ));
    }
    return cards;
  }
}

class ThumbnailStore extends StatefulWidget {
  final StoreModel model;
  final double imgAspectRatio;
  final void Function() onTap;

  ThumbnailStore(
      {@required this.model, @required this.onTap, this.imgAspectRatio = 1.0});

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
        child: FlyCard(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                height: 60,
                child: Text(
                  widget.model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                )),
            FlyImage(
              url: widget.model.imgUrl,
              aspectRatio: widget.imgAspectRatio,
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      '${widget.model.price} USD',
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )))
          ],
        ));
  }
}
