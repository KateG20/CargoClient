import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'MenuBar.dart';
import 'Request.dart';
import 'Design.dart';

class NewRequestPage extends StatefulWidget {
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  var requests = [
    Request("Shipper", "Receiver", DateTime.utc(2021, 3, 8), Duration(hours: 3), 120, "ТЛЦ",
        "Владивосток", 680, "comment"),
    Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1), Duration(hours: 1, minutes: 12), 60,
        "Новосибирск", "ТЛЦ",  680, "comment"),
    Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1), Duration(hours: 1, minutes: 12), 60,
        "Новосибирск", "ТЛЦ",  680, "comment"),
    Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1), Duration(hours: 1, minutes: 12), 60,
        "Новосибирск", "ТЛЦ",  680, "comment"),
    Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1), Duration(hours: 1, minutes: 12), 60,
        "Новосибирск", "ТЛЦ",  680, "comment")
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
                  Design().pageHeader(context, 'Новые заявки'),
                  Expanded(
                      child: Container(
                        color: Colors.yellow[50]?.withOpacity(0.4),
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
                  )))
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
    return Design().requestContainer(_data, Design().newRequestRow(context, _data));
  }
}
