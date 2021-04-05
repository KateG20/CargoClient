import 'package:flutter/material.dart';
import 'MenuBar.dart';

class RequestPage extends StatelessWidget {
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
                      color: Colors.lightGreen[100],
                      child: new Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Padding(
                                  // padding: EdgeInsets.fromLTRB(59, 8, 0, 0),
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: FlatButton(
                                      splashColor: Colors.white,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MenuBar()),
                                        );
                                      },
                                      child: new Text('Меню',
                                          style: new TextStyle(
                                              color: Colors.lightGreen[900],
                                              fontSize: 26.0)),
                                    )),
                                new Padding(
                                    child: new Text('Заказы',
                                        style: new TextStyle(
                                            color: Colors.lightGreen[700],
                                            fontSize: 27.0)),
                                    // padding: EdgeInsets.fromLTRB(45, 7, 0, 0)
                                    padding: EdgeInsets.fromLTRB(40, 8, 0, 0)),
                              ]))),
                  Expanded(
                      child: new ListView.separated(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 170,
                              decoration: orderBoxDecoration(),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  new Padding(
                                      padding: EdgeInsets.fromLTRB(7, 15, 0, 15),
                                      // padding: EdgeInsets.only(top: 15),
                                      child: new Container(
                                        // контейнер с данными о времени и расстоянии
                                          decoration: dataBoxDecoration(),
                                          width: 150,
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
                                                        style: TextStyle(
                                                          color: Colors.green[900],
                                                          fontSize: 23,
                                                        )),
                                                  ),
                                                  new RichText(
                                                    text: TextSpan(
                                                        text: "18 минут",
                                                        style: TextStyle(
                                                          color: Colors.green[900],
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                  new RichText(
                                                    text: TextSpan(
                                                        text: "5 км",
                                                        style: TextStyle(
                                                          color: Colors.green[900],
                                                          fontSize: 20,
                                                        )),
                                                  ),
                                                ],
                                              )))),
                                  new Padding(
                                      padding: EdgeInsets.fromLTRB(0, 15, 7, 15),
                                      // padding: EdgeInsets.only(top: 15),
                                      child: new Container(
                                        // контейнер с данными о времени и расстоянии
                                          decoration: dataBoxDecoration(),
                                          // width: 150,
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
                                              )))),
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 25),
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
          color: Colors.orange[200],
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0) //
        ));
  }
}