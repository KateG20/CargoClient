import 'package:flutter/material.dart';
import 'package:flutter1/UI/RegistrationPage.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();

  // bool _warningVisible = false;
  // String _warningText = "test";

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
  //   return _warningVisible == true ? Text('$_warningText',
  //     style:  TextStyle(
  //       // color: Color(0xff9ACD32), fontSize: 25.0),
  //         color: Colors.red,
  //         fontSize: 18.0),
  //   ) : null;
  // }

  @override
  Widget build(BuildContext context) {
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
                              // child: Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: _getWarning(),
                              // )
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            keyField(),
                            Padding(padding: EdgeInsets.only(top: 15.0)),
                            verifyButton(),
                          ])),
                        ))))));
  }

  TextFormField keyField() {
    return TextFormField(
      style: TextStyle(color: Colors.grey[600], fontSize: 20),
      decoration: InputDecoration(
        labelText: "Ключ",
        labelStyle: TextStyle(color: Colors.lightGreen[600]),
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
          return "Заполните поле \"Ключ\"";
          // todo проверять ключ в базе
        } else if (false) {
          return "Такого ключа нет в базе";
        } else {
          return null;
        }
      },
    );
  }

  OutlinedButton verifyButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        // side: BorderSide(
        //     color: Color(0x80808099), width: 1.4)
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
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
            style: TextStyle(fontSize: 23.0, color: Colors.lightGreen[700]),
          )),
    );
  }
}
