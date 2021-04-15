import 'package:flutter/material.dart';

import 'MenuBar.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  int _itemCount = 7;

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
                                // new TextButton(
                                //   padding
                                //     onPressed: () {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MenuBar()),
                                //   );
                                // }, child: new Text('Меню',
                                //     style: new TextStyle(
                                //         color: Colors.lightGreen[900],
                                //         fontSize: 26.0)))
                                // new Padding(
                                //     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                //     child:
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

                                // TextButton(
                                //   onPressed: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => MenuBar()),
                                //     );
                                //   },
                                //   child: new Text('Меню',
                                //       style: new TextStyle(
                                //           color: Colors.lightGreen[800],
                                //           fontSize: 26.0)),
                                // ),

                                // new Padding(
                                //     child:
                                // TextButton(
                                //   onPressed: null,
                                //   child: new Text('Заказы',
                                //       style: new TextStyle(
                                //           color: Colors.lightGreen[700],
                                //           fontSize: 27.0)),
                                //   // padding: EdgeInsets.fromLTRB(45, 7, 0, 0)
                                //   // padding: EdgeInsets.fromLTRB(40, 8, 0, 0)),
                                // ),
                                // TextButton(
                                //   onPressed: null,
                                //   child: new Text('Профиль',
                                //       style: new TextStyle(
                                //           color: Colors.lightGreen[700],
                                //           fontSize: 27.0)),
                                //   // padding: EdgeInsets.fromLTRB(45, 7, 0, 0)
                                //   // padding: EdgeInsets.fromLTRB(40, 8, 0, 0)),
                                // )
                              ]))),
                  Expanded(
                      child: new ListView.separated(
                          // scrollDirection: Axis.vertical
                    padding: EdgeInsets.all(7),
                    itemCount: _itemCount,
                    itemBuilder: (BuildContext context, int index) {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      new Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 6, 0, 6),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      new RichText(
                                                        text: TextSpan(
                                                            text: "09.09.2020",
                                                            // TODO
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .green[900],
                                                              fontSize: 23,
                                                            )),
                                                      ),
                                                      new RichText(
                                                        text: TextSpan(
                                                            text: "18 минут",
                                                            // TODO
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .green[900],
                                                              fontSize: 20,
                                                            )),
                                                      ),
                                                      new RichText(
                                                        text: TextSpan(
                                                            text: "5 км",
                                                            // TODO
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .green[900],
                                                              fontSize: 20,
                                                            )),
                                                      ),
                                                    ],
                                                  )))),
                                      new Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 6, 0, 6),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      new RichText(
                                                        text: TextSpan(
                                                            text: "Владивосток",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .green[900],
                                                              fontSize: 23,
                                                            )),
                                                      ),
                                                      new RichText(
                                                        text: TextSpan(
                                                            text: "ТЛЦ",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .green[900],
                                                              fontSize: 23,
                                                            )),
                                                      ),
                                                    ],
                                                  ))))
                                    ])),
                            new Padding(padding: EdgeInsets.only(top: 5)),
                            new Row(
                              // ряд с двумя кнопками
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                new OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      side: BorderSide(
                                          color: (Colors.orange[200])!, width: 2),
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
                                            color: Colors.lightGreen[800],
                                            fontSize: 20),
                                      )),
                                ),
                                new OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      side: BorderSide(
                                          color: Colors.lightGreen, width: 2),
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
                                            color: Colors.lightGreen[800],
                                            fontSize: 20),
                                      )),
                                ),
                              ],
                            )
                          ]));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 20),
                  ))
                ]))));
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
}

class Request {
  DateTime? date;
  Duration? duration;
  int? distance;
  String? from;
  String? to;

  Request(this.date, this.duration, this.distance, this.from, this.to);
}
