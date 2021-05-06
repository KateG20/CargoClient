import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'MenuBar.dart';
import '../entity/Request.dart';
import 'Design.dart';
import '../RequestListModel.dart';
import '../service/Service.dart';

class NewRequestPage extends StatefulWidget {
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {

  final Service service = Service();

  @override
  Widget build(BuildContext context) {
    late List<Request> requestList = [];

    var futureList = service.getNewRequests();
    futureList.then((value) {
      requestList = value;
    }).catchError((err) {
      print('error!');
    });

    var list = RequestListModel(requestList);

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
