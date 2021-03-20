import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app/pages/regdata.dart';
import 'package:app/pages/regpassword.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_localizations.dart';

enum Sex {
  notKnown,
  male,
  female,
  not_applicable,
}

class RegExtra extends StatefulWidget {
  RegExtra({Key key /*, this.title*/}) : super(key: key);
  //final String title;

  @override
  _RegExtra createState() => _RegExtra();
}

class _RegExtra extends State<RegExtra> {
  Sex _genere;
  String _naixement;
  String _mes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: Constants.xs(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('SafetyOUT',
                      style: TextStyle(
                        fontSize: 40 /
                            (MediaQuery.of(context).size.width < 380 ? 1.3 : 1),
                        fontWeight: Constants.bolder,
                        /* shadows: [
                          Shadow(
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            color: Color.fromARGB(100, 0, 0, 0),
                          ),
                        ] */
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  color: Constants.black(context),
                  height: 150 /
                      (MediaQuery.of(context).size.height < 700
                          ? 1.5
                          : MediaQuery.of(context).size.height < 800
                              ? 1.3
                              : 1),
                  width: 150 /
                      (MediaQuery.of(context).size.height < 700
                          ? 1.5
                          : MediaQuery.of(context).size.height < 800
                              ? 1.3
                              : 1),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Constants.v1(context)),
                  child: Text(
                      AppLocalizations.of(context).translate("Registre_Usuari"),
                      style: TextStyle(
                          color: Constants.darkGrey(context),
                          fontSize: Constants.xxl(context),
                          fontWeight: Constants.bolder)),
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
                    Column(
                      children: [
                        ElevatedButton(
                            child: Text('Selecciona Data'),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now())
                                  .then((date) {
                                setState(() {
                                  _mes = "Mes" + date.month.toString();
                                  _naixement = date.day.toString() +
                                      "/" +
                                      AppLocalizations.of(context)
                                          .translate(_mes) +
                                      "/" +
                                      date.year.toString();
                                });
                              });
                            })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _naixement == null
                              ? ' ' +
                                  AppLocalizations.of(context)
                                      .translate("Data_naixement")
                              : ' ' + _naixement,
                          style: TextStyle(fontWeight: Constants.bold),
                        )
                      ],
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate("Gènere"),
                    style: TextStyle(fontWeight: Constants.bold),
                  ),
                  ListTile(
                    title: const Text('Cap'),
                    trailing: Icon(FontAwesomeIcons.genderless),
                    leading: Radio<Sex>(
                      value: Sex.notKnown,
                      groupValue: _genere,
                      onChanged: (Sex value) {
                        setState(() {
                          _genere = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Femení'),
                    trailing: Icon(FontAwesomeIcons.venus),
                    leading: Radio<Sex>(
                      value: Sex.female,
                      groupValue: _genere,
                      onChanged: (Sex value) {
                        setState(() {
                          _genere = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Masculí'),
                    trailing: Icon(FontAwesomeIcons.mars),
                    leading: Radio<Sex>(
                      value: Sex.male,
                      groupValue: _genere,
                      onChanged: (Sex value) {
                        setState(() {
                          _genere = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Transgènere'),
                    trailing: Icon(FontAwesomeIcons.transgenderAlt),
                    leading: Radio<Sex>(
                      value: Sex.not_applicable,
                      groupValue: _genere,
                      onChanged: (Sex value) {
                        setState(() {
                          _genere = value;
                        });
                      },
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
                  Expanded(
                    child: SizedBox(
                      height: Constants.a7(context),
                      child: Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegData()),
                              );
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text("Enrere",
                                style: TextStyle(
                                    fontSize: Constants.m(context),
                                    fontWeight: Constants.bold,
                                    color: Constants.primaryDark(context)))),
                      ),
                    ),
                  ),
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
                                MaterialPageRoute(
                                    builder: (context) => RegPassword()),
                              );
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text("Següent",
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
