import 'package:app/defaults/constants.dart';
import 'package:app/state/reg.dart';
import 'package:app/widgets/password_input2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app/widgets/password_input.dart';
import 'package:app/widgets/password_input3.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class RegPassword extends StatefulWidget {
  RegPassword({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _RegPassword createState() => _RegPassword();
}

class _RegPassword extends State<RegPassword> {

  Function submitSignUp = (BuildContext context) {
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
    .then((res) {
      if(res.statusCode == 201) {
        //Guardar key
        Navigator.of(context).pushReplacementNamed('/');
      }
    })
    .catchError((err) {
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
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 32 /
                                  (MediaQuery.of(context).size.width < 380 ? 1.3 : 1),
                            color: Constants.black(context)
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: MediaQuery.of(context).viewInsets.bottom == 0,
                        child: Text(
                        AppLocalizations.of(context)
                            .translate("Registre_Usuari"),
                        style: TextStyle(
                            color: Constants.darkGrey(context),
                            fontSize: Constants.xl(context),
                            fontWeight: Constants.bolder)),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Constants.v4(context)),
                  child: Text(
                      AppLocalizations.of(context)
                          .translate("Introdueix_una_contrasenya"),
                      style: TextStyle(
                          color: Constants.darkGrey(context),
                          fontSize: Constants.l(context),
                          fontWeight: Constants.normal)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Constants.h4(context),
                  Constants.v5(context), Constants.h4(context), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PasswordInput2(
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
                  PasswordInput3(
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
                            onPressed: () => submitSignUp(context),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text(AppLocalizations.of(context)
                                        .translate("Confirmar"),
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
