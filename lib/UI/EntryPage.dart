import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter1/service/UserService.dart';

import '../ViewModel/ServiceViewModel.dart';
import '../entity/Request.dart';
import '../entity/User.dart';
import '../provider/LocalUserProvider.dart';
import '../service/RequestService.dart';
import 'NewRequestPage.dart';
import 'VerificationPage.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  bool _obscureText = true;
  bool _incorrectData = false;

  final _formKey = GlobalKey<FormState>();

  final ServiceViewModel vm = ServiceViewModel();

  var _loginCtrl = TextEditingController();
  var _pwdCtrl = TextEditingController();

  void _showPwd() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginCtrl.text = 'log222'; // TODO убрать
    _pwdCtrl.text = 'pwd222';

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
                            color: Colors.yellow[50]?.withOpacity(0.2),
                            child: Container(
                                child: Center(
                                    child: Column(children: [
                              Padding(padding: EdgeInsets.only(top: 40.0)),
                              Text(
                                'Авторизация',
                                style: TextStyle(
                                    color: Colors.lightGreen[700],
                                    fontSize: 30.0),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              _loginField(),
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              _passwordField(),
                              Padding(padding: EdgeInsets.only(top: 15.0)),
                              _logInButton(),
                              _signUpButton(),
                              generateButton()
                            ])))))))));
  }

  TextFormField _loginField() {
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

  TextFormField _passwordField() {
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

  OutlinedButton _logInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.green[800],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          side: BorderSide(color: Colors.lightGreen, width: 1.5),
          backgroundColor: Colors.lightGreen[50]),
      onPressed: () async {
        // await vm.loginUser(_loginCtrl.text, _pwdCtrl.text).then((value) {
        User user = User.nulled();
        String jSessionId = "";
        try {
          var list = await vm.loginUser(_loginCtrl.text, _pwdCtrl.text);
          user = list[0];
          jSessionId = list[1];
          _incorrectData = false;
          LocalUserProvider.user = user;
          LocalUserProvider.jSessionId = jSessionId;
        } catch (e) {
          _incorrectData = true;
        }
        // await UserService()
        //     .loginUser(_loginCtrl.text, _pwdCtrl.text)
        //     .then((value) {
        //   _incorrectData = false;
        //   LocalUserProvider.user = value;
        // }).catchError((error) {
        //   _incorrectData = true;
        // }).then((value) {
        //   if (_formKey.currentState!.validate()) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => NewRequestPage()),
        //     );
        //   }
        // });

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

  OutlinedButton _signUpButton() {
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

  // todo удалить
  OutlinedButton generateButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.lightGreen[600]?.withOpacity(0.8),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
        onPressed: () {
          cnt++;
          RequestService().postRequest(Request(
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
              "Комментарий"));
        },
        child: Text(
          "сгенерировать",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ));
  }
}
