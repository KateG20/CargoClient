import 'package:flutter/material.dart';

import '../RType.dart';
import '../ViewModel/ServiceViewModel.dart';
import '../entity/Request.dart';
import '../notifier/ListFilterNotifier.dart';
import 'ListWidgets.dart';

class ArchiveRequestPage extends StatefulWidget {
  @override
  _ArchiveRequestPageState createState() => _ArchiveRequestPageState();
}

class _ArchiveRequestPageState extends State<ArchiveRequestPage> {
  final ServiceViewModel vm = ServiceViewModel();

  List<Request> _list = [];

  late ListFilterNotifier _futureListNotifier;

  @override
  void initState() {
    super.initState();
    _futureListNotifier =
        ListFilterNotifier(value: vm.getRequests(RType.archive));
  }

  @override
  void dispose() {
    _futureListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                                _list = snapshot.data!;

                                return Column(children: <Widget>[
                                  ListWidgets.pageHeader(
                                      context, _futureListNotifier, _list, 2),
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
                                              _futureListNotifier.reset(vm
                                                  .getRequests(RType.archive));
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

  Widget _myListView(BuildContext context) {
    return RefreshIndicator(
        onRefresh: (() => vm.refreshList(RType.archive, _futureListNotifier)),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _list.length,
          itemBuilder: (context, index) {

            return ListWidgets().requestContainer(_list[index],
                ListWidgets().archiveRequestRow(context, _list[index]));
          },
        ));
  }
}
