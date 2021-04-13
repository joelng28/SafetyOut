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
        actions: [
          IconButton(icon: const Icon(Icons.check_rounded), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Row(children: [
              Text(
                "Parc de Pedralbes",
                style: TextStyle(
                    color: Constants.black(context),
                    fontSize: Constants.xl(context)),
              ),
            ]),
            Row(children: [
              Text(
                "Pedralbes, Barcelona",
                style: TextStyle(
                    color: Constants.black(context),
                    fontSize: Constants.xl(context)),
              ),
            ]),
            Row(children: [
              SvgPicture.asset('assets/icons/placeholder.svg',
                  color: Constants.black(context),
                  height: Constants.xxl(context),
                  width: Constants.xxl(context)),
              Text(
                "Ubicació",
                style: TextStyle(
                    color: Constants.black(context),
                    fontSize: Constants.xl(context)),
              ),
            ]),
            Row(children: [
              Icon(Icons.calendar_today_rounded),
              Text(
                "Dia",
                style: TextStyle(
                    color: Constants.black(context),
                    fontSize: Constants.xl(context)),
              ),
            ]),
            Row(children: [
              Icon(Icons.watch_later_outlined),
              Text(
                "Hora",
                style: TextStyle(
                    color: Constants.black(context),
                    fontSize: Constants.xl(context)),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
