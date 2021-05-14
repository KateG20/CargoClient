import 'package:flutter/material.dart';
import 'package:flutter1/ListFilterNotifier.dart';

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
  List<Request> list = [];

  late ListFilterNotifier _futureListNotifier;

  @override
  void initState() {
    super.initState();
    // futureList = service.getNewRequests();
    _futureListNotifier = ListFilterNotifier(value: _getRequests());
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
                        builder: (context, value, child) => FutureBuilder<
                                List<Request>>(
                            future: _futureListNotifier.value,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // return Text(snapshot.data!.title);
                                list = snapshot.data!;

                                return Column(children: <Widget>[
                                  Design.pageHeader(
                                      context, _futureListNotifier, list, 0),
                                  Container(
                                    width: double.infinity,
                                      color: Colors.yellow[50]
                                          ?.withOpacity(0.2),
                                      child: Visibility(
                                          child: TextButton(
                                              onPressed: (() {
                                                _futureListNotifier
                                                    .reset(_getRequests());
                                              }),
                                              child: Text('Сбросить фильтры',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightGreen[800],
                                                      fontSize: 20,
                                                      decoration: TextDecoration
                                                          .underline))),
                                          visible:
                                              _futureListNotifier.filtered)),
                                  Expanded(
                                      child: Container(
                                        // padding: EdgeInsets.all(0),
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
                    onWillPop: () async => false))));
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
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Design().requestContainer(
                list[index], Design().newRequestRow(context, list[index]));
          },
        ));
  }

  Future<void> _pullRefresh() async {
    if (_futureListNotifier.filtered) return;
    Future<List<Request>> newList = service.getNewRequests();
    setState(() {
      _futureListNotifier.value = newList;
    });
    // why use newList var? https://stackoverflow.com/a/52992836/2301224
    await Future.delayed(Duration(seconds: 1));
  }

  Future<List<Request>> _getRequests() async {
    return await service.getNewRequests();
  }
}
