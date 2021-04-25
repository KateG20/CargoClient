import 'package:flutter/material.dart';

import 'Design.dart';
import 'Request.dart';

class CurrentRequestPage extends StatefulWidget {
  @override
  _CurrentRequestPageState createState() => _CurrentRequestPageState();
}

class _CurrentRequestPageState extends State<CurrentRequestPage> {
  var requests = [
    Request("Shipper", "Receiver", DateTime.utc(2021, 4, 20),
        Duration(hours: 5), 120, "ТЛЦ", "Москва", 680, "comment"),
    Request(
        "Shipper",
        "Receiver",
        DateTime.utc(2021, 5, 3),
        Duration(minutes: 32),
        60,
        "Александровск-Сахалинский",
        "ТЛЦ",
        680,
        "comment")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                    // создали колонку, в которой сначала
                    // ряд меню, а снизу прифигачиваем список
                    child: Column(children: <Widget>[
                  Design().pageHeader(context, 'Активные заявки'),
                  Expanded(
                      child: ListView.custom(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(7),
                    childrenDelegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return KeepAlive(
                            data: requests[index],
                            key: ValueKey<Request>(requests[index]),
                          );
                        },
                        childCount: requests.length,
                        findChildIndexCallback: (Key key) {
                          final ValueKey valueKey = key as ValueKey;
                          final Request data = valueKey.value;
                          return requests.indexOf(data);
                        }),
                  ))
                ]))));
  }
}

class KeepAlive extends StatefulWidget {
  const KeepAlive({
    required Key key,
    required this.data,
  }) : super(key: key);

  final Request data;

  @override
  _KeepAliveState createState() => _KeepAliveState(data);
}

class _KeepAliveState extends State<KeepAlive> {
  final Request _data;

  _KeepAliveState(this._data);

  @override
  Widget build(BuildContext context) {
    return Design()
        .requestContainer(_data, Design().currentRequestRow(context, _data));
  }
}
