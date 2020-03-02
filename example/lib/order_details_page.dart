import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'global_state.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel model;

  OrderDetailsPage({this.model});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Track Order'),
        ),
        body: FlyCard(
          border: Border(),
          children: [
            Padding(padding: EdgeInsets.all(10), child: _trackingHorizontal()),
            _buildDetailRow('Order Number', widget.model.title),
            Divider(),
            _buildDetailRow('Shipped Date', widget.model.shippedDate),
            Divider(),
            _buildDetailRow('Status', widget.model.status,
                detailIcon: Icon(Icons.check_circle)),
            Divider(),
            SizedBox(
              height: 10,
            ),
            _trackingVertical()
          ],
        ));
  }

  Widget _buildDetailRow(String k, String v,
      {Widget detailIcon = const SizedBox.shrink()}) {
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

  Widget _trackingHorizontal() {
    List<FlyTimelineItem> items = widget.model.trackings
        .map((x) => FlyTimelineItem(
            isActive: true,
            icon: Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            )))
        .toList();
    items.addAll([
      FlyTimelineItem(
          isActive: false,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          )),
      FlyTimelineItem(
          isActive: false,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          )),
    ]);
    return FlyTimeline(
      children: items,
      lineHeight: 36,
      direction: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget _trackingVertical() {
    List<FlyTimelineItem> items = widget.model.trackings
        .map((x) => FlyTimelineItem(
            isActive: true,
            prefix: Container(
                width: 75,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  x.date,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.grey),
                )),
            suffix: Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          x.status,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          x.description,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    )))))
        .toList();
    return FlyTimeline(
      children: items,
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
