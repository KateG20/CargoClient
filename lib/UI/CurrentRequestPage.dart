import 'package:flutter/material.dart';

import '../RequestListModel.dart';
import '../entity/Request.dart';
import '../service/RequestService.dart';
import 'Design.dart';

class CurrentRequestPage extends StatefulWidget {
  @override
  _CurrentRequestPageState createState() => _CurrentRequestPageState();
}

class _CurrentRequestPageState extends State<CurrentRequestPage> {
  var service = RequestService();

  @override
  Widget build(BuildContext context) {
    // FutureBuilder<Album>(
    //   future: futureAlbum,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return Text(snapshot.data!.title);
    //     } else if (snapshot.hasError) {
    //       return Text("${snapshot.error}");
    //     }
    //
    //     // By default, show a loading spinner.
    //     return CircularProgressIndicator();
    //   },
    // );
    late List<Request> requestList = [];
    // var futureList = service.getCurrentRequests();
    // futureList.then((value) {
    //   requestList = value;
    // }).catchError((err) {
    //   print('error!');
    // });

    var list = RequestListModel(requestList);
    late Future<List<Request>> futureList; // TODO тут все переделать нормально, как в новых заявках
    // String test = 'test';

    @override
    void initState() {
      super.initState();
      futureList = service.getArchiveRequests();
    }

    return MaterialApp(
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                    // создали колонку, в которой сначала
                    // ряд меню, а снизу прифигачиваем список
                    child: Column(children: <Widget>[
                  Design
                      .pageHeader(context, setState, list, 1),
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
    return Design()
        .requestContainer(_data, Design().currentRequestRow(context, _data));
  }
}
