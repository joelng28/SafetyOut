import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Notificarassistencia extends StatefulWidget {
  Notificarassistencia({Key key}) : super(key: key);

  //final String title;

  @override
  _Notificarassistencia createState() => _Notificarassistencia();
}

class _Notificarassistencia extends State<Notificarassistencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Notificar assistència'),
        centerTitle: true,
        backgroundColor: Constants.white(context),
        actions: [
          IconButton(icon: const Icon(Icons.check_rounded), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(children: [
                  Column(children: [
                    Row(children: [
                      Text(
                        "Parc de Pedralbes",
                        style: TextStyle(
                            color: Constants.black(context),
                            fontWeight: Constants.bolder,
                            fontSize: Constants.xxl(context)),
                      ),
                    ]),
                    Row(children: [
                      Text(
                        "Pedralbes, Barcelona",
                        style: TextStyle(
                            color: Constants.black(context),
                            fontWeight: Constants.bolder,
                            fontSize: Constants.xl(context)),
                      ),
                    ]),
                  ]),
                ])),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(children: [
                SvgPicture.asset('assets/icons/placeholder.svg',
                    color: Constants.black(context),
                    height: Constants.xl(context),
                    width: Constants.xl(context)),
                Text(
                  "Ubicació",
                  style: TextStyle(
                      color: Constants.black(context),
                      fontSize: Constants.l(context)),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(children: [
                Icon(Icons.calendar_today_rounded),
                Text(
                  "Dia",
                  style: TextStyle(
                      color: Constants.black(context),
                      fontSize: Constants.l(context)),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(children: [
                Icon(Icons.watch_later_outlined),
                Text(
                  "Hora",
                  style: TextStyle(
                      color: Constants.black(context),
                      fontSize: Constants.l(context)),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(children: [
                Text(
                  "Amb qui t'agradaria assistir?",
                  style: TextStyle(
                      color: Constants.black(context),
                      fontWeight: Constants.bolder,
                      fontSize: Constants.xl(context)),
                ),
              ]),
            ),
            Row(children: [
              ListWheelScrollView(
                children: <Widget>[
                  const Text("Només jo"),
                  const Text("Bombolla 1"),
                  const Text("Bombolla 2")
                ],
                //onSelectedItemChanged: ,
                itemExtent: 50.0,
              )
            ]),
          ],
        ),
      ),
    );
  }
}
