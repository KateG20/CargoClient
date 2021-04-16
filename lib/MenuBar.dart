import 'package:flutter/material.dart';

import 'EntryPage.dart';
import 'NewRequestPage.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => Material(
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
                                    'Курсач Курсач Курсач',
                                    style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  // padding: EdgeInsets.only(
                                  //     left: 10, bottom: 5, right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Text(
                                    'Номер ТС: Т704СВ199',
                                    style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  // padding: EdgeInsets.only(
                                  //     left: 10, bottom: 5, right: 20),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: Text(
                                    'Не является представителем компании',
                                    style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  )),
                            ]),
                        // margin: EdgeInsets.only(bottom: 8),
                        // padding: EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[50],
                        )),
                    Container(
                        child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.format_list_bulleted_rounded,
                              size: 30),
                          // leading: Icon(Icons.list_rounded, size: 30),
                          title: Text('Новые заявки',
                              style: TextStyle(fontSize: 20)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequestPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings_backup_restore_rounded,
                              size: 30),
                          title: Text('Заявки на выполнении',
                              style: TextStyle(fontSize: 20)),
                          onTap: () => {}, //{Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: Icon(Icons.done_outline_rounded, size: 30),
                          title: Text('Выполненные заявки',
                              style: TextStyle(fontSize: 20)),
                          onTap: () => {}, //{Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: Icon(Icons.settings_outlined, size: 30),
                          title:
                              Text('Настройки', style: TextStyle(fontSize: 20)),
                          onTap: () => {}, //{Navigator.of(context).pop()},
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app_rounded, size: 30),
                          title: Text('Выйти', style: TextStyle(fontSize: 20)),
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
                ))));
    // Drawer(
    //   child: ListView(
    //     children: <Widget>[
    //       FittedBox(
    //           // fit: BoxFit.none,
    //           child: DrawerHeader(
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Padding(
    //                       padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
    //                       child: Text(
    //                         'Курсач Курсач Курсач',
    //                         style: TextStyle(
    //                             color: Colors.green[900],
    //                             fontSize: 25,
    //                             fontWeight: FontWeight.w500),
    //                       )),
    //                   Padding(
    //                       padding: EdgeInsets.only(left: 10, bottom: 5, right: 10),
    //                       child: Text(
    //                         'Номер ТС: Т704СВ199',
    //                         style: TextStyle(
    //                             color: Colors.green[900],
    //                             fontSize: 20,
    //                             fontWeight: FontWeight.normal),
    //                       )),
    //                   Padding(
    //                       padding: EdgeInsets.only(left: 10, bottom: 5, right: 20),
    //                       child: Text(
    //                         'Не является представителем компании',
    //                         style: TextStyle(
    //                             color: Colors.green[900],
    //                             fontSize: 20,
    //                             fontWeight: FontWeight.normal),
    //                       )),
    //                 ]),
    //             // margin: EdgeInsets.only(bottom: 8),
    //             // padding: EdgeInsets.all(40),
    //             decoration: BoxDecoration(
    //               color: Colors.lightGreen[50],
    //             ),
    //           )),
    //       ListTile(
    //         leading: Icon(Icons.format_list_bulleted_rounded, size: 30),
    //         // leading: Icon(Icons.list_rounded, size: 30),
    //         title: Text('Новые заявки', style: TextStyle(fontSize: 20)),
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => RequestPage()),
    //           );
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.settings_backup_restore_rounded, size: 30),
    //         title: Text('Заявки на выполнении', style: TextStyle(fontSize: 20)),
    //         onTap: () => {}, //{Navigator.of(context).pop()},
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.done_outline_rounded, size: 30),
    //         title: Text('Выполненные заявки', style: TextStyle(fontSize: 20)),
    //         onTap: () => {}, //{Navigator.of(context).pop()},
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.settings_outlined, size: 30),
    //         title: Text('Настройки', style: TextStyle(fontSize: 20)),
    //         onTap: () => {}, //{Navigator.of(context).pop()},
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.exit_to_app_rounded, size: 30),
    //         title: Text('Выйти', style: TextStyle(fontSize: 20)),
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => EntryPage()),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
