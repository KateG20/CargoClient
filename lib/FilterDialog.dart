import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

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
  DateTime? _selectedDateFrom = DateTime.now();
  DateTime? _selectedDateTo = DateTime.now();
  String? _placeFrom, _placeTo;
  int? _weight;

  // тут можно не указывать типы???7
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
          _dateWarningVisibility = false;
        });
    } else if (picked != null && picked != _selectedDateTo)
      setState(() {
        _selectedDateTo = picked;
        _dateWarningVisibility = false;
      });
  }

  FilterDialog(BuildContext context) {

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return MaterialApp(
              localizationsDelegates: [GlobalMaterialLocalizations.delegate],
              supportedLocales: [const Locale('en'), const Locale('fr')],
              home: StatefulBuilder(builder: (context, setState) {
                return SimpleDialog(
                    insetPadding: EdgeInsets.all(10),
                    title: Center(
                        child: Text('Поиск заявок',
                            style: TextStyle(
                                color: Colors.green[900], fontSize: 24))),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    children: [
                      Container(
                          width: 350,
                          // height: 400,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Точка отправки',
                                            style: TextStyle(
                                                color: Colors.green[900]
                                                    ?.withOpacity(0.85),
                                                fontSize: 20)),
                                        TextField(
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 20),
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText: 'Откуда'),
                                            onChanged: (text) {})
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Точка прибытия',
                                            style: TextStyle(
                                                color: Colors.green[900]
                                                    ?.withOpacity(0.85),
                                                fontSize: 20)),
                                        TextField(
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 20),
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText: 'Куда'),
                                            onChanged: (text) {})
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Дата',
                                                    style: TextStyle(
                                                        color: Colors.green[900]
                                                            ?.withOpacity(0.85),
                                                        fontSize: 20)),
                                                Visibility(
                                                    child: Text(
                                                        'Некорректный промежуток',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20)),
                                                    visible:
                                                        _dateWarningVisibility)
                                              ]),
                                          Row(
                                            children: [
                                              Text('C',
                                                  style: TextStyle(
                                                      color: Colors.green[900],
                                                      fontSize: 20)),
                                              TextButton(
                                                  onPressed: () => _selectDate(
                                                      context, setState, true),
                                                  child: Text(
                                                      '${DateFormat('dd.MM.yyyy').format(_selectedDateFrom!)}',
                                                      style: TextStyle(
                                                        color:
                                                            Colors.green[900],
                                                        fontSize: 23,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ))),
                                              Text('по',
                                                  style: TextStyle(
                                                      color: Colors.green[900],
                                                      fontSize: 20)),
                                              TextButton(
                                                  onPressed: () => _selectDate(
                                                      context, setState, false),
                                                  child: Text(
                                                      '${DateFormat('dd.MM.yyyy').format(_selectedDateTo!)}',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[900],
                                                          fontSize: 23,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)))
                                            ],
                                          ),
                                        ])),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Вес груза (кг)',
                                              style: TextStyle(
                                                  color: Colors.green[900]
                                                      ?.withOpacity(0.85),
                                                  fontSize: 20)),
                                          TextField(
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 20),
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  hintText: 'Вес'),
                                              onChanged: (text) {}),
                                        ])),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 7)),
                                Center(
                                    child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      primary: Colors.green[900],
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0))),
                                      side: BorderSide(
                                          color: Colors.green[900]!
                                              .withOpacity(0.7),
                                          width: 2),
                                      minimumSize: Size(150, 30)),
                                  // backgroundColor: Colors.lightGreen[50]),
                                  onPressed: () {
                                    if (_selectedDateFrom!
                                        .isAfter(_selectedDateTo!)) {
                                      setState(() {
                                        _dateWarningVisibility = true;
                                      });
                                      return;
                                    }
                                    // context.widget todo вот тут шо-то непонятное
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(7),
                                      child: Text('Поиск заявок',
                                          style: TextStyle(
                                              color: Colors.green[900]!
                                                  .withOpacity(0.7),
                                              fontSize: 20))),
                                ))
                              ]))
                    ]);
              }));
        });
  }
}
