import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/LocalUserProvider.dart';

import '../entity/Request.dart';
import '../entity/User.dart';
import '../service/RequestService.dart';
import '../service/UserService.dart';
import 'NewRequestPage.dart';
import 'VerificationPage.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  // bool _warningVisible = false;
  // String _warningText = "test";
  bool _obscureText = true;
  bool _incorrectData = false;
  RequestService service = RequestService();
  final _formKey = GlobalKey<FormState>();
  var userService = UserService();

  var _loginCtrl = TextEditingController();
  var _pwdCtrl = TextEditingController();

  void _showPwd() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginCtrl.text = 'log2'; // TODO убрать
    _pwdCtrl.text = 'pwd';

    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Form(
                        key: _formKey,
                        child: Container(
                            padding: EdgeInsets.all(30.0),
                            // color: Colors.white,
                            color: Colors.yellow[50]?.withOpacity(0.2),
                            child: Container(
                                child: Center(
                                    child: Column(children: [
                              Padding(padding: EdgeInsets.only(top: 40.0)),
                              Text(
                                'Авторизация',
                                //${DateTime(2030).millisecondsSinceEpoch - DateTime(2020).millisecondsSinceEpoch}',
                                style: TextStyle(
                                    // color: Color(0xff9ACD32), fontSize: 25.0),
                                    color: Colors.lightGreen[700],
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
                            ])))))))));
  }

  TextFormField loginField() {
    return TextFormField(
        controller: _loginCtrl, // TODO убрать
        style: TextStyle(color: Colors.grey[600], fontSize: 20),
        decoration: InputDecoration(
          labelText: "Логин",
          labelStyle: TextStyle(color: Colors.lightGreen),
          // fillColor: Colors.lightGreen,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.7), width: 1.7)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.lightGreen, width: 1.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Заполните поле \"Логин\"";
          } else if (_incorrectData) {
            return 'Неверный логин или пароль';
          } else {
            return null;
          }
        });
  }

  TextFormField passwordField() {
    return TextFormField(
        controller: _pwdCtrl,
        style: TextStyle(color: Colors.grey[600], fontSize: 20),
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: "Пароль",
          labelStyle: TextStyle(
            color: Colors.lightGreen,
          ),
          fillColor: Colors.lightBlueAccent,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.7), width: 1.7)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.lightGreen, width: 1.7)),
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
          } else if (_incorrectData) {
            return 'Неверный логин или пароль';
          } else {
            return null;
          }
        });
  }

  OutlinedButton logInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.green[800],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          side: BorderSide(color: Colors.lightGreen, width: 1.5),
          backgroundColor: Colors.lightGreen[50]),
      onPressed: () async {
          await userService
              .loginUser(_loginCtrl.text,
                  sha256.convert(utf8.encode(_pwdCtrl.text)).toString())
              .then((value) {
            LocalUserProvider.user = value;
          }).catchError((error) {_incorrectData = true;});

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
            style: TextStyle(color: Colors.lightGreen[700], fontSize: 20),
          )),
    );
  }

  // OutlinedButton signUpButton0() {
  //   return OutlinedButton(
  //       style: OutlinedButton.styleFrom(
  //           backgroundColor: Colors.lightGreen[600]?.withOpacity(0.8),
  //           shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(15.0)))),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => VerificationPage()),
  //         );
  //       },
  //       child: Text(
  //         "Первичная регистрация",
  //         style: TextStyle(fontSize: 18.0, color: Colors.white),
  //       ));
  // }

  OutlinedButton signUpButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.lightGreen[800],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        side: BorderSide(color: Colors.lightGreen[300]!, width: 1.5),
        minimumSize: Size(150, 30),
        // backgroundColor: Colors.lightGreen[50]
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerificationPage()),
        );
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            "Первичная регистрация",
            style: TextStyle(color: Colors.lightGreen[600], fontSize: 18),
          )),
    );
  }

  int cnt = 0;
  var rnd = new Random();
  var cities = [
    "ТЛЦ",
    "Иркутск",
    "Москва",
    "Санкт-Петербург",
    "Владивосток",
    "Казань",
    "Уфа"
  ];

  OutlinedButton generateButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.lightGreen[600]?.withOpacity(0.8),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
        onPressed: () {
          cnt++;
          service.postRequest(Request(
              rnd.nextInt(700) + 300,
              "Shipper",
              "Receiver",
              DateTime.utc(rnd.nextInt(4) + 2020, rnd.nextInt(12) + 1,
                  rnd.nextInt(31) + 1),
              Duration(hours: rnd.nextInt(19), minutes: rnd.nextInt(60)),
              rnd.nextInt(450) + 50,
              cities[rnd.nextInt(7)],
              cities[rnd.nextInt(7)],
              rnd.nextInt(9900) + 100,
              "Комментарий",
              rnd.nextInt(3)));
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
