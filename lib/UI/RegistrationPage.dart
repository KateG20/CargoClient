import 'package:flutter/material.dart';

import 'RegistrationPage.dart';
import 'NewRequestPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                              'Введите ключ, который вам предоставила ваша компания для входа:',
                              style: new TextStyle(
                                // color: Color(0xff9ACD32), fontSize: 25.0),
                                  color: Colors.lightGreen[600],
                                  fontSize: 20.0),
                              textAlign: TextAlign.center,
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
                                labelText: "Ключ",
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
                                  return "Заполните поле \"Ключ\"";
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
                          ])),)
                )
            )
        )
    );
  }
}