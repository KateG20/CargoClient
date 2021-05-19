import 'package:flutter/material.dart';
import 'package:flutter1/ViewModel/ServiceViewModel.dart';

import '../provider/LocalUserProvider.dart';
import 'ArchiveRequestPage.dart';
import 'CurrentRequestPage.dart';
import 'EntryPage.dart';
import 'ListWidgets.dart';
import 'NewRequestPage.dart';

class MenuBar extends StatelessWidget {
  final String _name = LocalUserProvider.user.name!;
  final String _autoNumber = LocalUserProvider.user.licensePlate!;
  final String _company = LocalUserProvider.user.company!;
  ServiceViewModel vm = ServiceViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
                child: Container(
                    color: Colors.yellow[50]?.withOpacity(0.4),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(7, 30, 7, 0),
                            child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 17, 5, 10),
                                        child: Text(
                                          '$_name',
                                          style: TextStyle(
                                              // color: Colors.brown[900],
                                              color: Colors.green[800],
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        )),
                                    Divider(
                                      thickness: 3,
                                      indent: 10,
                                      endIndent: 10,
                                      color:
                                          Colors.orange[200]!.withOpacity(0.7),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Номер ТС: $_autoNumber',
                                          style: TextStyle(
                                              color: Colors.green[800],
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 15),
                                        child: Text(
                                          '$_company',
                                          style: TextStyle(
                                              color: Colors.green[800],
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        )),
                                  ]),
                              decoration: ListWidgets().greenBoxDecoration(),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                      Icons.format_list_bulleted_rounded,
                                      size: 30,
                                      color: Colors.green[800]),
                                  title: Text('Новые заявки',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[800])),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewRequestPage()),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                      Icons.settings_backup_restore_rounded,
                                      size: 30,
                                      color: Colors.green[800]),
                                  title: Text('Текущие заявки',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[800])),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CurrentRequestPage()),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.done_outline_rounded,
                                      size: 30, color: Colors.green[800]),
                                  title: Text('Архивные заявки',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[800])),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ArchiveRequestPage()),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.info_outline_rounded,
                                      size: 30, color: Colors.green[800]),
                                  title: Text('Справка',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[800])),
                                  onTap: () => {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SimpleDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0))),
                                            // backgroundColor: Colors.yellow[50],
                                            title: Center(
                                                child: Text('Справка',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.green[800],
                                                        fontSize: 24))),
                                            children: [
                                              Center(
                                                  child: Text(
                                                      'В случае утери пароля необходимо обратиться к Вашему руководству.',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[800],
                                                          fontSize: 21))),
                                              Center(
                                                  child: Text(
                                                      'В случае технических неполадок писать на почту example@cargo.com.',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[800],
                                                          fontSize: 21)))
                                            ],
                                          );
                                        })
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.exit_to_app_rounded,
                                      size: 30, color: Colors.green[800]),
                                  title: Text('Выйти',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[800])),
                                  onTap: () async {
                                    await vm.logout(); // todo ваще не работает
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EntryPage()),
                                    );
                                  },
                                ),
                                Divider(
                                  thickness: 3,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.lightGreen.withOpacity(0.7),
                                ),
                              ],
                            ))
                      ],
                    )))));
  }
}
