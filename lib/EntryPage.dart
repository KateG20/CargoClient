import 'package:flutter/material.dart';

import 'RegistrationPage.dart';
import 'NewRequestPage.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  bool _warningVisible = false;
  String _warningText = "test";

  void warningOn(String text) {
    setState(() {
      _warningText = text;
      _warningVisible = true;
    });
  }

  void warningOff(String text) {
    setState(() {
      _warningVisible = false;
    });
  }

  Text? _getWarning() {
    return _warningVisible == true ? Text('$_warningText',
      style: new TextStyle(
        // color: Color(0xff9ACD32), fontSize: 25.0),
          color: Colors.red,
          fontSize: 18.0),
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) =>
            new Material(
                child: new Container(
                    padding: const EdgeInsets.all(30.0),
                    color: Colors.white,
                    child: new Container(
                      child: new Center(
                          child: new Column(children: [
                            new Padding(padding: EdgeInsets.only(top: 40.0)),
                            new Text(
                              'Авторизация',
                              style: new TextStyle(
                                // color: Color(0xff9ACD32), fontSize: 25.0),
                                  color: Colors.lightGreen[600],
                                  fontSize: 30.0),
                            ),
                            // new Padding(padding: EdgeInsets.only(top: 20.0)),
                            new Padding(
                                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: _getWarning(),
                                  // child: Text(_warningVisible == true ? '$_warningText' : '',
                                  //           child: _warningVisible == true ? Text('$_warningText',
                                  //   style: new TextStyle(
                                  //     // color: Color(0xff9ACD32), fontSize: 25.0),
                                  //       color: Colors.redAccent,
                                  //       fontSize: 18.0),
                                  // )
                                )),
                            new Padding(padding: EdgeInsets.only(top: 20.0)),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Логин",
                                labelStyle: TextStyle(color: Colors.lightGreen),
                                // fillColor: Colors.lightGreen,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                    BorderSide(color: Colors.lightGreen)),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val?.length == 0) {
                                  return "Заполните поле \"Логин\"";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            new Padding(padding: EdgeInsets.only(top: 20.0)),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Пароль",
                                labelStyle: TextStyle(color: Colors.lightGreen),
                                fillColor: Colors.lightBlueAccent,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Colors.lightGreen,
                                  ),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val?.length == 0) {
                                  return "Заполните поле \"Пароль\"";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            new Padding(padding: EdgeInsets.only(top: 15.0)),
                            new OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                                // side: BorderSide(
                                //     color: Color(0x80808099), width: 1.4)
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewRequestPage()),
                                );
                              },
                              child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    "Войти",
                                    style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.lightGreen[600]),
                                  )),
                            ),
                            // new Padding(padding: EdgeInsets.only(top: 5)),
                            new OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                // textStyle: TextStyle(color: Colors.white),
                                  backgroundColor:
                                  Colors.lightGreen[600]?.withOpacity(0.8),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)))),
                              onPressed: () {
                                warningOn("Not available!");
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => RegistrationPage()),
                                // );
                              },
                              child: Text(
                                "Первичная регистрация",
                                style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                          ])),)
                )
            )
        )
    );
  }

// @override
// State<StatefulWidget> createState() {
//   // TODO: implement createState
//   throw UnimplementedError();
// }
}

// class _EntryPageState extends State<EntryPage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }
