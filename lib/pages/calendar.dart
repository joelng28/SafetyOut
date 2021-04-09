import 'package:flutter/material.dart';

import '../app_localizations.dart';
import '../defaults/constants.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Calendar',
            ),
          ],
        ),
      ),
    );
  }
}

class Attendance {
  String place;
  String startHour;
  String endHour;
  String personas;
}

class DetailsAttendance extends StatefulWidget {
  final Attendance assistencia;
    
  DetailsAttendance({Key key, @required this.assistencia}) : super(key: key);

  @override
  _DetailsAttendanceState createState() => _DetailsAttendanceState();
}

class _DetailsAttendanceState extends State<DetailsAttendance> {
  Function guardarCanvis = (BuildContext context) {};

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: Constants.xs(context)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: Constants.xxs(context)),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios_rounded,
                            size: 32 /
                                (MediaQuery.of(context).size.width < 380
                                    ? 1.3
                                    : 1),
                            color: Constants.black(context)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: Text(
                          AppLocalizations.of(context)
                              .translate("Modificar_Assistencia"),
                          style: TextStyle(
                              color: Constants.darkGrey(context),
                              fontSize: Constants.xl(context),
                              fontWeight: Constants.bolder)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v7(context), Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: Text(
                          widget.assistencia.place,
                          style: TextStyle(
                              color: Constants.darkGrey(context),
                              fontSize: Constants.xl(context),
                              fontWeight: Constants.bolder)),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Constants.a7(context),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Constants.green(context), width: 2)),
                        child: TextButton(
                            onPressed: () => guardarCanvis(context),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text(
                                AppLocalizations.of(context)
                                    .translate("Modificar_Assistencia"),
                                style: TextStyle(
                                    fontSize: Constants.m(context),
                                    fontWeight: Constants.bold,
                                    color: Constants.black(context)))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}