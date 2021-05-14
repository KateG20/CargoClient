import 'package:flutter/material.dart';

import '../RequestListModel.dart';
import '../entity/Request.dart';
import '../service/RequestService.dart';
import 'Design.dart';

class NewRequestPage extends StatefulWidget {
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  final RequestService service = RequestService();
  late Future<List<Request>> futureList;
  bool _filtered = false;

  // set setFutureList(Future<List<Request>> val) => futureList = val;
  RequestListModel list = RequestListModel([]);

  late ValueNotifier<Future<List<Request>>> _futureListNotifier;

  @override
  void initState() {
    super.initState();
    // futureList = service.getNewRequests();
    _futureListNotifier =
        ValueNotifier<Future<List<Request>>>(service.getNewRequests());
  }

  @override
  void dispose() {
    _futureListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                child: WillPopScope(
                child: ValueListenableBuilder(
                    valueListenable: _futureListNotifier,
                    builder: (context, value, child) =>
                        FutureBuilder<List<Request>>(
                            future: _futureListNotifier.value,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // return Text(snapshot.data!.title);
                                list = RequestListModel(snapshot.data!);

                                return Column(children: <Widget>[
                                  // Text(Buffer.test, style: TextStyle(color: Colors.black),),
                                  Design.pageHeader(context,
                                      _futureListNotifier, list, 0),
                                  //'Новые заявки'),
                                  Expanded(
                                      child: Container(
                                          color: Colors.yellow[50]
                                              ?.withOpacity(0.2),
                                          // child: _myListView(context, list)
                                          child: _myListView(context)))
                                ]);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              // By default, show a loading spinner.
                              return Center(child: CircularProgressIndicator());
                            })),
                  onWillPop: () async => false
                ))
    ));
  }

  // Future<bool> _willPopCallback() async {
  //   showDialog<bool>(
  //     context: context,
  //     builder: (c) => AlertDialog(
  //       // title: Text('Warning'),
  //       content: Text('Выйти из приложения?'),
  //       actions: [
  //         OutlinedButton(
  //           child: Text('Да'),
  //           onPressed: () => Navigator.pop(c, true),
  //         ),
  //         OutlinedButton(
  //           child: Text('Нет'),
  //           onPressed: () => Navigator.pop(c, false),
  //         ),
  //       ],
  //     ),
  //   );
  //   // then
  //   return true; // return true if the route to be popped
  // }

  // Widget _myListView(BuildContext context, RequestListModel list) {
  Widget _myListView(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: list.requests.length,
          itemBuilder: (context, index) {
            return Design().requestContainer(list.requests[index],
                Design().newRequestRow(context, list.requests[index]));
          },
        ));
  }

  Future<void> _pullRefresh() async {
    Future<List<Request>> newList = service.getNewRequests();
    setState(() {
      futureList = newList;
    });
    // why use newList var? https://stackoverflow.com/a/52992836/2301224
    await Future.delayed(Duration(seconds: 1));
  }
}
