import 'package:flutter/material.dart';
import 'package:flutterfly/flutterfly.dart';
import 'global_state.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  List<NotifModel> models = GlobalState().notifModels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // Render list
    ListView list = ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, idx) {
          NotifModel model = models[idx];
          return FlyCard(
            border:
                Border(bottom: BorderSide(color: Colors.grey.withAlpha(40))),
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            color: Colors.transparent,
            direction: Axis.horizontal,
            children: [
              Icon(
                Icons.insert_emoticon,
                size: 32,
                color: theme.primaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
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
                  ),
                  InkWell(
                      onTap: () => setState(() => model.hasRead = true),
                      child: Text(
                        model.hasRead ? 'Read' : 'New',
                        style: TextStyle(
                            color: model.hasRead
                                ? Colors.grey.withAlpha(150)
                                : theme.accentColor),
                      ))
                ],
              )),
            ],
          );
        });
    return NotificationListener<ScrollNotification>(
      child: list,
      onNotification: (n) {
        // Checks how many items have been scroll on scroll ended
        // set them to hasRead if so
        if (n is ScrollEndNotification) {
          int scrolledCount =
              ((n.metrics.extentBefore / n.metrics.maxScrollExtent) *
                      models.length)
                  .toInt();
          if (scrolledCount > 0 && mounted) {
            setState(() {
              for (int i = 0; i < scrolledCount; i++) {
                models[i].hasRead = true;
              }
            });
          }
        }
        return true;
      },
    );
  }
}
