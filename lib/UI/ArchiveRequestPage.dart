import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Design.dart';
import '../entity/Request.dart';
import '../RequestListModel.dart';
import '../service/RequestService.dart';

class ArchiveRequestPage extends StatefulWidget {
  @override
  _ArchiveRequestPageState createState() => _ArchiveRequestPageState();
}

class _ArchiveRequestPageState extends State<ArchiveRequestPage> {
  // var requests = [
  //   Request("Shipper", "Receiver", DateTime.utc(2020, 4, 1), Duration(hours: 5),
  //       120, "ТЛЦ", "Санкт-Петербург", 680, "comment"),
  //   Request("Shipper", "Receiver", DateTime.utc(2020, 12, 21),
  //       Duration(minutes: 32), 60, "Дмитров", "ТЛЦ", 680, "comment")
  // ];

  // TODO тут все переделать нормально, как в новых заявках
  var service = RequestService();
  late Future<List<Request>> futureList;
  String test = 'test';

  @override
  void initState() {
    super.initState();
    futureList = service.getArchiveRequests();
  }

  @override
  Widget build(BuildContext context) {
    var list = RequestListModel(service.getArchiveRequestsHard());
    return MaterialApp(
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                    // создали колонку, в которой сначала
                    // ряд меню, а снизу прифигачиваем список
                    child: Column(children: <Widget>[
                  Design.pageHeader(context, setState, list, 2),
                  Expanded(
                      child: ListView.custom(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(7),
                    childrenDelegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return KeepAlive(
                            data: list.requests[index],
                            key: ValueKey<Request>(list.requests[index]),
                          );
                        },
                        childCount: list.requests.length,
                        findChildIndexCallback: (Key key) {
                          final ValueKey valueKey = key as ValueKey;
                          final Request data = valueKey.value;
                          return list.requests.indexOf(data);
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
