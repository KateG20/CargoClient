import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'MenuBar.dart';
import 'Request.dart';
import 'Design.dart';
import 'RequestListModel.dart';
import 'Service.dart';

class NewRequestPage extends StatefulWidget {
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {

  final Service service = Service();

  @override
  Widget build(BuildContext context) {
    var list = RequestListModel(service.getNewRequests());

    return MaterialApp(
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                    // создали колонку, в которой сначала
                    // ряд меню, а снизу прифигачиваем список
                    child: Column(children: <Widget>[
                  Design().pageHeader(context, setState, list, 'Новые заявки'),
                  Expanded(
                      child: Container(
                        color: Colors.yellow[50]?.withOpacity(0.4),
                          child: _myListView(context, list)
                  //         ListView.custom(
                  //   scrollDirection: Axis.vertical,
                  //   padding: EdgeInsets.all(7),
                  //   childrenDelegate: SliverChildBuilderDelegate(
                  //       (BuildContext context, int index) {
                  //         return KeepAlive(
                  //           data: list.requests[index],
                  //           key: ValueKey<Request>(list.requests[index]),
                  //           // key: UniqueKey(),
                  //         );
                  //       },
                  //       childCount: list.requests.length,
                  //       findChildIndexCallback: (Key key) {
                  //         final ValueKey valueKey = key as ValueKey;
                  //         final Request data = valueKey.value;
                  //         return list.requests.indexOf(data);
                  //       }),
                  // )
                      ))
                ]))));
  }

  Widget _myListView(BuildContext context, RequestListModel list) {

    return ListView.builder(
      itemCount: list.requests.length,
      itemBuilder: (context, index) {
        return Design().requestContainer(list.requests[index], Design().newRequestRow(context, list.requests[index]));
      },
    );
  }
}

// class KeepAlive extends StatefulWidget {
//   const KeepAlive({
//     required Key key,
//     required this.data,
//   }) : super(key: key);
//
//   final Request data;
//
//   @override
//   _KeepAliveState createState() => _KeepAliveState(data);
// }
//
// class _KeepAliveState extends State<KeepAlive> {
//   final Request _data;
//
//   _KeepAliveState(this._data);
//
//   @override
//   Widget build(BuildContext context) {
//     return Design().requestContainer(_data, Design().newRequestRow(context, _data));
//   }
// }
