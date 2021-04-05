import 'package:flutter/material.dart';
import 'RequestPage.dart';
import 'EntryPage.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Меню',
              style: TextStyle(color: Colors.green[900], fontSize: 30),
            ),
            margin: EdgeInsets.only(bottom: 8),
            // padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/cover.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment, size: 30),
            title: Text('Каталог заявок', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RequestPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_turned_in, size: 30),
            title: Text('Подтвержденные заявки', style: TextStyle(fontSize: 20)),
            onTap: () => {}, //{Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.backup, size: 30),
            title: Text('Выполненные заявки', style: TextStyle(fontSize: 20)),
            onTap: () => {}, //{Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 30),
            title: Text('Настройки', style: TextStyle(fontSize: 20)),
            onTap: () => {}, //{Navigator.of(context).pop()},
          ),
          // ListTile(
          //   leading: Icon(Icons.border_color),
          //   title: Text('Feedback'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.exit_to_app, size: 30),
            title: Text('Выйти', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntryPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}