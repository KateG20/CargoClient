import 'package:flutter/material.dart';

import '../ListFilterNotifier.dart';
import '../entity/Request.dart';
import '../service/RequestService.dart';
import 'RequestList.dart';

class CurrentRequestPage extends StatefulWidget {
  @override
  _CurrentRequestPageState createState() => _CurrentRequestPageState();
}

class _CurrentRequestPageState extends State<CurrentRequestPage> {
  final RequestService service = RequestService();
  late Future<List<Request>> futureList;

  List<Request> list = [];

  late ListFilterNotifier _futureListNotifier;

  @override
  void initState() {
    super.initState();
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
                                list = snapshot.data!;

                                return Column(children: <Widget>[
                                  RequestList.pageHeader(
                                      context, _futureListNotifier, list, 1),
                                  Visibility(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow[50]
                                              ?.withOpacity(0.2),
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.lightGreen
                                                      .withOpacity(0.7),
                                                  width: 3)),
                                        ),
                                        width: double.infinity,
                                        child: TextButton(
                                            onPressed: (() {
                                              _futureListNotifier
                                                  .reset(_getRequests());
                                            }),
                                            child: Text('Сбросить фильтры',
                                                style: TextStyle(
                                                    color:
                                                    Colors.lightGreen[800],
                                                    fontSize: 20,
                                                    decoration: TextDecoration
                                                        .underline))),
                                      ),
                                      visible: _futureListNotifier.filtered),
                                  Expanded(
                                      child: Container(
                                          color: Colors.yellow[50]
                                              ?.withOpacity(0.2),
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

  // Widget _myListView(BuildContext context, RequestListModel list) {
  Widget _myListView(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return RequestList().requestContainer(
                list[index], RequestList().currentRequestRow(_futureListNotifier, context, list[index]));
          },
        ));
  }

  Future<void> _pullRefresh() async {
    if (_futureListNotifier.filtered) return;
    Future<List<Request>> newList = service.getCurrentRequests();
    setState(() {
      _futureListNotifier.value = newList;
    });
    // why use newList var? https://stackoverflow.com/a/52992836/2301224
    await Future.delayed(Duration(seconds: 1));
  }

  Future<List<Request>> _getRequests() async {
    return await service.getCurrentRequests();
  }
}
