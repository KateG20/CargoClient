import 'package:flutter/material.dart';

import 'RegistrationPage.dart';
import 'RequestPage.dart';

class EntryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => new Material(
                child: new Container(
                    padding: const EdgeInsets.all(30.0),
                    color: Colors.white,
                    child: new Container(
                      child: new Center(
                          child: new Column(children: [
                        new Padding(padding: EdgeInsets.only(top: 70.0)),
                        new Text(
                          'Авторизация',
                          style: new TextStyle(
                              color: Colors.lightGreen, fontSize: 25.0),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 30.0)),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Логин",
                            fillColor: Colors.lightBlueAccent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Заполните поле \"Логин\"";
                            } else {
                              return null;
                            }
                          },
                        ),
                        new Padding(padding: EdgeInsets.only(top: 30.0)),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Пароль",
                            fillColor: Colors.lightBlueAccent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Заполните поле \"Пароль\"";
                            } else {
                              return null;
                            }
                          },
                        ),
                        new Padding(padding: EdgeInsets.only(top: 20.0)),
                        // OutlinedButton
                        new FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequestPage()),
                            );
                          },
                          child: Text(
                            "Войти",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.lightGreen),
                          ),
                        ),
                        // new Padding(padding: EdgeInsets.only(top: 7.0)),
                        new OutlineButton(
                          color: Colors.lightGreen.withOpacity(0.8),
                          splashColor: Colors.lightGreen,

                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()),
                            );
                          },
                          child: new Text(
                            "Первичная регистрация",
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.black),
                          ),
                        ),
                      ])),
                    )))));
  }
}
