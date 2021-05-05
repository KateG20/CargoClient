// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/RequestListModel.dart';
import 'package:intl/intl.dart';

import 'file:///C:/Users/Lenovo%20X1/IdeaProjects/flutter1/lib/entity/Request.dart';

class FilterDialog {
  // extends StatefulWidget {
//   @override
//   _FilterDialogState createState() => _FilterDialogState();
// }
//
// class _FilterDialogState extends State<FilterDialog> {
//   @override
//   Widget build(BuildContext context) {
//     // Future.delayed(Duration.zero, () => showMyDialog(context));
//     _showSearchDialog(context);
//     return Container();
//   }

  bool _dateWarningVisibility = false;
  bool considerDate = true;
  DateTime? _selectedDateFrom = DateTime.now();
  DateTime? _selectedDateTo = DateTime.now();
  String? _placeFrom, _placeTo;
  int? _minWeight, _maxWeight;

  String _dateFromText = '                    ';
  String _dateToText = '                    ';

  _selectDate(context, setState, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: from ? _selectedDateFrom! : _selectedDateTo!,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      helpText: from ? 'Выберите начальную дату' : 'Выберите конечную дату',
      locale: const Locale("ru", "RU"),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            textTheme: TextTheme(
              headline1: TextStyle(color: Colors.green[900], fontSize: 24),
              headline2: TextStyle(color: Colors.green[900], fontSize: 24),
              headline3: TextStyle(color: Colors.green[900], fontSize: 24),
              // headline4: TextStyle(color: Colors.green[900], fontSize: 24)
            ),
            colorScheme: ColorScheme.dark(
              primary: Colors.green[900]!,
              onPrimary: Colors.white,
              surface: Colors.yellow[50]!,
              onSurface: Colors.green[900]!,
            ),
            dialogBackgroundColor: Colors.yellow[50],
          ),
          child: child!,
        );
      },
    );
    if (from) {
      if (picked != null && picked != _selectedDateFrom)
        setState(() {
          _selectedDateFrom = picked;
          _dateFromText = '${DateFormat('dd.MM.yyyy').format(picked)}';
          _dateWarningVisibility = false;
        });
    } else if (picked != null && picked != _selectedDateTo)
      setState(() {
        _selectedDateTo = picked;
        _dateToText = '${DateFormat('dd.MM.yyyy').format(picked)}';
        _dateWarningVisibility = false;
      });
  }

  FilterDialog(BuildContext context, setState, RequestListModel list) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return
              //   Localizations(
              //     locale: const Locale('ru', 'RU'),
              //     delegates: <LocalizationsDelegate<dynamic>>[
              //       DefaultWidgetsLocalizations.delegate,
              //       DefaultMaterialLocalizations.delegate,
              //     ],
              // child:
              StatefulBuilder(builder: (context, dialogSetState) {
            return SimpleDialog(
                insetPadding: EdgeInsets.all(10),
                title: Center(
                    child: Text('Поиск заявок',
                        style:
                            TextStyle(color: Colors.green[900], fontSize: 24))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                children: [
                  Container(
                      width: 350,
                      // height: 400,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            placeFromField(),
                            // Padding(
                            //     padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text('Точка отправки',
                            //             style: TextStyle(
                            //                 color: Colors.green[900]
                            //                     ?.withOpacity(0.85),
                            //                 fontSize: 20)),
                            //         TextFormField(
                            //             style: TextStyle(
                            //                 color: Colors.grey[600],
                            //                 fontSize: 20),
                            //             decoration: InputDecoration(
                            //                 enabledBorder: UnderlineInputBorder(
                            //                   borderSide: BorderSide(
                            //                       color: Colors.grey),
                            //                 ),
                            //                 focusedBorder: UnderlineInputBorder(
                            //                   borderSide: BorderSide(
                            //                       color: Colors.grey),
                            //                 ),
                            //                 hintText: 'Откуда'),
                            //             onChanged: (text) {
                            //               _placeFrom = text;
                            //             })
                            //       ],
                            //     )),
                            placeToField(),
                            // Padding(
                            //     padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text('Точка прибытия',
                            //             style: TextStyle(
                            //                 color: Colors.green[900]
                            //                     ?.withOpacity(0.85),
                            //                 fontSize: 20)),
                            //         TextFormField(
                            //             style: TextStyle(
                            //                 color: Colors.grey[600],
                            //                 fontSize: 20),
                            //             decoration: InputDecoration(
                            //                 enabledBorder: UnderlineInputBorder(
                            //                   borderSide: BorderSide(
                            //                       color: Colors.grey),
                            //                 ),
                            //                 focusedBorder: UnderlineInputBorder(
                            //                   borderSide: BorderSide(
                            //                       color: Colors.grey),
                            //                 ),
                            //                 hintText: 'Куда'),
                            //             onChanged: (text) {
                            //               _placeTo = text;
                            //             })
                            //       ],
                            //     )),
                            dateField(context, dialogSetState),
                            // Padding(
                            //     padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                            //     child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Text('Дата',
                            //                     style: TextStyle(
                            //                         color: Colors.green[900]
                            //                             ?.withOpacity(0.85),
                            //                         fontSize: 20)),
                            //                 Visibility(
                            //                     child: Text(
                            //                         'Некорректный промежуток',
                            //                         style: TextStyle(
                            //                             color: Colors.red,
                            //                             fontSize: 20)),
                            //                     visible: _dateWarningVisibility)
                            //               ]),
                            //           Row(
                            //             children: [
                            //               Text('C  ',
                            //                   style: TextStyle(
                            //                       color: Colors.green[900],
                            //                       fontSize: 20)),
                            //               Padding(padding: EdgeInsets.fromLTRB(1, 0, 1, 0)),
                            //               TextButton(
                            //                   onPressed: () => _selectDate(
                            //                       context,
                            //                       dialogSetState,
                            //                       true),
                            //                   child: Text(
                            //                       _dateFromText,
                            //                       style: TextStyle(
                            //                         color: Colors.green[900],
                            //                         fontSize: 21,
                            //                         decoration: TextDecoration
                            //                             .underline,
                            //                       ))),
                            //               IconButton(
                            //                   icon: Icon(Icons.cancel_outlined,
                            //                       color: Colors.grey, size: 25),
                            //                   onPressed: () {
                            //                     dialogSetState(() {
                            //                       _dateFromText = '?';
                            //                       _selectedDateFrom = null;
                            //                     });
                            //                   }),
                            //             ],
                            //           ),
                            //           Row(children: [
                            //             Text('По',
                            //                 style: TextStyle(
                            //                     color: Colors.green[900],
                            //                     fontSize: 20)),
                            //             TextButton(
                            //                 onPressed: () => _selectDate(
                            //                     context, dialogSetState, false),
                            //                 child: Text(_dateToText,
                            //                     style: TextStyle(
                            //                         color: Colors.green[900],
                            //                         fontSize: 21,
                            //                         decoration: TextDecoration
                            //                             .underline))),
                            //             IconButton(
                            //                 icon: Icon(Icons.cancel_outlined,
                            //                     color: Colors.grey, size: 25),
                            //                 onPressed: () {
                            //                   dialogSetState(() {
                            //                     _dateToText = '?';
                            //                     _selectedDateTo = null;
                            //                   });
                            //                 }),
                            //           ])
                            //         ])),
                            weightField(),
                            // Padding(
                            //     padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            //     child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           Text('Вес груза (кг)',
                            //               style: TextStyle(
                            //                   color: Colors.green[900]
                            //                       ?.withOpacity(0.85),
                            //                   fontSize: 20)),
                            //           Row(children: [
                            //             Flexible(
                            //                 child: TextFormField(
                            //                     style: TextStyle(
                            //                         color: Colors.grey[600],
                            //                         fontSize: 20),
                            //                     decoration: InputDecoration(
                            //                         enabledBorder:
                            //                             UnderlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.grey),
                            //                         ),
                            //                         focusedBorder:
                            //                             UnderlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.grey),
                            //                         ),
                            //                         hintText: 'Мин.'),
                            //                     onChanged: (text) {
                            //                       if (text.length > 0)
                            //                         // to do валидация что число
                            //                         _weight = int.parse(text);
                            //                     })),
                            //             Padding(
                            //                 padding: EdgeInsets.fromLTRB(
                            //                     5, 0, 5, 0)),
                            //             Flexible(
                            //                 child: TextFormField(
                            //                     style: TextStyle(
                            //                         color: Colors.grey[600],
                            //                         fontSize: 20),
                            //                     decoration: InputDecoration(
                            //                         enabledBorder:
                            //                             UnderlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.grey),
                            //                         ),
                            //                         focusedBorder:
                            //                             UnderlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.grey),
                            //                         ),
                            //                         hintText: 'Макс.'),
                            //                     onChanged: (text) {
                            //                       if (text.length > 0)
                            //                         // to do валидация что число
                            //                         _weight = int.parse(text);
                            //                     })),
                            //           ])
                            //         ])),
                            Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 7)),
                            Center(
                                child: filterButton(context, setState, dialogSetState, list),
                              //     OutlinedButton(
                            //   style: OutlinedButton.styleFrom(
                            //       primary: Colors.green[900],
                            //       shape: const RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(12.0))),
                            //       side: BorderSide(
                            //           color:
                            //               Colors.green[900]!.withOpacity(0.7),
                            //           width: 2),
                            //       minimumSize: Size(150, 30)),
                            //   // backgroundColor: Colors.lightGreen[50]),
                            //   onPressed: () {
                            //     if (_selectedDateFrom!
                            //         .isAfter(_selectedDateTo!)) {
                            //       dialogSetState(() {
                            //         _dateWarningVisibility = true;
                            //       });
                            //       return;
                            //     }
                            //
                            //     List<Function> funcs = [];
                            //
                            //     // if (_placeFrom != null)
                            //     //   funcs
                            //     //       .add((Request r) => r.from == _placeFrom);
                            //     // if (_placeTo != null)
                            //     //   funcs.add((Request r) => r.to == _placeTo);
                            //     if (_minWeight != null)
                            //       funcs.add((Request r) => r.weight == _minWeight);
                            //     // if (considerDate) {
                            //     //   if (_selectedDateFrom != null)
                            //     //     funcs.add((Request r) =>
                            //     //         r.date?.isAfter(_selectedDateFrom!));
                            //     //   if (_selectedDateTo != null)
                            //     //     funcs.add((Request r) =>
                            //     //         r.date?.isBefore(_selectedDateTo!));
                            //     // }
                            //     // setState(() {
                            //
                            //     setState(() {
                            //       list.filter(funcs);
                            //     });
                            //     // });
                            //     Navigator.pop(context, true);
                            //     // list.filter(funcs);
                            //   },
                            //   child: Padding(
                            //       padding: EdgeInsets.all(7),
                            //       child: Text('Поиск заявок',
                            //           style: TextStyle(
                            //               color: Colors.green[900]!
                            //                   .withOpacity(0.7),
                            //               fontSize: 20))),
                            // )
                            )
                          ]))
                ]);
          });
        });
  }

  Widget placeFromField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Точка отправки',
                style: TextStyle(
                    color: Colors.green[900]?.withOpacity(0.85), fontSize: 20)),
            TextFormField(
                style: TextStyle(color: Colors.grey[600], fontSize: 20),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Откуда'),
                onChanged: (text) {
                  _placeFrom = text;
                })
          ],
        ));
  }

  Widget placeToField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Точка прибытия',
                style: TextStyle(
                    color: Colors.green[900]?.withOpacity(0.85), fontSize: 20)),
            TextFormField(
                style: TextStyle(color: Colors.grey[600], fontSize: 20),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Куда'),
                onChanged: (text) {
                  _placeTo = text;
                })
          ],
        ));
  }

  Widget dateField(context, dialogSetState) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Дата',
                style: TextStyle(
                    color: Colors.green[900]?.withOpacity(0.85), fontSize: 20)),
            Visibility(
                child: Text('Некорректный промежуток',
                    style: TextStyle(color: Colors.red, fontSize: 20)),
                visible: _dateWarningVisibility)
          ]),
          Row(
            children: [
              Text('C  ',
                  style: TextStyle(color: Colors.green[900], fontSize: 20)),
              Padding(padding: EdgeInsets.fromLTRB(1, 0, 1, 0)),
              TextButton(
                  onPressed: () => _selectDate(context, dialogSetState, true),
                  child: Text(_dateFromText,
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                      ))),
              IconButton(
                  icon:
                      Icon(Icons.cancel_outlined, color: Colors.grey, size: 25),
                  onPressed: () {
                    dialogSetState(() {
                      _dateFromText = '?';
                      _selectedDateFrom = null;
                    });
                  }),
            ],
          ),
          Row(children: [
            Text('По',
                style: TextStyle(color: Colors.green[900], fontSize: 20)),
            TextButton(
                onPressed: () => _selectDate(context, dialogSetState, false),
                child: Text(_dateToText,
                    style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 21,
                        decoration: TextDecoration.underline))),
            IconButton(
                icon: Icon(Icons.cancel_outlined, color: Colors.grey, size: 25),
                onPressed: () {
                  dialogSetState(() {
                    _dateToText = '?';
                    _selectedDateTo = null;
                  });
                }),
          ])
        ]));
  }

  Widget weightField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Вес груза (кг)',
              style: TextStyle(
                  color: Colors.green[900]?.withOpacity(0.85), fontSize: 20)),
          Row(children: [
            Flexible(
                child: TextFormField(
              style: TextStyle(color: Colors.grey[600], fontSize: 20),
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Мин.'),
              // onChanged: (text) {
              //   if (text.length > 0)
              //     // to do валидация что число
              //     _weight = int.parse(text);
              // },
                  // Валидация, что в поле вписано число
                  // В таком случае записывает это число в переменную,
                  // иначе записывает минимум - 0
              validator: (val) {
                if (val == null || val.isEmpty) {
                  _minWeight = 0;
                  return null;
                }
                int? num = int.tryParse(val);
                if (num == null || num < 0) {
                  return "Некорректное значение";
                } else {
                  _minWeight = num;
                  return null;
                }
              }
            )),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            Flexible(
                child: TextFormField(
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Макс.'),
                    // onChanged: (text) {
                    //   if (text.length > 0)
                    //     // todo валидация что число
                    //     _minWeight = int.parse(text);
                    // },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      _maxWeight = 0;
                      return null;
                    }
                    int? num = int.tryParse(val);
                    if (num == null || num < 0) {
                      return "Некорректное значение";
                    } else {
                      _maxWeight = num;
                      return null;
                    }
                  },
                    )),
          ])
        ]));
  }

  OutlinedButton filterButton(context, setState, dialogSetState, list) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.green[900],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(12.0))),
          side: BorderSide(
              color:
              Colors.green[900]!.withOpacity(0.7),
              width: 2),
          minimumSize: Size(150, 30)),
      // backgroundColor: Colors.lightGreen[50]),
      onPressed: () {
        if (_selectedDateFrom!
            .isAfter(_selectedDateTo!)) {
          dialogSetState(() {
            _dateWarningVisibility = true;
          });
          return;
        }

        List<Function> funcs = [];

        // if (_placeFrom != null)
        //   funcs
        //       .add((Request r) => r.from == _placeFrom);
        // if (_placeTo != null)
        //   funcs.add((Request r) => r.to == _placeTo);
        if (_minWeight != null)
          funcs.add((Request r) => r.weight == _minWeight);
        // if (considerDate) {
        //   if (_selectedDateFrom != null)
        //     funcs.add((Request r) =>
        //         r.date?.isAfter(_selectedDateFrom!));
        //   if (_selectedDateTo != null)
        //     funcs.add((Request r) =>
        //         r.date?.isBefore(_selectedDateTo!));
        // }
        // setState(() {

        setState(() {
          list.filter(funcs);
        });
        // });
        Navigator.pop(context, true);
        // list.filter(funcs);
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text('Поиск заявок',
              style: TextStyle(
                  color: Colors.green[900]!
                      .withOpacity(0.7),
                  fontSize: 20))),
    );
  }
}
