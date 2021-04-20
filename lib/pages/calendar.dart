import 'package:app/app_localizations.dart';
import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  CalendarController _calendarController;

  //DateTime pickedDate = DateTime.now();

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
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                TableCalendar(
                  startDay: DateTime(1900),
                  endDay: DateTime(2030),
                  initialSelectedDay: DateTime.now(),
                  initialCalendarFormat: CalendarFormat.month,
                  calendarController: _calendarController,
                  availableCalendarFormats: const {
                    CalendarFormat.month: '',
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendStyle: TextStyle(
                        color: Constants.black(context),
                        fontSize: Constants.m(context)),
                    holidayStyle: TextStyle(
                        color: Constants.black(context),
                        fontSize: Constants.m(context)),
                    weekdayStyle: TextStyle(
                        color: Constants.black(context),
                        fontSize: Constants.m(context)),
                    selectedColor: Constants.primary(context),
                    selectedStyle: TextStyle(color: Color(0xFF242424)),
                    todayStyle: TextStyle(color: Constants.black(context)),
                    todayColor: Colors.transparent,
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Constants.darkGrey(context),
                        fontSize: Constants.m(context),
                        fontWeight: Constants.bold),
                    weekendStyle: TextStyle(
                        color: Constants.darkGrey(context),
                        fontSize: Constants.m(context),
                        fontWeight: Constants.bold),
                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        fontWeight: Constants.bold,
                        fontSize: Constants.l(context)),
                    leftChevronIcon: Icon(Icons.arrow_back_ios_rounded,
                        color: Constants.black(context)),
                    rightChevronIcon: Icon(Icons.arrow_forward_ios_rounded,
                        color: Constants.black(context)),
                  ),
                ),
              ],
            ),
            /*Row(
              children: [
                Text(AppLocalizations.of(context).translate("Activitats"),
                    style: TextStyle(
                        fontSize: Constants.l(context),
                        fontWeight: Constants.bolder))
              ],
            ),*/
            /*Row(
              children: [
                Text(
                    pickedDate.day.toString() +
                        "de" +
                        pickedDate.month.toString() +
                        "de" +
                        pickedDate.year.toString(),
                    style: TextStyle(fontSize: Constants.l(context)))
              ],
            )*/
            Row(
              children: [
                Column(children: [
                  Text("Parc de Pedralbes",
                      style: TextStyle(
                          fontSize: Constants.l(context),
                          fontWeight: Constants.bolder))
                ]),
                /*Column(
                  children: [
                    PopupMenuButton(
                        icon: Icon(Icons.more_horiz,
                            color: Constants.black(context)))
                  ],
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
