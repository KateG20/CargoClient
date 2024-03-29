import 'package:flutter/material.dart';

import '../ViewModel/ServiceViewModel.dart';
import '../provider/LocalUserProvider.dart';
import 'NewRequestPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  String _pwd1 = "";
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _warning = false;
  var _loginCtrl = TextEditingController();
  var _pwdCtrl = TextEditingController();

  final ServiceViewModel vm = ServiceViewModel();

  void _showPwd1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _showPwd2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                            color: Colors.yellow[50]?.withOpacity(0.2),
                            padding: const EdgeInsets.all(30.0),
                            child: Container(
                                child: Center(
                                    child: Column(children: [
                              Padding(padding: EdgeInsets.only(top: 40.0)),
                              Text(
                                'Придумайте логин и пароль, которые Вы будете использовать '
                                'для входа в приложение',
                                style: TextStyle(
                                    // color: Color(0xff9ACD32), fontSize: 25.0),
                                    color: Colors.lightGreen[700],
                                    fontSize: 20.0),
                                textAlign: TextAlign.center,
                              ),
                              //  Padding(padding: EdgeInsets.only(top: 20.0)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Visibility(
                                        child: Text(
                                            'Не удалось создать пользователя. '
                                            'Вероятно, такой логин уже занят.',
                                            style: TextStyle(
                                                color: Colors.red[800],
                                                fontSize: 19)),
                                        visible: _warning),
                                  )),
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              loginField(),
                              Padding(padding: EdgeInsets.only(top: 15.0)),
                              passwordField(),
                              Padding(padding: EdgeInsets.only(top: 15.0)),
                              repeatPasswordField(),
                              Padding(padding: EdgeInsets.only(top: 15.0)),
                              signUpButton(),
                            ])))))))));
  }

  TextFormField loginField() {
    return TextFormField(
        style: TextStyle(color: Colors.grey[600], fontSize: 20),
        controller: _loginCtrl,
        decoration: InputDecoration(
          labelText: "Логин",
          labelStyle: TextStyle(color: Colors.lightGreen[600]),
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
          } else if (val.length < 6) {
            return "Логин слишком короткий";
          } else if (val.length > 50) {
            return "Логин слишком длинный";
          } else {
            return null;
          }
        });
  }

  TextFormField passwordField() {
    return TextFormField(
        style: TextStyle(color: Colors.grey[600], fontSize: 20),
        controller: _pwdCtrl,
        obscureText: _obscureText1,
        decoration: InputDecoration(
            labelText: "Пароль",
            labelStyle: TextStyle(color: Colors.lightGreen[600]),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.7), width: 1.7)),
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
                  _obscureText1
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _showPwd1();
                })),
        onChanged: (text) {
          _pwd1 = text;
        },
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Заполните поле \"Пароль\"";
          } else if (val.length < 6) {
            return "Пароль слишком короткий";
          } else if (val.length > 50) {
            return "Пароль слишком длинный";
          } else {
            return null;
          }
        });
  }

  TextFormField repeatPasswordField() {
    return TextFormField(
        style: TextStyle(color: Colors.grey[600], fontSize: 20),
        obscureText: _obscureText2,
        decoration: InputDecoration(
            labelText: "Повторите пароль",
            labelStyle: TextStyle(color: Colors.lightGreen[600]),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.7), width: 1.7)),
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
                  _obscureText2
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _showPwd2();
                })),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Заполните поле \"Пароль\"";
          } else if (val != _pwd1) {
            return "Пароли не совпадают";
          } else {
            return null;
          }
        });
  }

  OutlinedButton signUpButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        side: BorderSide(color: Colors.lightGreen, width: 1.5),
      ),
      onPressed: () async {
        setState(() {
          _warning = false;
        });
        if (_formKey.currentState!.validate()) {
          try {
            LocalUserProvider.user =
                await vm.createUser(_loginCtrl.text, _pwdCtrl.text);
          } catch (e) {
            setState(() {
              _warning = true;
            });
          }

          var list = await vm.loginUser(_loginCtrl.text, _pwdCtrl.text);
          LocalUserProvider.user = list[0];
          LocalUserProvider.jSessionId = list[1];
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewRequestPage()));
        }
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            "Ввести",
            style: TextStyle(color: Colors.lightGreen[700], fontSize: 20),
          )),
    );
  }
}
