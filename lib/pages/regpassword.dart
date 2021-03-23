import 'package:app/defaults/constants.dart';
import 'package:app/state/reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app/widgets/password_input.dart';
import 'package:app/widgets/password_input2.dart';
import 'package:app/pages/regextra.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../app_localizations.dart';

class RegPassword extends StatefulWidget {
  RegPassword({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _RegPassword createState() => _RegPassword();
}

class _RegPassword extends State<RegPassword> {
  Function submitSignUp = (BuildContext context) async {
    String name = Provider.of<RegState>(context, listen: false).getName;
    String email = Provider.of<RegState>(context, listen: false).getEmail;
    String gender = Provider.of<RegState>(context, listen: false).getGender;
    DateTime birthdate = Provider.of<RegState>(context, listen: false).getBirthdate;
    var url = Uri.parse('https://safetyout.herokuapp.com/signup');
    http.post(url, body: {
      'name': name,
      'email': email,
      'gender': gender,
      'birthday': birthdate
    })
    .then((res) => {
      if(res.statusCode == 201) {
        //Guardar key
        Navigator.of(context).pushReplacementNamed('/')
      }
    })
    .catchError((err) => {
      //Sale error por pantalla
    });
  };

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
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PasswordInput(
                      labelText:
                          AppLocalizations.of(context).translate("Contrasenya"))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PasswordInput2(
                      labelText: AppLocalizations.of(context)
                          .translate("Confirmar_Contrasenya"))
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
                                    builder: (context) => RegExtra()),
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
                            onPressed: submitSignUp(context),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text("Confirmar",
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
