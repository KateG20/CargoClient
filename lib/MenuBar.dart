import 'package:flutter/material.dart';

import 'EntryPage.dart';
import 'Design.dart';
import 'NewRequestPage.dart';
import 'CurrentRequestPage.dart';
import 'ArchiveRequestPage.dart';

class MenuBar extends StatelessWidget {
  final String name = "Курсач Курсач Курсач";
  final String autoNumber = "Т704СВ199";
  final String company = "Не является представителем компании";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
              child: Container(
                  color: Colors.yellow[50]?.withOpacity(0.4),
                    child: Column(
                  children: [
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
                                  child: Text(
                                    '$name',
                                    style: TextStyle(
                                        color: Colors.brown[900],
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Text(
                                    'Номер ТС: $autoNumber',
                                    style: TextStyle(
                                        // color: Colors.green[900],
                                        // color: Colors.lime[900],
                                        color: Colors.brown[900],
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  // padding: EdgeInsets.only(
                                  //     left: 10, bottom: 5, right: 20),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: Text(
                                    '$company',
                                    style: TextStyle(
                                        // color: Colors.green[900],
                                        // color: Colors.lime[900],
                                        color: Colors.brown[900],
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  )),
                            ]),
                        // margin: EdgeInsets.only(bottom: 8),
                        // padding: EdgeInsets.all(40),
                        // decoration: BoxDecoration(
                        //   color: Colors.yellow[50]?.withOpacity(0.5),
                        // )
                      decoration: Design().menuHeaderBoxDecoration(),
                    ),
                    Container(
                        child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.format_list_bulleted_rounded,
                              size: 30, color: Colors.brown[900]),
                          // leading: Icon(Icons.list_rounded, size: 30),
                          title: Text('Новые заявки',
                              style: TextStyle(fontSize: 20, color: Colors.brown[900])),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewRequestPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings_backup_restore_rounded,
                              size: 30, color: Colors.brown[900]),
                          title: Text('Заявки на выполнении',
                              style: TextStyle(fontSize: 20, color: Colors.brown[900])),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CurrentRequestPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.done_outline_rounded, size: 30, color: Colors.brown[900]),
                          title: Text('Выполненные заявки',
                              style: TextStyle(fontSize: 20, color: Colors.brown[900])),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArchiveRequestPage()),
                            );
                          }, //{Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: Icon(Icons.settings_outlined, size: 30, color: Colors.brown[900]),
                          title:
                              Text('Настройки', style: TextStyle(fontSize: 20, color: Colors.brown[900])),
                          onTap: () => {}, //{Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app_rounded, size: 30, color: Colors.brown[900]),
                          title: Text('Выйти', style: TextStyle(fontSize: 20, color: Colors.brown[900])),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EntryPage()),
                            );
                          },
                        )
                      ],
                    ))
                  ],
                )))));
  }
}
