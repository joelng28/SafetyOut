import 'dart:convert';

import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../app_localizations.dart';
import 'app.dart';

class NotificarAssistencia extends StatefulWidget {
  NotificarAssistencia(
      this.placeName, this.placeLocation, this.placeAddress, this.placeId,
      {Key key})
      : super(key: key);

  final String placeName;
  final String placeLocation;
  final String placeAddress;
  final String placeId;

  @override
  _NotificarAssistencia createState() => _NotificarAssistencia(
      this.placeName, this.placeLocation, this.placeAddress, this.placeId);
}

class _NotificarAssistencia extends State<NotificarAssistencia> {
  CalendarController _calendarController;
  DateTime pickedDate = DateTime.now();
  DateTime yearDate = DateTime.now();
  int endHour = DateTime.now().hour;
  int endMinute = DateTime.now().minute;
  Function submitAssistencia = (BuildContext context) {};

  _NotificarAssistencia(
      this.placeName, this.placeLocation, this.placeAddress, this.placeId);
  final String placeName;
  final String placeLocation;
  final String placeAddress;
  final String placeId;
  int placeGauge;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    consultaAforament();
    submitAssistencia = (BuildContext context) async {
      if (pickedDate.hour > endHour ||
          (pickedDate.hour == endHour && pickedDate.minute >= endMinute)) {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                content: SingleChildScrollView(
                    child: ListBody(
                  children: <Widget>[
                    Text(
                        AppLocalizations.of(context).translate(
                            "Lhora_dentrada_ha_de_ser_anterior_a_lhora_de_sortida"),
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
      } else {
        await SecureStorage.readSecureStorage('SafetyOUT_UserId').then((val) {
          var url = Uri.parse('https://safetyout.herokuapp.com/assistance');
          var body = jsonEncode({
            'user_id': val,
            'place_id': placeId,
            'dateInterval': {
              'startDate': {
                'year': pickedDate.year.toString(),
                'month': (pickedDate.month - 1).toString(),
                'day': pickedDate.day.toString(),
                'hour': pickedDate.hour.toString(),
                'minute': pickedDate.minute.toString(),
              },
              'endDate': {
                'year': pickedDate.year.toString(),
                'month': (pickedDate.month - 1).toString(),
                'day': pickedDate.day.toString(),
                'hour': endHour.toString(),
                'minute': endMinute.toString(),
              }
            }
          });
          http
              .post(url,
                  headers: {"Content-Type": "application/json"}, body: body)
              .then((res) {
            if (res.statusCode == 201) {
              Navigator.of(context).pop();

              Map<String, dynamic> body = jsonDecode(res.body);

              int achievementId = body["achievement"];
              String achievementIcon;
              String achievementText;

              if (achievementId != 0) {
                switch (achievementId) {
                  case 16:
                    achievementIcon = "place bronze";
                    achievementText = AppLocalizations.of(context)
                        .translate("Notifica 1 assistència");
                    break;
                  case 17:
                    achievementIcon = "place silver";
                    achievementText = AppLocalizations.of(context)
                        .translate("Notifica 5 assistències");
                    break;
                  case 18:
                    achievementIcon = "place golden";
                    achievementText = AppLocalizations.of(context)
                        .translate("Notifica 25 assistències");
                    break;
                  case 19:
                    achievementIcon = "place platinum";
                    achievementText = AppLocalizations.of(context)
                        .translate("Notifica 50 assistències");
                    break;
                  case 20:
                    achievementIcon = "place diamond";
                    achievementText = AppLocalizations.of(context)
                        .translate("Notifica 100 assistències");
                    break;
                  case 21:
                    achievementIcon = "place advanced";
                    achievementText = AppLocalizations.of(context)
                        .translate("Notifica 500 assistències");
                    break;
                  case 22:
                    achievementIcon = "place master";
                    achievementText = AppLocalizations.of(context)
                        .translate("Notifica 1000 assistències");
                    break;
                }

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                        content: SingleChildScrollView(
                            child: Column(
                          children: [
                            Image(
                                height: Constants.xxl(context) +
                                    Constants.xxl(context) +
                                    Constants.xxl(context) +
                                    Constants.xs(context),
                                image: AssetImage("assets/icons/achievements/" +
                                    achievementIcon +
                                    ".png")),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  Constants.h1(context),
                                  Constants.v1(context),
                                  Constants.h1(context),
                                  Constants.v1(context)),
                              child: Text(achievementText),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  Constants.h1(context),
                                  Constants.v1(context),
                                  Constants.h1(context),
                                  Constants.v1(context)),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("Nou assoliment!"),
                                  style: TextStyle(
                                      color: Constants.black(context),
                                      fontWeight: Constants.bold)),
                            )
                          ],
                        )),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                                AppLocalizations.of(context)
                                    .translate("Acceptar"),
                                style:
                                    TextStyle(color: Constants.black(context))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
            } //Correcte, guardar, notificació assitència ok i tornar a pantalla discover
            else if (res.statusCode == 409) {
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
                                  "Ja_has_notificat_assistència_en_aquest_lloc_data_i_hora"),
                              style: TextStyle(fontSize: Constants.m(context))),
                        ],
                      )),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Acceptar"),
                              style:
                                  TextStyle(color: Constants.black(context))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            } else {
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
                                  .translate("Error_de_xarxa"),
                              style: TextStyle(fontSize: Constants.m(context))),
                        ],
                      )),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Acceptar"),
                              style:
                                  TextStyle(color: Constants.black(context))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          });
        });
      }
    };
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void consultaAforament() async {
    Uri url = Uri.parse(
        'https://safetyout.herokuapp.com/place/occupation?place_id=' +
            placeId +
            '&year=' +
            pickedDate.year.toString() +
            '&month=' +
            (pickedDate.month - 1).toString() +
            '&day=' +
            pickedDate.day.toString() +
            '&hour=' +
            pickedDate.hour.toString() +
            '&minute=' +
            pickedDate.minute.toString());
    await http.get(url).then((res) {
      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        setState(() {
          placeGauge = body["occupation"];
        });
      } else {
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
                            .translate("Error_de_xarxa"),
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
    }).catchError((err) {
      //Sale error por pantalla
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate("Error_de_xarxa"),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
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
                      Navigator.of(context).pushReplacement(
                          PageRouteBuilder(pageBuilder: (_, __, ___) => App()));
                    },
                    child: Icon(Icons.arrow_back_ios_rounded,
                        size: 32 /
                            (MediaQuery.of(context).size.width < 380 ? 1.3 : 1),
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
                          .translate("Notificar_assistencia"),
                      style: TextStyle(
                          color: Constants.darkGrey(context),
                          fontSize: Constants.xl(context),
                          fontWeight: Constants.bolder)),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Padding(
                    padding: EdgeInsets.only(right: Constants.xxs(context)),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => submitAssistencia(context),
                      child: Icon(Icons.check_rounded,
                          size: 32 /
                              (MediaQuery.of(context).size.width < 380
                                  ? 1.3
                                  : 1),
                          color: Constants.black(context)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: Constants.v2(context),
                left: Constants.h6(context),
                right: Constants.h6(context)),
            child: Column(
              children: <Widget>[
                Row(children: [
                  SizedBox(
                    width: Constants.w12(context),
                    child: Text(
                      placeName,
                      style: TextStyle(
                          color: Constants.black(context),
                          fontWeight: Constants.bolder,
                          fontSize: Constants.l(context)),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  )
                ]),
                Row(children: [
                  SizedBox(
                    width: Constants.w12(context),
                    child: Text(
                      placeLocation,
                      style: TextStyle(
                          color: Constants.black(context),
                          fontWeight: Constants.bolder,
                          fontSize: Constants.m(context)),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(
                      top: Constants.v3(context),
                      bottom: Constants.v3(context)),
                  child: Row(children: [
                    SvgPicture.asset('assets/icons/placeholder.svg',
                        color: Constants.black(context),
                        height: Constants.xxl(context),
                        width: Constants.xxl(context)),
                    Padding(
                      padding: EdgeInsets.only(left: Constants.h1(context)),
                      child: SizedBox(
                        width: Constants.w12(context),
                        child: Text(
                          placeAddress,
                          style: TextStyle(
                              color: Constants.black(context),
                              fontSize: Constants.s(context)),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ]),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Constants.lightGrey(context),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              TableCalendar(
                                locale: Localizations.localeOf(context)
                                    .toLanguageTag(),
                                startDay: DateTime.now(),
                                endDay: DateTime(DateTime.now().year + 1,
                                    DateTime.now().month, DateTime.now().day),
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
                                  selectedStyle:
                                      TextStyle(color: Color(0xFF242424)),
                                  todayStyle: TextStyle(
                                      color: Constants.black(context)),
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
                                  pickedDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      pickedDate.hour,
                                      pickedDate.minute);
                                  _calendarController
                                      .setSelectedDay(pickedDate);
                                  consultaAforament();
                                }),
                                onHeaderTapped: (date) {
                                  pickedDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      pickedDate.hour,
                                      pickedDate.minute);
                                  _calendarController
                                      .setSelectedDay(pickedDate);
                                  Picker(
                                    adapter: DateTimePickerAdapter(
                                        type: 11,
                                        yearBegin: DateTime.now().year,
                                        yearEnd: DateTime.now().year + 1,
                                        value: pickedDate,
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
                                    backgroundColor:
                                        Constants.lightGrey(context),
                                    onConfirm: (Picker picker, List values) =>
                                        setState(() {
                                      pickedDate = DateTime(
                                          DateTime.now().year + values[0],
                                          values[1] + 1,
                                          pickedDate.day,
                                          pickedDate.hour,
                                          pickedDate.minute);
                                      _calendarController
                                          .setSelectedDay(pickedDate);
                                      consultaAforament();
                                    }),
                                    onCancel: () {},
                                  ).showDialog(context);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Constants.h6(context),
                                    right: Constants.h6(context)),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Constants.grey(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Constants.v3(context),
                                    bottom: Constants.v3(context)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        size: Constants.xxl(context),
                                        color: Constants.black(context),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Picker(
                                              adapter: DateTimePickerAdapter(
                                                  value: pickedDate,
                                                  customColumnType: [3, 4]),
                                              textStyle: TextStyle(
                                                  color: Constants.darkGrey(
                                                      context),
                                                  fontSize:
                                                      Constants.l(context)),
                                              confirmText:
                                                  AppLocalizations.of(context)
                                                      .translate("Confirmar"),
                                              cancelText:
                                                  AppLocalizations.of(context)
                                                      .translate("Cancel·lar"),
                                              confirmTextStyle: TextStyle(
                                                  color: Constants.darkGrey(
                                                      context),
                                                  fontWeight: Constants.bold,
                                                  fontSize:
                                                      Constants.s(context)),
                                              cancelTextStyle: TextStyle(
                                                  color: Constants.darkGrey(
                                                      context),
                                                  fontWeight: Constants.bold,
                                                  fontSize:
                                                      Constants.s(context)),
                                              height: Constants.a11(context),
                                              hideHeader: true,
                                              selectedTextStyle: TextStyle(
                                                color: Constants.black(context),
                                              ),
                                              backgroundColor:
                                                  Constants.lightGrey(context),
                                              onConfirm: (Picker picker,
                                                      List values) =>
                                                  setState(() {
                                                pickedDate = DateTime(
                                                    pickedDate.year,
                                                    pickedDate.month,
                                                    pickedDate.day,
                                                    values[0],
                                                    values[1]);
                                                _calendarController
                                                    .setSelectedDay(pickedDate);
                                                consultaAforament();
                                              }),
                                              onCancel: () {},
                                            ).showDialog(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Constants.h1(context)),
                                            child: Text(
                                                (pickedDate.hour < 10
                                                        ? '0'
                                                        : '') +
                                                    pickedDate.hour.toString() +
                                                    ':' +
                                                    (pickedDate.minute < 10
                                                        ? '0'
                                                        : '') +
                                                    pickedDate.minute
                                                        .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        Constants.normal,
                                                    color: Constants.black(
                                                        context),
                                                    fontSize:
                                                        Constants.xl(context))),
                                          )),
                                      Text(
                                        ' - ',
                                        style: TextStyle(
                                            color: Constants.black(context),
                                            fontWeight: Constants.bold,
                                            fontSize: Constants.xl(context)),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Picker(
                                              adapter: DateTimePickerAdapter(
                                                  value: DateTime(
                                                      DateTime.now().year,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                      endHour,
                                                      endMinute),
                                                  customColumnType: [3, 4]),
                                              textStyle: TextStyle(
                                                  color: Constants.darkGrey(
                                                      context),
                                                  fontSize:
                                                      Constants.l(context)),
                                              confirmText:
                                                  AppLocalizations.of(context)
                                                      .translate("Confirmar"),
                                              cancelText:
                                                  AppLocalizations.of(context)
                                                      .translate("Cancel·lar"),
                                              confirmTextStyle: TextStyle(
                                                  color: Constants.darkGrey(
                                                      context),
                                                  fontWeight: Constants.bold,
                                                  fontSize:
                                                      Constants.s(context)),
                                              cancelTextStyle: TextStyle(
                                                  color: Constants.darkGrey(
                                                      context),
                                                  fontWeight: Constants.bold,
                                                  fontSize:
                                                      Constants.s(context)),
                                              height: Constants.a11(context),
                                              hideHeader: true,
                                              selectedTextStyle: TextStyle(
                                                color: Constants.black(context),
                                              ),
                                              backgroundColor:
                                                  Constants.lightGrey(context),
                                              onConfirm: (Picker picker,
                                                      List values) =>
                                                  setState(() {
                                                endHour = values[0];
                                                endMinute = values[1];
                                              }),
                                              onCancel: () {},
                                            ).showDialog(context);
                                          },
                                          child: Text(
                                              (endHour < 10 ? '0' : '') +
                                                  endHour.toString() +
                                                  ':' +
                                                  (endMinute < 10 ? '0' : '') +
                                                  endMinute.toString(),
                                              style: TextStyle(
                                                  fontWeight: Constants.normal,
                                                  color:
                                                      Constants.black(context),
                                                  fontSize:
                                                      Constants.xl(context)))),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
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
                        placeGauge != null
                            ? placeGauge.toString() +
                                ' ' +
                                AppLocalizations.of(context)
                                    .translate("persones")
                            : '',
                        style: TextStyle(
                            color:
                                Constants.black(context), //o green segú aforo
                            fontWeight: Constants.bolder,
                            fontSize: Constants.l(context)),
                      ),
                    ),
                  ]),
                ),
/*                 Padding(
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
                ]), */
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
