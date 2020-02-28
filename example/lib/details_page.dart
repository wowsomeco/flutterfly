import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'home_page.dart';

class DetailsPage extends StatefulWidget {
  final ThumbnailModel model;

  DetailsPage({this.model});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FlyImage(
            url: widget.model.imgUrl,
            aspectRatio: 1.1,
          ),
          ListTile(
            title: Text(widget.model.name),
            subtitle: Text(widget.model.price.toString()),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlineButton(
                borderSide: BorderSide(color: theme.accentColor),
                textColor: theme.accentColor,
                child: Text('Buy'),
                onPressed: () {},
              ),
              FlatButton(
                color: theme.accentColor,
                child: Text(
                  'Add To Cart',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
