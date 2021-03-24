import 'package:app/defaults/constants.dart';
import 'package:app/pages/signup/gender.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import '../../app_localizations.dart';

enum Sex {
  notKnown,
  male,
  female,
  not_applicable,
}

class Birthdate extends StatefulWidget {
  Birthdate({Key key /*, this.title*/}) : super(key: key);
  //final String title;

  @override
  _Birthdate createState() => _Birthdate();
}

class _Birthdate extends State<Birthdate> {
/*   String _naixement;
  String _mes; */
  CalendarController _calendarController;
  DateTime pickedDate = DateTime(2010);
    DateTime yearDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
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
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 32 /
                                  (MediaQuery.of(context).size.width < 380 ? 1.3 : 1),
                            color: Constants.black(context)
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: MediaQuery.of(context).viewInsets.bottom == 0,
                        child: Text(
                        AppLocalizations.of(context)
                            .translate("Registre_Usuari"),
                        style: TextStyle(
                            color: Constants.darkGrey(context),
                            fontSize: Constants.xl(context),
                            fontWeight: Constants.bolder)),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Constants.v4(context)),
                  child: Text(
                      AppLocalizations.of(context)
                          .translate("Introdueix_la_teva_data_de_naixement"),
                      style: TextStyle(
                          color: Constants.darkGrey(context),
                          fontSize: Constants.l(context),
                          fontWeight: Constants.normal)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  Constants.h4(context),
                  Constants.v5(context),
                  Constants.h4(context),
                  Constants.v7(context)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.lightGrey(context),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: TableCalendar(
                          locale: Localizations.localeOf(context).toLanguageTag(),
                          startDay: DateTime(1900),
                          endDay: DateTime.now(),
                          calendarController: _calendarController,
                          initialSelectedDay: pickedDate,
                          initialCalendarFormat: CalendarFormat.month,
                          availableCalendarFormats: const {
                            CalendarFormat.month: '',
                          },
                          availableGestures: AvailableGestures.all,
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            weekendStyle: TextStyle(
                              color: Constants.black(context),
                              fontSize: Constants.m(context)
                            ),
                            holidayStyle: TextStyle(
                              color: Constants.black(context),
                              fontSize: Constants.m(context)
                            ),
                            weekdayStyle: TextStyle(
                              color: Constants.black(context),
                              fontSize: Constants.m(context)
                            ),
                            selectedColor: Constants.primary(context),
                            selectedStyle: TextStyle(
                              color: Color(0xFF242424)
                            ),
                            todayStyle: TextStyle(
                              color: Constants.black(context)
                            ),
                            todayColor: Colors.transparent,
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: Constants.darkGrey(context),
                              fontSize: Constants.m(context),
                              fontWeight: Constants.bold
                            ),
                            weekendStyle: TextStyle(
                              color: Constants.darkGrey(context),
                              fontSize: Constants.m(context),
                              fontWeight: Constants.bold
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonVisible: false,
                            titleTextStyle: TextStyle(
                              fontWeight: Constants.bold,
                              fontSize: Constants.l(context)
                            ),
                            leftChevronIcon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Constants.black(context)
                            ),
                            rightChevronIcon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Constants.black(context)
                            ),
                          ),
                          onDaySelected: (date, events, holidays) => setState(() {
                              pickedDate = date;
                              _calendarController.setSelectedDay(pickedDate);}
                            ),
                          onHeaderTapped: (date) {
                            showMaterialNumberPicker(
                            context: context,
                            title: AppLocalizations.of(context)
                            .translate("Any"),
                            maxNumber: DateTime.now().year,
                            minNumber: 1900,
                            selectedNumber: pickedDate.year,
                            onChanged: (value) => setState(() {
                              pickedDate = DateTime(value, pickedDate.month, pickedDate.day);
                              _calendarController.setSelectedDay(pickedDate);}
                            ),
                            backgroundColor: Constants.white(context),
                            buttonTextColor: Constants.black(context)
                          );
                          },
                        ),
                      ),
              )]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  0, Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Constants.a7(context),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF84FCCD), Color(0xFFA7FF80)],
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                color: Color.fromARGB(100, 0, 0, 0),
                              )
                            ]),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(pageBuilder: (_, __, ___) => Gender()),
                              );
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text(AppLocalizations.of(context)
                            .translate("Següent"),
                                style: TextStyle(
                                    fontSize: Constants.m(context),
                                    fontWeight: Constants.bold,
                                    color: Constants.primaryDark(context)))),
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
