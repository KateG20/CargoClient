import 'package:flutter/material.dart';
import 'package:flutter1/LocalUserProvider.dart';

import 'ArchiveRequestPage.dart';
import 'CurrentRequestPage.dart';
import 'Design.dart';
import 'EntryPage.dart';
import 'NewRequestPage.dart';

class MenuBar extends StatelessWidget {
  final String name = LocalUserProvider.user.name!;
  final String autoNumber = LocalUserProvider.user.licensePlate!;
  final String company = LocalUserProvider.user.company!;

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
                        Padding(padding: EdgeInsets.fromLTRB(7, 30, 7, 0),
                        child:
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(5, 17, 5, 10),
                                    child: Text(
                                      '$name',
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
                                  color: Colors.orange[200]!.withOpacity(0.7),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Номер ТС: $autoNumber',
                                      style: TextStyle(
                                          color: Colors.green[800],
                                          // color: Colors.lime[900],
                                          // color: Colors.brown[900],
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.center,
                                    )),
                                Padding(
                                    // padding: EdgeInsets.only(
                                    //     left: 10, bottom: 5, right: 20),
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                                    child: Text(
                                      '$company',
                                      style: TextStyle(
                                          color: Colors.green[800],
                                          // color: Colors.lime[900],
                                          // color: Colors.brown[900],
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
                          decoration: Design().greenBoxDecoration(),
                          // decoration: Design().menuHeaderBoxDecoration(),
                        )),
                        Container(
                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                            child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.format_list_bulleted_rounded,
                                  size: 30, color: Colors.green[800]),
                              // leading: Icon(Icons.list_rounded, size: 30),
                              title: Text('Новые заявки',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green[800])),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewRequestPage()),
                                );
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                  Icons.settings_backup_restore_rounded,
                                  size: 30,
                                  color: Colors.green[800]),
                              title: Text('Заявки на выполнении',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green[800])),
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
                              title: Text('Выполненные заявки',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green[800])),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ArchiveRequestPage()),
                                );
                              }, //{Navigator.of(context).pop()},
                            ),
                            ListTile(
                              leading: Icon(Icons.settings_outlined,
                                  size: 30, color: Colors.green[800]),
                              title: Text('Настройки',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green[800])),
                              onTap: () => {}, //{Navigator.of(context).pop()},
                            ),
                            ListTile(
                              leading: Icon(Icons.exit_to_app_rounded,
                                  size: 30, color: Colors.green[800]),
                              title: Text('Выйти',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.green[800])),
                              onTap: () {
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
