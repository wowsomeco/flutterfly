import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'global_state.dart';
import 'order_details_page.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<OrderModel> _models = GlobalState().orderModels;

  @override
  Widget build(BuildContext context) {
    // Render list
    return ListView.builder(
        itemCount: _models.length,
        itemBuilder: (context, idx) {
          OrderModel model = _models[idx];
          return FlyCard(
            border: Border.all(style: BorderStyle.none),
            children: [
              _buildDetailHeader(context, model),
              _buildDetailRow(
                  'Status',
                  model.status,
                  Icon(
                    Icons.check_circle_outline,
                    size: 14,
                  )),
              Divider(),
              _buildDetailRow('Shipped Date', model.shippedDate, null),
              Divider(),
              _buildDetailRow('Total', model.totalStr, null)
            ],
          );
        });
  }

  Widget _buildDetailHeader(BuildContext context, OrderModel model) {
    ThemeData theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[300].withAlpha(50),
            border: Border(bottom: BorderSide(color: Colors.grey[300]))),
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(
                          model: model,
                        )),
              ),
              child: Text(
                'Details',
                style: TextStyle(color: theme.primaryColor),
              ),
            )
          ],
        ));
  }

  Widget _buildDetailRow(String k, String v, Widget detailIcon) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            k,
            style: TextStyle(color: Colors.grey),
          ),
          Row(
            children: [
              if (detailIcon != null) ...[
                detailIcon,
                SizedBox(
                  width: 5,
                )
              ],
              Text(
                v,
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
