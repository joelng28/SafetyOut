import 'package:app/app_localizations.dart';
import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class Notificarassistenciaconfirmacio extends StatefulWidget {
  Notificarassistenciaconfirmacio({Key key}) : super(key: key);

  //final String title;

  @override
  _Notificarassistenciaconfirmacio createState() =>
      _Notificarassistenciaconfirmacio();
}

class _Notificarassistenciaconfirmacio
    extends State<Notificarassistenciaconfirmacio> {
  static bool activeButton = false;
  static bool isLoading = false;
  Function submitAssistencia = (BuildContext context) {};
  String place = "placeID";
  String cityLocation = "ciutat";
  String placeLocation = "Ubicació";

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
        child: Padding(
          padding: EdgeInsets.only(
              top: Constants.v2(context),
              left: Constants.h6(context),
              right: Constants.h6(context)),
          child: Column(
            children: <Widget>[
              Row(children: [
                Text(
                  place,
                  style: TextStyle(
                      color: Constants.black(context),
                      fontWeight: Constants.bolder,
                      fontSize: Constants.l(context)),
                ),
              ]),
              // Padding(
              // padding: EdgeInsets.only(top: Constants.v1(context)),
              //child:
              Row(children: [
                Text(
                  cityLocation,
                  style: TextStyle(
                      color: Constants.black(context),
                      fontWeight: Constants.bolder,
                      fontSize: Constants.m(context)),
                ),
              ]),
              //),
              Padding(
                padding: EdgeInsets.only(top: Constants.v3(context)),
                child: Row(children: [
                  SvgPicture.asset('assets/icons/placeholder.svg',
                      color: Constants.black(context),
                      height: Constants.xxl(context),
                      width: Constants.xxl(context)),
                  Padding(
                    padding: EdgeInsets.only(left: Constants.h1(context)),
                    child: Text(
                      placeLocation,
                      style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.s(context)),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: Constants.v1(context)),
                child: Row(children: [
                  Icon(Icons.calendar_today_rounded,
                      size: Constants.xxl(context)),
                  Padding(
                    padding: EdgeInsets.only(left: Constants.h1(context)),
                    child: Text(
                      "Dia",
                      style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.s(context)),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: Constants.v1(context)),
                child: Row(children: [
                  Icon(Icons.watch_later_outlined,
                      size: Constants.xxl(context)),
                  Padding(
                    padding: EdgeInsets.only(left: Constants.h1(context)),
                    child: Text(
                      "Hora",
                      style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.s(context)),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: Constants.v3(context)),
                child: Row(children: [
                  Text(
                    "Amb qui t'agradaria assistir?",
                    style: TextStyle(
                        color: Constants.black(context),
                        fontWeight: Constants.bolder,
                        fontSize: Constants.l(context)),
                  ),
                ]),
              ),
              /*Row(children: [
              ListWheelScrollView(
                children: <Widget>[
                  const Text("Només jo"),
                  const Text("Bombolla 1"),
                  const Text("Bombolla 2")
                ],
                //onSelectedItemChanged: ,
                itemExtent: 50.0,
              )
            ]),*/
            ],
          ),
        ),
      ),
    );
  }
}
