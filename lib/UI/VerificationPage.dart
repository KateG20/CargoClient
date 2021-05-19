import 'package:flutter/material.dart';

import '../ViewModel/ServiceViewModel.dart';
import '../entity/Key.dart' as my;
import '../entity/User.dart';
import '../exception/NoKeyFoundException.dart';
import '../provider/LocalUserProvider.dart';
import 'RegistrationPage.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final ServiceViewModel vm = ServiceViewModel();
  my.Key? _key;
  String? _errorMsg;
  var _keyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                            padding: const EdgeInsets.all(30.0),
                            color: Colors.white,
                            child: Container(
                              color: Colors.yellow[50]?.withOpacity(0.2),
                              child: Center(
                                  child: Column(children: [
                                Padding(padding: EdgeInsets.only(top: 40.0)),
                                Text(
                                  'Введите ключ, который вам предоставила ваша компания для входа',
                                  style: TextStyle(
                                      // color: Color(0xff9ACD32), fontSize: 25.0),
                                      color: Colors.lightGreen[700],
                                      fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                ),
                                //  Padding(padding: EdgeInsets.only(top: 20.0)),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20.0)),
                                _keyField(),
                                Padding(padding: EdgeInsets.only(top: 15.0)),
                                _verifyButton(),
                              ])),
                            )))))));
  }

  TextFormField _keyField() {
    return TextFormField(
      controller: _keyCtrl,
      style: TextStyle(color: Colors.grey[600], fontSize: 20),
      decoration: InputDecoration(
        labelText: "Ключ",
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
          return 'Заполните поле \"Ключ\"';
        }
        // Если не нашелся, то не нашелся
        else if (_key == null)
          return _errorMsg;
        else {
          return null;
        }
      },
    );
  }

  Widget _verifyButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        side: BorderSide(color: Colors.lightGreen, width: 1.5),
      ),
      onPressed: () async {
        await vm.checkKey(_keyCtrl.text).then((value) {
          _key = value;
        }).catchError((e) {
          if (e is NoKeyFoundException)
            _errorMsg = 'Такого ключа нет в базе';
          else
            _errorMsg = 'Ошибка проверки ключа';
          _key = null;
        });

        if (_formKey.currentState!.validate()) {
          var user = User.unregistered(
              _key!.name, _key!.licensePlate, _key!.company, _key!.value);
          LocalUserProvider.user = user;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationPage()),
          );
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
