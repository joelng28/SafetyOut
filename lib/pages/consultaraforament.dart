import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app_localizations.dart';

class ConsultarAforament extends StatefulWidget {
  ConsultarAforament({Key key}) : super(key: key);

  @override
  _ConsultarAforament createState() => _ConsultarAforament();
}

class _ConsultarAforament extends State<ConsultarAforament> {
  CalendarController _calendarController;
  DateTime pickedDate = DateTime.now();
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Aforament per hores'),
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
                  "Nom",
                  style: TextStyle(
                      color: Constants.black(context),
                      fontWeight: Constants.bolder,
                      fontSize: Constants.l(context)),
                )
              ]),
              Row(children: [
                Text(
                  "Ciutat, comarca, país",
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
