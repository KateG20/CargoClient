import 'dart:developer';

import 'package:flutter/material.dart';

import '../entity/Request.dart';
import '../service/Service.dart';
import 'NewRequestPage.dart';
import 'VerificationPage.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  bool _warningVisible = false;
  String _warningText = "test";
  bool _obscureText = true;
  Service service = Service();
  final _formKey = GlobalKey<FormState>();

  void _showPwd() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // void warningOn(String text) {
  //   setState(() {
  //     _warningText = text;
  //     _warningVisible = true;
  //   });
  // }
  //
  // void warningOff(String text) {
  //   setState(() {
  //     _warningVisible = false;
  //   });
  // }
  //
  // Text? _getWarning() {
  //   return _warningVisible == true
  //       ? Text(
  //           '$_warningText',
  //           style: TextStyle(
  //               // color: Color(0xff9ACD32), fontSize: 25.0),
  //               color: Colors.red,
  //               fontSize: 18.0),
  //         )
  //       : null;
  // }
  var txt = TextEditingController(); // TODO убрать

  @override
  Widget build(BuildContext context) {
    txt.text = 'login'; // TODO убрать

    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                child: Form(
                    key: _formKey,
                    child: Container(
                        padding: const EdgeInsets.all(30.0),
                        color: Colors.white,
                        child: Container(
                            child: Center(
                                child: Column(children: [
                          Padding(padding: EdgeInsets.only(top: 40.0)),
                          Text(
                            'Авторизация',
                            style: TextStyle(
                                // color: Color(0xff9ACD32), fontSize: 25.0),
                                color: Colors.lightGreen[600],
                                fontSize: 30.0),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                            // child: Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: _getWarning(),
                            // )
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          loginField(),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          passwordField(),
                          Padding(padding: EdgeInsets.only(top: 15.0)),
                          logInButton(),
                          signUpButton(),
                                  generateButton()
                        ]))))))));
  }

  TextFormField loginField() {
    return TextFormField(
        controller: txt, // TODO убрать
        style: TextStyle(color: Colors.grey[600], fontSize: 20),
        decoration: InputDecoration(
          labelText: "Логин",
          labelStyle: TextStyle(color: Colors.lightGreen),
          // fillColor: Colors.lightGreen,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.lightGreen)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Заполните поле \"Логин\"";
            // todo проверять пользователя в базе
          } else if (false) {
            return "Неверный логин или пароль";
          } else {
            return null;
          }
        });
  }

  TextFormField passwordField() {
    return TextFormField(
      controller: txt, // TODO убрать
        style: TextStyle(color: Colors.grey[600], fontSize: 20),
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: "Пароль",
          labelStyle: TextStyle(color: Colors.lightGreen),
          fillColor: Colors.lightBlueAccent,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.lightGreen,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _obscureText
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: Colors.grey,
            ),
            onPressed: () {
              _showPwd();
            },
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Заполните поле \"Пароль\"";
            // todo проверять пользователя в базе
          } else if (false) {
            return "Неверный логин или пароль";
          } else {
            return null;
          }
        });
  }

  OutlinedButton logInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        // side: BorderSide(
        //     color: Color(0x80808099), width: 1.4)
      ),
      onPressed: () {
        // service.postRequest(Request.optional(
        //     price: 1000, source: "Москва", destination: "ТЛЦ"));
        if (_formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewRequestPage()),
          );
        }
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            "Войти",
            style: TextStyle(fontSize: 23.0, color: Colors.lightGreen[600]),
          )),
    );
  }

  OutlinedButton signUpButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.lightGreen[600]?.withOpacity(0.8),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationPage()),
          );
        },
        child: Text(
          "Первичная регистрация",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ));
  }

  int cnt = 0;

  OutlinedButton generateButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.lightGreen[600]?.withOpacity(0.8),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
        onPressed: () {
          cnt++;
          service.postRequest(Request(500, "Shipper", "Receiver", DateTime.utc(2021, 3, 8),
              Duration(hours: 3), 120, "ТЛЦ", "Владивосток$cnt", 680, "comment", 0));
        },
        child: Text(
          "сгенерировать",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ));
  }
}

// class _EntryPageState extends State<EntryPage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }
