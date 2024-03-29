import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../RType.dart';
import '../ViewModel/ServiceViewModel.dart';
import '../entity/Request.dart';
import '../exception/RequestAcceptConflictException.dart';
import '../notifier/ListFilterNotifier.dart';
import '../provider/LocalUserProvider.dart';
import 'FilterDialog.dart';
import 'MenuBar.dart';

class ListWidgets {
  final ServiceViewModel vm = ServiceViewModel();

  static Container pageHeader(BuildContext context,
      ListFilterNotifier futureListNotifier, List<Request> list, int status) {
    return Container(
        decoration: headerBoxDecoration(),
        // header
        height: 90,
        // color: Colors.lightGreen[50],
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: null,
                    child: Text(
                        status == 0
                            ? 'Новые заявки'
                            : status == 1
                                ? 'Текущие заявки'
                                : 'Архивные заявки',
                        style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 27.0,
                            fontWeight: FontWeight.normal)),
                    // padding: EdgeInsets.fromLTRB(45, 7, 0, 0)
                    // padding: EdgeInsets.fromLTRB(40, 8, 0, 0)),
                  ),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 3),
                    // onPressed: () => showSearchDialog(context),
                    onPressed: () =>
                        FilterDialog(context, futureListNotifier, list, status),
                    icon: Icon(Icons.search_rounded),
                    tooltip: 'Поиск',
                    color: Colors.green[700],
                    iconSize: 40,
                  ),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 6),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuBar()),
                      );
                    },
                    icon: Icon(Icons.menu_rounded),
                    tooltip: 'Меню',
                    color: Colors.green[700],
                    iconSize: 45,
                  ),
                ])));
  }

  Widget requestContainer(Request _data, Widget buttonRow) {
    return Container(
        padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
        // большой контейнер
        // колонка - сверху два желтых контейнера, снизу кнопки
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              // два желтых
              height: 170,
              decoration: greenBoxDecoration(),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        // padding: EdgeInsets.only(top: 15),
                        child: Container(
                            // маленький контейнер
                            // контейнер с данными о времени и расстоянии
                            // decoration: dataBoxDecoration(),
                            width: 185,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  // колонка с данными
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: "когда",
                                          style: TextStyle(
                                            color: Colors.green[800]
                                                ?.withOpacity(0.6),
                                            fontSize: 20,
                                          )),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              "${DateFormat('dd.MM.yyyy').format(_data.date!)}",
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 23,
                                          )),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5)),
                                    RichText(
                                      text: TextSpan(
                                          text: "сколько",
                                          style: TextStyle(
                                            color: Colors.green[800]
                                                ?.withOpacity(0.6),
                                            fontSize: 20,
                                          )),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          // text: "${_data.duration?.toString()}",
                                          text:
                                              "${_printDuration(_data.duration!)}",
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 20,
                                          )),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              "${_data.distance?.toString()} км",
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 20,
                                          )),
                                    ),
                                  ],
                                )))),
                    VerticalDivider(
                      color: Colors.orange[100],
                      thickness: 3,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        // padding: EdgeInsets.only(top: 15),
                        child: Container(
                            // контейнер с данными о пунктах назначения
                            // decoration: dataBoxDecoration(),
                            width: 185,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Column(
                                  // колонка с данными
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "откуда",
                                      style: TextStyle(
                                        color:
                                            Colors.green[800]?.withOpacity(0.6),
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${_data.source}",
                                      style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 22,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5)),
                                    Text(
                                      "куда",
                                      style: TextStyle(
                                        color:
                                            Colors.green[800]?.withOpacity(0.6),
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${_data.destination}",
                                      style: TextStyle(
                                        color: Colors.green[800],
                                        fontSize: 22,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ))))
                  ])),
          Padding(
              padding: EdgeInsets.only(top: 1, bottom: 10), child: buttonRow)
        ]));
  }

  static BoxDecoration headerBoxDecoration() {
    return BoxDecoration(
      color: Colors.lightGreen[50],
      border: Border(
          bottom:
              BorderSide(color: Colors.lightGreen.withOpacity(0.7), width: 3)),
      // borderRadius: BorderRadius.all(Radius.circular(12.0)
    );
  }

  BoxDecoration greenBoxDecoration() {
    return BoxDecoration(
        border: Border.all(
          color: Colors.lightGreen.withOpacity(0.7),
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)));
  }

  String _printDuration(Duration duration) {
    String hours = "${duration.inHours.remainder(60)} ч.";
    String minutes = " ${duration.inMinutes.remainder(60)} мин.";
    String res = "";
    if (duration.inHours.remainder(60) > 0) res += hours;
    if (duration.inMinutes.remainder(60) > 0) res += minutes;
    return res;
  }

  Row newRequestRow(ListFilterNotifier futureListNotifier, BuildContext context,
      Request _data) {
    return Row(
      // ряд с тремя кнопками
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        rejectButton(_data, futureListNotifier),
        acceptButton(context, _data, futureListNotifier),
        moreInfoIcon(context, _data),
      ],
    );
  }

  Row currentRequestRow(ListFilterNotifier futureListNotifier,
      BuildContext context, Request _data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(padding: EdgeInsets.only(right: 50)),
        doneButton(_data, futureListNotifier),
        moreInfoIcon(context, _data),
      ],
    );
  }

  Row archiveRequestRow(BuildContext context, Request _data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        moreInfoIcon(context, _data),
      ],
    );
  }

  OutlinedButton rejectButton(
      Request data, ListFilterNotifier futureListNotifier) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.orange,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          side: BorderSide(color: (Colors.orange[200])!, width: 2),
          minimumSize: Size(150, 30),
          backgroundColor: Colors.orange[50]),
      onPressed: () async {
        await vm.rejectRequest(data.id!, LocalUserProvider.user.id!);
        futureListNotifier.value =
            vm.getRequests(RType.news); // обновление списка
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            "Отклонить",
            style: TextStyle(color: Colors.lightGreen[800], fontSize: 20),
          )),
    );
  }

  OutlinedButton acceptButton(BuildContext context, Request data,
      ListFilterNotifier futureListNotifier) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          primary: Colors.lightGreen[800],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          side: BorderSide(color: Colors.lightGreen, width: 2),
          minimumSize: Size(150, 30),
          backgroundColor: Colors.lightGreen[50]),
      onPressed: () async {
        try {
          await vm.acceptRequest(data.id!, LocalUserProvider.user.id!);
          futureListNotifier.value =
              vm.getRequests(RType.news); // обновление списка
        } on RequestAcceptConflictException {
          showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Невозможно принять заявку',
                  style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 24,
                      fontWeight: FontWeight.w500)),
              content: Text(
                  'Заявка уже занята другим пользователем. Обновите страницу.',
                  style: TextStyle(color: Colors.green[800], fontSize: 22)),
              actions: [
                OutlinedButton(
                  child: Text('Ок',
                      style: TextStyle(color: Colors.green[800], fontSize: 20)),
                  onPressed: () => Navigator.pop(c, true),
                ),
              ],
            ),
          );
        } catch (e) {
          showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Невозможно принять заявку',
                  style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 24,
                      fontWeight: FontWeight.w500)),
              content: Text('Ошибка на сервере.',
                  style: TextStyle(color: Colors.green[800], fontSize: 22)),
              actions: [
                OutlinedButton(
                  child: Text('Ок',
                      style: TextStyle(color: Colors.green[800], fontSize: 20)),
                  onPressed: () => Navigator.pop(c, true),
                ),
              ],
            ),
          );
        }
        //     .catchError((error) {
        //   // Ошибка, если заявка уже стала занята другим пользователем
        //   if (error is RequestAcceptConflictException) {
        //     showDialog<bool>(
        //       context: context,
        //       builder: (c) => AlertDialog(
        //         title: Text('Невозможно принять заявку',
        //             style: TextStyle(
        //                 color: Colors.green[800],
        //                 fontSize: 24,
        //                 fontWeight: FontWeight.w500)),
        //         content: Text(
        //             'Заявка уже занята другим пользователем. Обновите страницу.',
        //             style: TextStyle(color: Colors.green[800], fontSize: 22)),
        //         actions: [
        //           OutlinedButton(
        //             child: Text('Ок',
        //                 style:
        //                     TextStyle(color: Colors.green[800], fontSize: 20)),
        //             onPressed: () => Navigator.pop(c, true),
        //           ),
        //         ],
        //       ),
        //     );
        //   } else {
        //     showDialog<bool>(
        //       context: context,
        //       builder: (c) => AlertDialog(
        //         title: Text('Невозможно принять заявку',
        //             style: TextStyle(
        //                 color: Colors.green[800],
        //                 fontSize: 24,
        //                 fontWeight: FontWeight.w500)),
        //         content: Text(
        //             'Ошибка на сервере.',
        //             style: TextStyle(color: Colors.green[800], fontSize: 22)),
        //         actions: [
        //           OutlinedButton(
        //             child: Text('Ок',
        //                 style:
        //                 TextStyle(color: Colors.green[800], fontSize: 20)),
        //             onPressed: () => Navigator.pop(c, true),
        //           ),
        //         ],
        //       ),
        //     );
        //   }
        // });
        // await vm.acceptRequest(data.id!, LocalUserProvider.user.id!);
        // futureListNotifier.value =
        //     vm.getRequests(RType.news); // обновление списка
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            "Принять",
            style: TextStyle(color: Colors.lightGreen[800], fontSize: 20),
          )),
    );
  }

  IconButton moreInfoIcon(BuildContext context, Request _data) {
    return IconButton(
      onPressed: () {
        showInfoDialog(context, _data);
      },
      icon: Icon(Icons.info_outline_rounded),
      tooltip: 'More info',
      color: Colors.lightGreen,
      iconSize: 35,
    );
  }

  OutlinedButton doneButton(
      Request data, ListFilterNotifier futureListNotifier) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        side: BorderSide(color: Colors.lightGreen, width: 2),
        minimumSize: Size(150, 30),
        backgroundColor: Colors.lightGreen[50],
        primary: Colors.lightGreen[800],
      ),
      onPressed: () async {
        await vm.completeRequest(data.id!, LocalUserProvider.user.id!);
        futureListNotifier.value =
            vm.getRequests(RType.current); // обновление списка
      },
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            "Выполнено?",
            style: TextStyle(color: Colors.lightGreen[800], fontSize: 20),
          )),
    );
  }

  void showInfoDialog(BuildContext context, Request _data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            // backgroundColor: Colors.yellow[50],
            title: Center(
                child: Text('Информация о заявке',
                    style: TextStyle(color: Colors.green[800], fontSize: 24))),
            children: [
              InfoDialogItem(name: 'Стоимость:', value: '${_data.price} руб.'),
              InfoDialogItem(
                  name: 'Грузоотправитель:', value: '${_data.shipper}'),
              InfoDialogItem(
                  name: 'Грузополучатель:', value: '${_data.receiver}'),
              InfoDialogItem(
                  name: 'Дата:',
                  value:
                      '${DateFormat('dd.MM.yyyy, hh:mm').format(_data.date!)}'),
              InfoDialogItem(
                  name: 'Протяженность:',
                  value:
                      '${_printDuration(_data.duration!)}, ${_data.distance.toString() + " км"}'),
              InfoDialogItem(
                  name: 'Маршрут:',
                  value: '${_data.source} - ${_data.destination}'),
              InfoDialogItem(name: 'Вес товара:', value: '${_data.weight} кг'),
              InfoDialogItem(
                  name: 'Описание:',
                  value: (_data.description == null ||
                          _data.description?.length == 0)
                      ? 'Комментарий отсутствует'
                      : '${_data.description}'),
              // style: TextStyle(color: Colors.green[800], fontSize: 20),
            ],
          );
        });
  }
}

class InfoDialogItem extends StatelessWidget {
  const InfoDialogItem({required this.name, required this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$name ',
                style: TextStyle(
                    color: Colors.green[800]?.withOpacity(0.7), fontSize: 20)),
            Padding(padding: EdgeInsets.only(top: 5)),
            Text('$value',
                style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 23,
                    fontWeight: FontWeight.w500))
          ],
        ));
  }
}
