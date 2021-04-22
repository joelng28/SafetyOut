import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import '../app_localizations.dart';

class Notificarassistencia extends StatefulWidget {
  Notificarassistencia({Key key}) : super(key: key);

  //final String title;

  @override
  _Notificarassistencia createState() => _Notificarassistencia();
}

class _Notificarassistencia extends State<Notificarassistencia> {
  static bool activeButton = false;
  static bool isLoading = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  CalendarController _calendarController;
  Function submitAssistencia = (BuildContext context) {};

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    submitAssistencia = (BuildContext context) {
      isLoading = true;
      activeButton = false;
      var url = Uri.parse('https://safetyout.herokuapp.com/assistance/add');
      http.post(url, body: {
        'user_id': SecureStorage.readSecureStorage('SafetyOUT_userid'),
        'place': {'longitude': "100", 'latitude': "200"},
        'dateInterval': {
          'startDate': {
            'year': startDate.year,
            'month': startDate.month,
            'day': startDate.day,
            'hour': startDate.hour,
            'minute': startDate.minute,
          },
          'endDate': {
            'year': endDate.year,
            'month': endDate.month,
            'day': endDate.day,
            'hour': endDate.hour,
            'minute': endDate.minute,
          }
        }
      }).then((res) {
        if (res.statusCode == 201) {
          setState(() {
            isLoading = false;
            activeButton = true;
          });
        } //Correcte, guardar, notificació assitència ok i tornar a pantalla discover
        else {
          setState(() {
            isLoading = false;
            activeButton = true;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                  content: SingleChildScrollView(
                      child: ListBody(
                    children: <Widget>[
                      Text(
                          AppLocalizations.of(context).translate(
                              "Ja has notificat assistència en aquest lloc, data i hora"),
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
              });
        }
      });
    };
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

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
                  "Parc de Pedralbes",
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
                  "Pedralbes, Barcelona",
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
                      "Ubicació",
                      style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.s(context)),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Constants.h7(context),
                    Constants.v5(context),
                    Constants.h7(context),
                    Constants.v7(context)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Constants.lightGrey(context),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TableCalendar(
                            locale:
                                Localizations.localeOf(context).toLanguageTag(),
                            startDay: DateTime(1900),
                            endDay: DateTime.now(),
                            calendarController: _calendarController,
                            initialSelectedDay: startDate,
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
                              selectedStyle:
                                  TextStyle(color: Color(0xFF242424)),
                              todayStyle:
                                  TextStyle(color: Constants.black(context)),
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
                              leftChevronIcon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Constants.black(context)),
                              rightChevronIcon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Constants.black(context)),
                            ),
                            onDaySelected: (date, events, holidays) =>
                                setState(() {
                              startDate = date;
                              _calendarController.setSelectedDay(startDate);
                            }),
                            onHeaderTapped: (date) {
                              startDate = date;
                              _calendarController.setSelectedDay(startDate);
                              Picker(
                                adapter: DateTimePickerAdapter(
                                    type: 11,
                                    yearBegin: 1900,
                                    yearEnd: DateTime.now().year,
                                    value: startDate,
                                    months: [
                                      AppLocalizations.of(context)
                                          .translate("Gener"),
                                      AppLocalizations.of(context)
                                          .translate("Febrer"),
                                      AppLocalizations.of(context)
                                          .translate("Març"),
                                      AppLocalizations.of(context)
                                          .translate("Abril"),
                                      AppLocalizations.of(context)
                                          .translate("Maig"),
                                      AppLocalizations.of(context)
                                          .translate("Juny"),
                                      AppLocalizations.of(context)
                                          .translate("Juliol"),
                                      AppLocalizations.of(context)
                                          .translate("Agost"),
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
                                  startDate = DateTime(1900 + values[0],
                                      values[1] + 1, startDate.day);
                                  _calendarController.setSelectedDay(startDate);
                                }),
                                onCancel: () {},
                              ).showDialog(context);
                            },
                          ),
                        ),
                      )
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: Constants.v3(context)),
                child: Row(children: [
                  SvgPicture.asset('assets/icons/group.svg',
                      color: Constants.black(context),
                      height: Constants.xxl(context),
                      width: Constants.xxl(context)),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Hi haura (o no) molta gent",
                            style: TextStyle(fontSize: Constants.l(context))),
                      ])),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Es recomana no assistir/pots assistir",
                    style: TextStyle(fontSize: Constants.l(context))),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
