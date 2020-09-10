import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EntryPage());
  // runApp(OrderPage());
}

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => new Material(
                child: new Container(
                    padding: const EdgeInsets.all(30.0),
                    color: Colors.white,
                    child: new Container(
                      child: new Center(
                          child: new Column(children: [
                        new Padding(padding: EdgeInsets.only(top: 70.0)),
                        new Text(
                          'Авторизация',
                          style: new TextStyle(
                              color: Colors.lightGreen, fontSize: 25.0),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 30.0)),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Логин",
                            fillColor: Colors.lightBlueAccent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Заполните поле \"Логин\"";
                            } else {
                              return null;
                            }
                          },
                          // keyboardType: TextInputType.emailAddress,
                          // style: new TextStyle(
                          // fontFamily: "Poppins",
                          // ),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 30.0)),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Пароль",
                            fillColor: Colors.lightBlueAccent,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Заполните поле \"Пароль\"";
                            } else {
                              return null;
                            }
                          },
                        ),
                        new Padding(padding: EdgeInsets.only(top: 20.0)),
                        new FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderPage()),
                            );
                          },
                          child: Text(
                            "Войти",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.lightGreen),
                          ),
                        )
                      ])),
                    )))));
  }
}

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: "MyApp",
        home: Builder(
            builder: (context) => new Material(
                    // создали колонку, в которой сначала
                    // ряд меню, а снизу прифигачиваем список
                    child: new Column(children: <Widget>[
                  new Container(
                      // header
                      height: 90,
                      color: Colors.lightGreen[100],
                      child: new Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /*
                                new Padding(
                                    child: FlatButton(
                                        splashColor: Colors.white,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EntryPage()),
                                          );
                                        },
                                        child: Text(
                                          "Выйти",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.red[900]),
                                        )),
                                    // padding: EdgeInsets.fromLTRB(15, 0, 0, 0)
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0)
                          ),
                                */
                                new Padding(
                                    // padding: EdgeInsets.fromLTRB(59, 8, 0, 0),
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: FlatButton(
                                      splashColor: Colors.white,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MenuBar()),
                                        );
                                      },
                                      child: new Text('Меню',
                                          style: new TextStyle(
                                              color: Colors.lightGreen[900],
                                              fontSize: 26.0)),
                                    )),
                                new Padding(
                                    child: new Text('Заказы',
                                        style: new TextStyle(
                                            color: Colors.lightGreen[700],
                                            fontSize: 27.0)),
                                    // padding: EdgeInsets.fromLTRB(45, 7, 0, 0)
                                    padding: EdgeInsets.fromLTRB(40, 8, 0, 0)),
                              ]))),
                  Expanded(
                      child: new ListView.separated(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 170,
                          decoration: orderBoxDecoration(),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              new Padding(
                                  padding: EdgeInsets.fromLTRB(7, 15, 0, 15),
                                  // padding: EdgeInsets.only(top: 15),
                                  child: new Container(
                                      // контейнер с данными о времени и расстоянии
                                      decoration: dataBoxDecoration(),
                                      width: 150,
                                      child: new Padding(
                                          padding: EdgeInsets.all(10),
                                          child: new Column(
                                            // колонка с данными
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              new RichText(
                                                text: TextSpan(
                                                    text: "09.09.2020",
                                                    style: TextStyle(
                                                      color: Colors.green[900],
                                                      fontSize: 23,
                                                    )),
                                              ),
                                              new RichText(
                                                text: TextSpan(
                                                    text: "18 минут",
                                                    style: TextStyle(
                                                      color: Colors.green[900],
                                                      fontSize: 20,
                                                    )),
                                              ),
                                              new RichText(
                                                text: TextSpan(
                                                    text: "5 км",
                                                    style: TextStyle(
                                                      color: Colors.green[900],
                                                      fontSize: 20,
                                                    )),
                                              ),
                                            ],
                                          )))),
                              new Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 7, 15),
                                  // padding: EdgeInsets.only(top: 15),
                                  child: new Container(
                                      // контейнер с данными о времени и расстоянии
                                      decoration: dataBoxDecoration(),
                                      // width: 150,
                                      child: new Padding(
                                          padding: EdgeInsets.all(10),
                                          child: new Column(
                                            // колонка с данными
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              new RichText(
                                                text: TextSpan(
                                                    text: "Владивосток",
                                                    style: TextStyle(
                                                      color: Colors.green[900],
                                                      fontSize: 23,
                                                    )),
                                              ),
                                              new RichText(
                                                text: TextSpan(
                                                    text: "ТЛЦ",
                                                    style: TextStyle(
                                                      color: Colors.green[900],
                                                      fontSize: 23,
                                                    )),
                                              ),
                                            ],
                                          )))),
                            ],
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 25),
                  ))
                ]))));
  }

  BoxDecoration orderBoxDecoration() {
    return BoxDecoration(
        border: Border.all(
          color: Colors.lightGreen,
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0) //
            ));
  }

  BoxDecoration dataBoxDecoration() {
    return BoxDecoration(
        color: Colors.yellow[100],
        border: Border.all(
          color: Colors.orange[200],
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0) //
            ));
  }
}

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // elevation: 5,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Меню',
              style: TextStyle(color: Colors.green[900], fontSize: 30),
            ),
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(40),
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
                MaterialPageRoute(builder: (context) => OrderPage()),
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

/*
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Applications'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
