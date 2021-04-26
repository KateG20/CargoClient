import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

  DateTime _selectedDate = DateTime.now();

  // тут можно не указывать типы???7
  _selectDate(context, setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      helpText: 'Выберите начальную дату',
      locale : const Locale("ru","RU"),
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
          // ThemeData.dark().copyWith(
          //     primaryColor: Colors.lightGreen,
          //     accentColor: Colors.green[500],
          //     cardColor: Colors.orangeAccent,
          //     primaryColorLight: Colors.lightGreen,
          //   primaryColorDark: Colors.lightGreen,
          //     backgroundColor: Colors.yellow[50],
          //     highlightColor: Colors.lightGreen,
          //     splashColor: Colors.green[500],
          //     // buttonTheme: ButtonThemeData(
          //     //   textTheme: TextTheme(c),
          //     //   buttonColor: Colors.lightGreen),
          //     dialogBackgroundColor: Colors.yellow[100],
          //   secondaryHeaderColor: Colors.yellow[100],
          //   focusColor: Colors.lightGreen,
          //   buttonColor: Colors.lightGreen,
          // ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  FilterDialog(BuildContext context) {
    // Intl.defaultLocale = "ru_RU";
    // DateTime _selectedDate = DateTime.now();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate
              ],
              supportedLocales: [
                const Locale('en'),
                const Locale('fr')
              ],
          home:
              // Theme(
              //   data: Theme.of(context).copyWith(
              //       primaryColor: Colors.lightGreen,
              //       accentColor: Colors.green[500],
              //       cardColor: Colors.orangeAccent,
              //       backgroundColor: Colors.yellow[50],
              //       highlightColor: Colors.lightGreen,
              //       splashColor: Colors.green[500]),
              //   child:
              StatefulBuilder(builder: (context, setState) {
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Точка отправки',
                                        style: TextStyle(
                                            color: Colors.green[900]
                                                ?.withOpacity(0.85),
                                            fontSize: 20)),
                                    TextField(
                                        decoration:
                                            InputDecoration(hintText: 'Откуда'),
                                        onChanged: (text) {})
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Точка прибытия',
                                        style: TextStyle(
                                            color: Colors.green[900]
                                                ?.withOpacity(0.85),
                                            fontSize: 20)),
                                    TextField(
                                        decoration:
                                            InputDecoration(hintText: 'Куда'),
                                        onChanged: (text) {})
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Дата',
                                          style: TextStyle(
                                              color: Colors.green[900]
                                                  ?.withOpacity(0.85),
                                              fontSize: 20)),
                                      TextButton(
                                          onPressed: () =>
                                              _selectDate(context, setState),
                                          child: Text(
                                              '${DateFormat('dd.MM.yyyy').format(_selectedDate)}')),
                                    ]))
                          ]))
                ]);
          }));
          });
  }
}
