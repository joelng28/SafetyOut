import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_localizations.dart';
import '../defaults/constants.dart';
import '../pages/Attendance.dart';



class DetailsAttendance extends StatefulWidget {
  final Attendance assistencia;
    
  DetailsAttendance({Key key, @required this.assistencia}) : super(key: key);

  @override
  _DetailsAttendanceState createState() => _DetailsAttendanceState();
}

class _DetailsAttendanceState extends State<DetailsAttendance> {
  Function guardarCanvis = (BuildContext context) {
    //CRIDA API
    Navigator.of(context).pop();
  };

  Function borrarAssistencia = (BuildContext context) {
    //CRIDA API
    Navigator.of(context).pop();
  };

  var _calendarController;

  var pickedDate;

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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: Constants.xxs(context)),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: guardarCanvis(context),
                        child: Icon(Icons.check,
                            size: 32 /
                                (MediaQuery.of(context).size.width < 380
                                    ? 1.3
                                    : 1),
                            color: Constants.black(context)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v7(context), Constants.h4(context), 0),
              child: Text(
                  widget.assistencia.latitud, //placename,
                  style: TextStyle(
                      color: Constants.black(context),
                      fontSize: Constants.xxl(context),
                      fontWeight: Constants.bolder)),
            ),
            Text(
              widget.assistencia.longitud,//placeLocation,
              style: TextStyle(
                  color: Constants.black(context))
            ),
            TableCalendar( //DatePicker
                  locale:
                     Localizations.localeOf(context).toLanguageTag(),
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
                            leftChevronIcon: Icon(Icons.arrow_back_ios_rounded,
                                color: Constants.black(context)),
                            rightChevronIcon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Constants.black(context)),
                          ),
                          onDaySelected: (date, events, holidays) =>
                              setState(() {
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
                                pickedDate = DateTime(1900 + values[0],
                                    values[1] + 1, pickedDate.day);
                                _calendarController.setSelectedDay(pickedDate);
                              }),
                              onCancel: () {},
                            ).showDialog(context);
                          },
                        ),
            Expanded( //BotoBorrarAsistencia
              child: SizedBox(
                height: Constants.a7(context),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Constants.red(context), width: 2)),
                  child: TextButton(
                      onPressed: () => borrarAssistencia(context),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.transparent)),
                      child: Text(
                          AppLocalizations.of(context)
                              .translate("Borrar_Assistencia"),
                          style: TextStyle(
                              fontSize: Constants.m(context),
                              fontWeight: Constants.bold,
                              color: Constants.red(context)))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}