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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            ),
          ],
        ),
      ),
    );
  }
}
