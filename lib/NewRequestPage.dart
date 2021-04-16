import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'MenuBar.dart';
import 'Request.dart';

class NewRequestPage extends StatefulWidget {
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  var requests = [
    Request(DateTime.utc(2021, 3, 8), Duration(hours: 3), 120, "ТЛЦ",
        "Владивосток"),
    Request(DateTime.utc(2021, 7, 1), Duration(hours: 1, minutes: 12), 60,
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
            builder: (context) => Material(
                    // создали колонку, в которой сначала
                    // ряд меню, а снизу прифигачиваем список
                    child: Column(children: <Widget>[
                  Container(
                      // header
                      height: 90,
                      color: Colors.lightGreen[50],
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: null,
                                  child: Text('Новые заявки',
                                      style: TextStyle(
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
                      child: ListView.custom(
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

  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return requestContainer();
  }

  BoxDecoration requestBoxDecoration() {
    return BoxDecoration(
        border: Border.all(
          color: Colors.lightGreen,
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0) //
            ));
  }

  BoxDecoration dataBoxDecoration() {
    return BoxDecoration(
        color: Colors.yellow[100],
        border: Border.all(
          color: (Colors.orange[200])!,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0) //
            ));
  }

  Widget requestContainer() {
    return Container(
        // большой контейнер
        // колонка - сверху два желтых контейнера, снизу кнопки
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
          // два желтых
          height: 170,
          decoration: requestBoxDecoration(),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                // padding: EdgeInsets.only(top: 15),
                child: Container(
                    // маленький контейнер
                    // контейнер с данными о времени и расстоянии
                    decoration: dataBoxDecoration(),
                    width: 185,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          // колонка с данными
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "когда",
                                  style: TextStyle(
                                    color: Colors.green[900]?.withOpacity(0.6),
                                    fontSize: 20,
                                  )),
                            ),
                            RichText(
                              text: TextSpan(
                                  text:
                                      "${DateFormat('dd.MM.yyyy').format(_data.date!)}",
                                  // TODO
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 23,
                                  )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            RichText(
                              text: TextSpan(
                                  text: "сколько",
                                  style: TextStyle(
                                    color: Colors.green[900]?.withOpacity(0.6),
                                    fontSize: 20,
                                  )),
                            ),
                            RichText(
                              text: TextSpan(
                                  // text: "${_data.duration?.toString()}",
                                  text: "${_printDuration(_data.duration!)}",
                                  // TODO
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 20,
                                  )),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "${_data.distance?.toString()} км",
                                  // TODO
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontSize: 20,
                                  )),
                            ),
                          ],
                        )))),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                // padding: EdgeInsets.only(top: 15),
                child: Container(
                    // контейнер с данными о пунктах назначения
                    decoration: dataBoxDecoration(),
                    width: 185,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          // колонка с данными
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(
                            "откуда",
                            style: TextStyle(
                              color: Colors.green[900]?.withOpacity(0.6),
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                            Text(
                              "${_data.from?.toString()}",
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Text(
                              "куда",
                              style: TextStyle(
                                color: Colors.green[900]?.withOpacity(0.6),
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${_data.to?.toString()}",
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ))))
          ])),
      Padding(
          padding: EdgeInsets.only(top: 1, bottom: 10),
          child: Row(
            // ряд с двумя кнопками
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    primary: Colors.orange,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    side: BorderSide(color: (Colors.orange[200])!, width: 2),
                    minimumSize: Size(150, 30),
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
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.lightGreen[800],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    side: BorderSide(color: Colors.lightGreen, width: 2),
                    minimumSize: Size(150, 30),
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

  String _printDuration(Duration duration) {
    String hours = "${duration.inHours.remainder(60)} ч.";
    String minutes = " ${duration.inMinutes.remainder(60)} мин.";
    String res = "";
    if (duration.inHours.remainder(60) > 0) res += hours;
    if (duration.inMinutes.remainder(60) > 0) res += minutes;
    return res;
    // String twoDigits(int n) => n.toString().padLeft(2, "0");
    // String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
