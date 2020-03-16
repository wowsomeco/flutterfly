import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'global_state.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: _buildList());
  }

  Widget _buildEmpty() {
    return Center(
      child: Text('Shopping Cart is empty'),
    );
  }

  Widget _buildList() {
    List<ShoppingCartModel> models = GlobalState().shoppingCarts;
    // Render empty text if the shopping cart is empty
    if (models.length == 0) {
      return _buildEmpty();
    }
    // Render list
    return ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, idx) {
          ShoppingCartModel model = models[idx];
          return FlyCard(
            border: Border(
                bottom: BorderSide(color: Colors.blueGrey.withAlpha(100))),
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Container(
                width: 70,
                child: FlyImage(
                  aspectRatio: 1.0,
                  url: model.store.imgUrl,
                ),
              ),
              Container(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        model.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.grey),
                      )
                    ],
                  )),
              Row(
                children: <Widget>[
                  Text(
                    model.priceStr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  FlyNumeric(
                    min: 1,
                    onChanged: (v) {
                      setState(() {
                        model.qty = v;
                      });
                    },
                    initialValue: model.qty,
                  )
                ],
              )
            ],
          );
        });
  }
}
