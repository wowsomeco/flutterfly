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
  bool _liked = false;

  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlyButton(
            outlined: true,
            color: Colors.black,
            icon: Icons.shopping_cart,
            onPressed: () {},
          ),
          FlyButton(
            icon: Icons.add,
            color: Colors.grey,
            outlined: true,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FlyImage(
            url: widget.model.imgUrl,
            aspectRatio: 1.1,
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.model.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: Icon(
                            _liked ? Icons.favorite : Icons.favorite_border),
                        color: _liked ? theme.errorColor : Colors.black87,
                        onPressed: () {
                          setState(() {
                            _liked = !_liked;
                          });
                        },
                      )
                    ],
                  ),
                  Text(widget.model.price.toString())
                ],
              )),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlyButton(
                label: 'Buy',
                icon: Icons.card_membership,
                onPressed: () {},
              ),
              FlyButton(
                icon: Icons.shopping_cart,
                label: 'Add To Cart',
                outlined: true,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
