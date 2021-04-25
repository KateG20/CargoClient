import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Design.dart';
import 'Request.dart';

class ArchiveRequestPage extends StatefulWidget {
  @override
  _ArchiveRequestPageState createState() => _ArchiveRequestPageState();
}

class _ArchiveRequestPageState extends State<ArchiveRequestPage> {
  var requests = [
    Request("Shipper", "Receiver", DateTime.utc(2020, 4, 1), Duration(hours: 5),
        120, "ТЛЦ", "Санкт-Петербург", 680, "comment"),
    Request("Shipper", "Receiver", DateTime.utc(2020, 12, 21),
        Duration(minutes: 32), 60, "Дмитров", "ТЛЦ", 680, "comment")
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
                  Design().pageHeader(context, 'Архивные заявки'),
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
    return Design().requestContainer(_data, Design().archiveRequestRow(context, _data));
  }
}
