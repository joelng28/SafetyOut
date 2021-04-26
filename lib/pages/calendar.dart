import 'package:app/app_localizations.dart';
import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class Calendar extends StatefulWidget {
  Calendar({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  CalendarController _calendarController;

  DateTime pickedDate = DateTime.now();

  Function getActivities = (BuildContext context) {};

  String getWeekDay(int num) {
    if (num == 7)
      return AppLocalizations.of(context).translate("Dilluns");
    else if (num == 1)
      return AppLocalizations.of(context).translate("Dimarts");
    else if (num == 2)
      return AppLocalizations.of(context).translate("Dimecres");
    else if (num == 3)
      return AppLocalizations.of(context).translate("Dijous");
    else if (num == 4)
      return AppLocalizations.of(context).translate("Divendres");
    else if (num == 5)
      return AppLocalizations.of(context).translate("Dissabte");
    else if (num == 6)
      return AppLocalizations.of(context).translate("Diumenge");
  }

  String getMonth(int num) {
    if (num == 1)
      return " de gener ";
    else if (num == 2)
      return " de febrer ";
    else if (num == 3)
      return " de març ";
    else if (num == 4)
      return " d'abril ";
    else if (num == 5)
      return " de maig ";
    else if (num == 6)
      return " de juny ";
    else if (num == 7)
      return " de juliol ";
    else if (num == 8)
      return " d'agost ";
    else if (num == 9)
      return " de setembre ";
    else if (num == 10)
      return " d'octubre ";
    else if (num == 11)
      return " de novembre ";
    else if (num == 12) return " de desembre ";
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    /*getActivities = (BuildContext context) {
      var url = Uri.parse ('https://safetyout.herokuapp.com/assistance/consultOnDay');
      http.get(url, body: {
        'user_id': SecureStorage.readSecureStorage ('SafetyOUT_UserId'),
        'startDate': {
          'year': pickedDate.year,
          'month': pickedDate.month,
          'day': pickedDate.day,
          'hour': pickedDate.hour,
          'minute': pickedDate.minute
        }

      }).then(res){
        if (res.statusCode == 200) {} //retornar dades
      }
      else if (res.statusCode == 409) {
      }).catchError((err) {
        print(err);
        //Sale error por pantalla
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                content: SingleChildScrollView(
                    child: ListBody(
                  children: <Widget>[
                    Text(
                        AppLocalizations.of(context)
                            .translate("Error de xarxa"),
                        style: TextStyle(fontSize: Constants.m(context))),
                  ],
                )),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                        AppLocalizations.of(context).translate("Acceptar"),
                        style: TextStyle(color: Constants.black(context))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }); //Error
    };*/
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              Constants.h7(context),
              Constants.v5(context),
              Constants.h7(context),
              Constants.v7(context)),
          child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                  Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Constants.lightGrey(context),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                      onDaySelected: (date, events, holidays) => setState(() {
                        pickedDate = date;
                        _calendarController.setSelectedDay(pickedDate);
                      }),
                      onHeaderTapped: (date) {
                        pickedDate = date;
                        _calendarController.setSelectedDay(pickedDate);
                        Picker(
                          adapter: DateTimePickerAdapter(
                              type: 11,
                              yearBegin: 1900,
                              yearEnd: DateTime.now().year,
                              value: pickedDate,
                              months: [
                                AppLocalizations.of(context).translate("Gener"),
                                AppLocalizations.of(context)
                                    .translate("Febrer"),
                                AppLocalizations.of(context).translate("Març"),
                                AppLocalizations.of(context).translate("Abril"),
                                AppLocalizations.of(context).translate("Maig"),
                                AppLocalizations.of(context).translate("Juny"),
                                AppLocalizations.of(context)
                                    .translate("Juliol"),
                                AppLocalizations.of(context).translate("Agost"),
                                AppLocalizations.of(context)
                                    .translate("Setembre"),
                                AppLocalizations.of(context)
                                    .translate("Octubre"),
                                AppLocalizations.of(context)
                                    .translate("Novembre"),
                                AppLocalizations.of(context)
                                    .translate("Desembre"),
                              ],
                              customColumnType: [
                                0,
                                1
                              ]),
                          textStyle: TextStyle(
                              color: Constants.darkGrey(context),
                              fontSize: Constants.l(context)),
                          columnFlex: [2, 3],
                          confirmText: AppLocalizations.of(context)
                              .translate("Confirmar"),
                          cancelText: AppLocalizations.of(context)
                              .translate("Cancel·lar"),
                          confirmTextStyle: TextStyle(
                              color: Constants.darkGrey(context),
                              fontWeight: Constants.bold,
                              fontSize: Constants.s(context)),
                          cancelTextStyle: TextStyle(
                              color: Constants.darkGrey(context),
                              fontWeight: Constants.bold,
                              fontSize: Constants.s(context)),
                          height: Constants.a11(context),
                          hideHeader: true,
                          selectedTextStyle: TextStyle(
                            color: Constants.black(context),
                          ),
                          backgroundColor: Constants.lightGrey(context),
                          onConfirm: (Picker picker, List values) =>
                              setState(() {
                            pickedDate = DateTime(1900 + values[0],
                                values[1] + 1, pickedDate.day);
                            _calendarController.setSelectedDay(pickedDate);
                          }),
                          onCancel: () {},
                        ).showDialog(context);
                      },
                    ),
                  ),
                )
              ]),
              Padding(
                padding: EdgeInsets.only(top: Constants.v2(context)),
                child: Row(children: [
                  Text("Activitats",
                      style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.xl(context),
                          fontWeight: Constants.bolder)),
                ]),
              ),
              Row(children: [
                Text(
                    getWeekDay(pickedDate.weekday) +
                        ", " +
                        pickedDate.day.toString() +
                        getMonth(pickedDate.month) +
                        "de " +
                        pickedDate.year.toString(),
                    style: TextStyle(
                      color: Constants.black(context),
                      fontSize: Constants.xl(context),
                    )),
              ]),
              Padding(
                padding: EdgeInsets.only(top: Constants.v2(context)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text("Lloc",
                            style: TextStyle(
                              color: Constants.black(context),
                              fontSize: Constants.m(context),
                            )),
                      ]),
                      Column(children: [
                        IconButton(
                          icon: Icon(Icons.more_horiz,
                              size: Constants.l(context)),
                          onPressed: () {},
                        )
                      ])
                    ]),
              ),
              Padding(
                  padding: EdgeInsets.only(right: Constants.h3(context)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: Constants.xxl(context),
                        color: Constants.black(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Constants.h1(context)),
                        child: Text("Hora",
                            style: TextStyle(
                              color: Constants.black(context),
                              fontSize: Constants.s(context),
                            )),
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: Constants.v1(context), right: Constants.h3(context)),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/group.svg',
                          color: Constants.black(context),
                          height: Constants.xxl(context),
                          width: Constants.xxl(context)),
                      Padding(
                          padding: EdgeInsets.only(left: Constants.h1(context)),
                          child: Text("Moltes/poques persones",
                              style: TextStyle(
                                color: Constants.black(context),
                                fontSize: Constants.s(context),
                              ))),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
