// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/RequestListModel.dart';
import 'package:flutter1/UI/NewRequestPage.dart';
import 'package:flutter1/entity/Request.dart';
import 'package:flutter1/service/Service.dart';
import 'package:intl/intl.dart';

class FilterDialog {
  bool _dateWarningVisibility = false;
  bool _considerDateFrom = false, _considerDateTo = false;
  DateTime? _selectedDateFrom = DateTime.now();
  DateTime? _selectedDateTo = DateTime.now();
  String? _source, _destination;
  int? _minWeight, _maxWeight, _minPrice, _maxPrice, _minDist, _maxDist;
  final _formKey = GlobalKey<FormState>();
  final String _emptyDate = '                     ';

  String _dateFromText = '                     ';
  String _dateToText = '                     ';

  final Service service = Service();

  _selectDate(context, dialogSetState, bool from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: from ? _selectedDateFrom! : _selectedDateTo!,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: from ? 'Выберите начальную дату' : 'Выберите конечную дату',
      locale: const Locale("ru", "RU"),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: TextTheme(
              headline1: TextStyle(color: Colors.green[800], fontSize: 24),
              headline2: TextStyle(color: Colors.green[800], fontSize: 24),
              headline3: TextStyle(color: Colors.green[800], fontSize: 24),
              // headline4: TextStyle(color: Colors.green[800], fontSize: 24)
            ),
            colorScheme: ColorScheme.dark(
              primary: Colors.green[800]!,
              onPrimary: Colors.white,
              surface: Colors.white, //yellow[50]!,
              onSurface: Colors.green[800]!,
            ),
            dialogBackgroundColor: Colors.white, //yellow[50],
          ),
          child: child!,
        );
      },
    );
    if (from) {
      if (picked != null && picked != _selectedDateFrom)
        dialogSetState(() {
          _selectedDateFrom = picked;
          _considerDateFrom = true;
          _dateFromText = '${DateFormat('dd.MM.yyyy').format(picked)}';
          _dateWarningVisibility = false;
        });
    } else if (picked != null && picked != _selectedDateTo)
      dialogSetState(() {
        _selectedDateTo = picked;
        _considerDateTo = true;
        _dateToText = '${DateFormat('dd.MM.yyyy').format(picked)}';
        _dateWarningVisibility = false;
      });
  }

  FilterDialog(BuildContext context, setState, Future<List<Request>> futureList, RequestListModel list, status) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, dialogSetState) {
            return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Form(
                    key: _formKey,
                    child: SimpleDialog(
                        insetPadding: EdgeInsets.all(10),
                        title: Center(
                            child: Text('Поиск заявок ${list.requests.length}',
                                style: TextStyle(
                                    color: Colors.green[800], fontSize: 24))),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        children: [
                          Container(
                              width: 350,
                              // height: 400,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sourceField(),
                                    destinationField(),
                                    dateField(context, dialogSetState),
                                    weightField(),
                                    priceField(),
                                    distanceField(),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 7)),
                                    Center(
                                      child: filterButton(context, setState,
                                          dialogSetState, futureList, list, status),
                                    )
                                  ]))
                        ])));
          });
        });
  }

  Widget sourceField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Точка отправки',
                style: TextStyle(
                    color: Colors.green[800]?.withOpacity(0.85), fontSize: 20)),
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
                  _source = text;
                })
          ],
        ));
  }

  Widget destinationField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Точка прибытия',
                style: TextStyle(
                    color: Colors.green[800]?.withOpacity(0.85), fontSize: 20)),
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
                  _destination = text;
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
                    color: Colors.green[800]?.withOpacity(0.85), fontSize: 20)),
            Visibility(
                child: Text('Некорректный промежуток',
                    style: TextStyle(color: Colors.red[800], fontSize: 19)),
                visible: _dateWarningVisibility)
          ]),
          Row(
            children: [
              Text('C  ',
                  style: TextStyle(color: Colors.green[800], fontSize: 20)),
              Padding(padding: EdgeInsets.fromLTRB(1, 0, 1, 0)),
              TextButton(
                  onPressed: () => _selectDate(context, dialogSetState, true),
                  child: Text(_dateFromText,
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 21,
                        decoration: TextDecoration.underline,
                      ))),
              IconButton(
                  icon:
                      Icon(Icons.cancel_outlined, color: Colors.grey, size: 25),
                  onPressed: () {
                    dialogSetState(() {
                      _considerDateFrom = false;
                      _dateFromText = _emptyDate;
                      _selectedDateFrom = DateTime.now();
                    });
                  }),
            ],
          ),
          Row(children: [
            Text('По',
                style: TextStyle(color: Colors.green[800], fontSize: 20)),
            TextButton(
                onPressed: () => _selectDate(context, dialogSetState, false),
                child: Text(_dateToText,
                    style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 21,
                        decoration: TextDecoration.underline))),
            IconButton(
                icon: Icon(Icons.cancel_outlined, color: Colors.grey, size: 25),
                onPressed: () {
                  dialogSetState(() {
                    _dateToText = _emptyDate;
                    _considerDateTo = false;
                    _selectedDateTo = DateTime.now();
                  });
                }),
          ])
        ]));
  }

  Widget weightField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Вес груза (кг)',
              style: TextStyle(
                  color: Colors.green[800]?.withOpacity(0.85), fontSize: 20)),
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
                    })),
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
                  _maxWeight = 100000;
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

  Widget priceField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Цена перевозки (руб.)',
              style: TextStyle(
                  color: Colors.green[800]?.withOpacity(0.85), fontSize: 20)),
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
                        _minPrice = 0;
                        return null;
                      }
                      int? num = int.tryParse(val);
                      if (num == null || num < 0) {
                        return "Некорректное значение";
                      } else {
                        _minPrice = num;
                        return null;
                      }
                    })),
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
                  _maxPrice = 1000000;
                  return null;
                }
                int? num = int.tryParse(val);
                if (num == null || num < 0) {
                  return "Некорректное значение";
                } else {
                  _maxPrice = num;
                  return null;
                }
              },
            )),
          ])
        ]));
  }

  Widget distanceField() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Расстояние (км)',
              style: TextStyle(
                  color: Colors.green[800]?.withOpacity(0.85), fontSize: 20)),
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
                        _minDist = 0;
                        return null;
                      }
                      int? num = int.tryParse(val);
                      if (num == null || num < 0) {
                        return "Некорректное значение";
                      } else {
                        _minDist = num;
                        return null;
                      }
                    })),
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
                  _maxDist = 100000;
                  return null;
                }
                int? num = int.tryParse(val);
                if (num == null || num < 0) {
                  return "Некорректное значение";
                } else {
                  _maxDist = num;
                  return null;
                }
              },
            )),
          ])
        ]));
  }

  OutlinedButton filterButton(context, setState, dialogSetState, futureList, list, status) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.green[800],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          side:
              BorderSide(color: Colors.green[800]!.withOpacity(0.7), width: 2),
          minimumSize: Size(150, 30)),
      // backgroundColor: Colors.lightGreen[50]),
      onPressed: () {
        if (_selectedDateFrom!.isAfter(_selectedDateTo!)) {
          dialogSetState(() {
            _dateWarningVisibility = true;
          });
          return;
        }

        if (_formKey.currentState!.validate()) {
          List<Function> funcs = [];
          int _resultDateFrom = 0;
          int _resultDateTo = 335619200000;

          if (_source == null || _source!.isEmpty) _source = 'any';
          if (_destination == null || _destination!.isEmpty)
            _destination = 'any';

          if (_considerDateFrom) {
            if (_selectedDateFrom != null)
              _resultDateFrom = _selectedDateFrom!.millisecondsSinceEpoch -
                  DateTime(2020).millisecondsSinceEpoch;
          }
          if (_considerDateTo) {
            // funcs.add((Request r) =>
            //     r.date?.isAfter(_selectedDateFrom!));
            if (_selectedDateTo != null)
              _resultDateTo = _selectedDateTo!.millisecondsSinceEpoch -
                  DateTime(2020).millisecondsSinceEpoch;
            // funcs.add((Request r) =>
            //     r.date?.isBefore(_selectedDateTo!));
          }

          // _minWeight, _maxWeight, _minPrice, _maxPrice, _minDist, _maxDist
          if (_minWeight == null) _minWeight = 0;
          if (_minPrice == null) _minPrice = 0;
          if (_minDist == null) _minDist = 0;
          if (_maxWeight == null) _maxWeight = 100000;
          if (_maxPrice == null) _maxPrice = 1000000;
          if (_maxDist == null) _maxDist = 100000;
          // TODO заловеркейсить все строки

          setState(() {
            futureList = service.filterRequests(status, _source!, _destination!,
                _resultDateFrom, _resultDateTo, _minWeight!, _maxWeight!,
                _minPrice!, _maxPrice!, _minDist!, _maxDist!);
            // list.filter(funcs);
          });
          // });
          Navigator.pop(context, true);
        }
        // list.filter(funcs);
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text('Поиск заявок',
              style: TextStyle(
                  color: Colors.green[800]!.withOpacity(0.7), fontSize: 20))),
    );
  }
}
