import 'package:flutter/material.dart';

import 'MenuBar.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  int _itemCount = 7;
  var requests = [
    Request(DateTime.utc(2021), Duration(hours: 3), 120, "ТЛЦ", "Владивосток"),
    Request(DateTime.utc(2021), Duration(hours: 1, minutes: 12), 60,
        "Новосибирск", "ТЛЦ")
  ];

  @override
  // Future<http.Response> fetchAlbum(String id) {
  //   return http.get('http://localhost:5000/api/trainid?id=\(id)');
  // }
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => new Material(
                    // создали колонку, в которой сначала
                    // ряд меню, а снизу прифигачиваем список
                    child: new Column(children: <Widget>[
                  new Container(
                      // header
                      height: 90,
                      color: Colors.lightGreen[50],
                      child: new Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                          child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: null,
                                  child: new Text('Новые заявки',
                                      style: new TextStyle(
                                          color: Colors.green[800],
                                          fontSize: 27.0,
                                          fontWeight: FontWeight.normal)),
                                  // padding: EdgeInsets.fromLTRB(45, 7, 0, 0)
                                  // padding: EdgeInsets.fromLTRB(40, 8, 0, 0)),
                                ),
                                IconButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 6),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuBar()),
                                    );
                                  },
                                  icon: const Icon(Icons.menu_rounded),
                                  tooltip: 'Menu',
                                  color: Colors.green[700],
                                  iconSize: 50,
                                ),
                              ]))),
                  Expanded(
                      child: new ListView.custom(
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

// there were two BoxDecorators and listItemContainer creation method (now below)
}

class Request {
  DateTime? date;
  Duration? duration;
  int? distance;
  String? from;
  String? to;

  Request(this.date, this.duration, this.distance, this.from, this.to);
}

class KeepAlive extends StatefulWidget {
  const KeepAlive({
    required Key key,
    required this.data,
  }) : super(key: key);

  final Request data;

  @override
  _KeepAliveState createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return listItemContainer();
  }
}

BoxDecoration orderBoxDecoration() {
  return BoxDecoration(
      border: Border.all(
        color: Colors.lightGreen,
        width: 3,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0) //
          ));
}

BoxDecoration dataBoxDecoration() {
  return BoxDecoration(
      color: Colors.yellow[100],
      border: Border.all(
        color: (Colors.orange[200])!,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0) //
          ));
}

Widget listItemContainer() {
  return Container(
      // большой контейнер
      // колонка - сверху два желтых контейнера, снизу кнопки
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        new Container(
            // два желтых
            height: 170,
            decoration: orderBoxDecoration(),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Padding(
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                      // padding: EdgeInsets.only(top: 15),
                      child: new Container(
                          // маленький контейнер
                          // контейнер с данными о времени и расстоянии
                          decoration: dataBoxDecoration(),
                          width: 185,
                          child: new Padding(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                // колонка с данными
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  new RichText(
                                    text: TextSpan(
                                        text: "09.09.2020",
                                        // TODO
                                        style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 23,
                                        )),
                                  ),
                                  new RichText(
                                    text: TextSpan(
                                        text: "18 минут",
                                        // TODO
                                        style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 20,
                                        )),
                                  ),
                                  new RichText(
                                    text: TextSpan(
                                        text: "5 км",
                                        // TODO
                                        style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 20,
                                        )),
                                  ),
                                ],
                              )))),
                  new Padding(
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                      // padding: EdgeInsets.only(top: 15),
                      child: new Container(
                          // контейнер с данными о пунктах назначения
                          decoration: dataBoxDecoration(),
                          width: 185,
                          child: new Padding(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                // колонка с данными
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  new RichText(
                                    text: TextSpan(
                                        text: "Владивосток",
                                        style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 23,
                                        )),
                                  ),
                                  new RichText(
                                    text: TextSpan(
                                        text: "ТЛЦ",
                                        style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 23,
                                        )),
                                  ),
                                ],
                              ))))
                ])),
        new Padding(
            padding: EdgeInsets.only(top: 1, bottom: 10),
            child: new Row(
              // ряд с двумя кнопками
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      side: BorderSide(color: (Colors.orange[200])!, width: 2),
                      minimumSize: new Size(150, 30),
                      backgroundColor: Colors.orange[50]),
                  onPressed: () {
                    // TODO
                  },
                  child: Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        "Отклонить",
                        style: TextStyle(
                            color: Colors.lightGreen[800], fontSize: 20),
                      )),
                ),
                new OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      side: BorderSide(color: Colors.lightGreen, width: 2),
                      minimumSize: new Size(150, 30),
                      backgroundColor: Colors.lightGreen[50]),
                  onPressed: () {
                    // TODO
                  },
                  child: Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        "Принять",
                        style: TextStyle(
                            color: Colors.lightGreen[800], fontSize: 20),
                      )),
                ),
              ],
            ))
      ]));
}
