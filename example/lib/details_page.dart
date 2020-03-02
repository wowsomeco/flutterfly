import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'shopping_cart_page.dart';
import 'global_state.dart';

class DetailsPage extends StatefulWidget {
  final StoreModel model;

  DetailsPage({this.model});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlyBadge(
            icon: Icon(Icons.shopping_cart),
            badgeContent: GlobalState().shoppingCarts.length.toString(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartPage()),
              );
            },
          ),
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
                        icon: Icon(widget.model.liked
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: widget.model.liked
                            ? theme.errorColor
                            : Colors.black87,
                        onPressed: () => setState(
                            () => widget.model.liked = !widget.model.liked),
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
                onPressed: () =>
                    setState(() => GlobalState().addShoppingCart(widget.model)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
