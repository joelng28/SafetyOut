import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app/widgets/email_input.dart';

class RegData extends StatefulWidget {
  RegData({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _RegData createState() => _RegData();
}

enum Sex {
  notKnown,
  male,
  female,
  not_applicable,
}

class _RegData extends State<RegData> {
  Sex _character = Sex.notKnown;
  String _naixement;

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
                  child: Text('Registre Usuari',
                      style: TextStyle(
                          color: Constants.darkGrey(context),
                          fontSize: Constants.xxl(context),
                          fontWeight: Constants.bolder)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailInput(
                    labelText: 'Nom d\' usuari',
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailInput(
                    labelText: 'Nom Complet',
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailInput(
                    labelText: 'Correu electrònic',
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  _naixement =
                                      "${date.year}/${date.month}/${date.day}";
                                });
                              });
                            })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          _naixement == null
                              ? ' Data de naixement'
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
                    'Gènere',
                    style: TextStyle(fontWeight: Constants.bold),
                  ),
                  ListTile(
                    title: const Text('Femení'),
                    leading: Radio<Sex>(
                      value: Sex.female,
                      groupValue: _character,
                      onChanged: (Sex value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Masculí'),
                    leading: Radio<Sex>(
                      value: Sex.male,
                      groupValue: _character,
                      onChanged: (Sex value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No Binari'),
                    leading: Radio<Sex>(
                      value: Sex.not_applicable,
                      groupValue: _character,
                      onChanged: (Sex value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
