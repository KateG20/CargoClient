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
  late Future<List<Request>> futureList;
  late RequestListModel list;

  @override
  void initState() {
    super.initState();
    futureList = service.getNewRequests();

    List<Request> requestList = [];

    futureList.then((value) {
      requestList = value;
    }).catchError((err) {
      print('error!');
    });

    list = RequestListModel(requestList);
  }

  @override
  Widget build(BuildContext context) {
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
                          // child: _myListView(context, list)
                          child: _myListView(context)
                      ))
                ]))));
  }

  // Widget _myListView(BuildContext context, RequestListModel list) {
  Widget _myListView(BuildContext context) {

    return FutureBuilder<List<Request>>(
      future: futureList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return Text(snapshot.data!.title);
          list = RequestListModel(snapshot.data!);

          return ListView.builder(
            itemCount: list.requests.length,

            itemBuilder: (context, index) {
              return Design().requestContainer(list.requests[index],
                  Design().newRequestRow(context, list.requests[index]));
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
    // return ListView.builder(
    //   itemCount: list.requests.length,
    //   itemBuilder: (context, index) {
    //     return Design().requestContainer(list.requests[index],
    //         Design().newRequestRow(context, list.requests[index]));
    //   },
    // );
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
