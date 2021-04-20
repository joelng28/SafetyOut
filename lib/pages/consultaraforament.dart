import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

class ConsultarAforament extends StatefulWidget {
  ConsultarAforament({Key key}) : super(key: key);

  @override
  _ConsultarAforament createState() => _ConsultarAforament();
}

class _ConsultarAforament extends State<ConsultarAforament> {
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
        title: Text('Consultar quantitat de gent per hores'),
        centerTitle: true,
        backgroundColor: Constants.white(context),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: Constants.v2(context),
              left: Constants.h6(context),
              right: Constants.h6(context)),
          child: Column(
            children: <Widget>[
              Row(children: [
                Text(
                  "Parc de Pedralbes",
                  style: TextStyle(
                      color: Constants.black(context),
                      fontWeight: Constants.bolder,
                      fontSize: Constants.l(context)),
                )
              ]),
              Row(children: [
                Text(
                  "Pedralbes, Barcelona",
                  style: TextStyle(
                      color: Constants.black(context),
                      fontWeight: Constants.bolder,
                      fontSize: Constants.m(context)),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    top: Constants.v3(context), bottom: Constants.v3(context)),
                child: Row(children: [
                  SvgPicture.asset('assets/icons/placeholder.svg',
                      color: Constants.black(context),
                      height: Constants.xxl(context),
                      width: Constants.xxl(context)),
                  Padding(
                    padding: EdgeInsets.only(left: Constants.h1(context)),
                    child: Text(
                      "Ubicació",
                      style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.s(context)),
                    ),
                  ),
                ]),
              ),
              Row(
                children: [
                  TableCalendar(
                    startDay: DateTime(1900),
                    endDay: DateTime(2030),
                    initialSelectedDay: DateTime.now(),
                    initialCalendarFormat: CalendarFormat.month,
                    //calendarController: _calendarController,
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
              Padding(
                padding: EdgeInsets.only(top: Constants.v3(context)),
                child: Row(children: [
                  Icon(Icons.calendar_today_rounded,
                      size: Constants.xxl(context)),
                  Padding(
                    padding: EdgeInsets.only(left: Constants.h1(context)),
                    child: Text(
                      "Moltes/poques persones",
                      style: TextStyle(
                          color: Constants.red(context), //o green segú aforo
                          fontWeight: Constants.bolder,
                          fontSize: Constants.l(context)),
                    ),
                  ),
                ]),
              ),
              Padding(
                  padding: EdgeInsets.only(top: Constants.v3(context)),
                  child: Text("Hi haura (o no) molta gent",
                      style: TextStyle(fontSize: Constants.l(context)))),
              Text("Es recomana no assistir/pots assistir",
                  style: TextStyle(fontSize: Constants.l(context))),
            ],
          ),
        ),
      ),
    );
  }
}
