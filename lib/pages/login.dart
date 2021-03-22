import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:app/widgets/password_input.dart';
import 'package:app/widgets/email_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../app_localizations.dart';
import '../database.dart';
import '../main.dart';

class Login extends StatefulWidget {
  Login({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  Function forgottenPassword = () {};

  Function login = () async {
    var mail = emailController.text;
    var psswd = passwordController.text;
    var psswd1 = Database.passwordByEmail(mail.toString());

    int res = psswd1.toString() == psswd.toString() ? 1 : 0;

    if (res == 1) {
      //Credencials correctes
      SecureStorage.writeSecureStorage("Email", mail.toString());
      SecureStorage.writeSecureStorage('Password', psswd.toString());
    } else {
      //Credencials incorrectes
      Widget build(BuildContext context) {
        return AlertDialog(
          title: Text('Error contrasenya o correu'),
          content: Text("Credenciales incorrectas"),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                child: Text("Aceptar"),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      }
    }
  };

  Function facebookLogin = () {};

  Function googleLogin = () {};

  Function goToRegister = () {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Padding(
                  padding: EdgeInsets.only(top: Constants.xs(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SafetyOUT',
                          style: TextStyle(
                            fontSize: 40 /
                                (MediaQuery.of(context).size.width < 380
                                    ? 1.3
                                    : 1),
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
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Row(
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
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Constants.v1(context)),
                      child: Text(
                          AppLocalizations.of(context).translate("Benvingut"),
                          style: TextStyle(
                              color: Constants.darkGrey(context),
                              fontSize: Constants.xxl(context),
                              fontWeight: Constants.bolder)),
                    ),
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
                      labelText: AppLocalizations.of(context)
                          .translate("Correu_electronic"),
                      prefixIcon: FontAwesomeIcons.solidUser,
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
                    PasswordInput(
                        labelText: AppLocalizations.of(context)
                            .translate("Contrasenya"))
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(Constants.h4(context),
                      Constants.v1(context), Constants.h4(context), 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: forgottenPassword,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Has_oblidat_la_contrasenya"),
                              style: TextStyle(
                                  fontSize: Constants.m(context),
                                  fontWeight: Constants.bold,
                                  color: Constants.link(context)))),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(Constants.h4(context),
                    Constants.v1(context), Constants.h4(context), 0),
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
                              key: Key('loginButton'),
                              onPressed: login,
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("Iniciar_sessio"),
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
              Padding(
                padding: EdgeInsets.only(
                    top: Constants.v2(context), bottom: Constants.v2(context)),
                child: Row(children: [
                  Expanded(
                      flex: 45,
                      child:
                          Container(height: 2, color: Constants.grey(context))),
                  Expanded(
                      flex: 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context).translate("O"),
                              style: TextStyle(
                                  fontSize: Constants.xl(context),
                                  fontWeight: Constants.bold)),
                        ],
                      )),
                  Expanded(
                      flex: 45,
                      child: Container(
                        height: 2,
                        color: Constants.grey(context),
                      )),
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Constants.h4(context), 0, Constants.h4(context), 0),
                child: Row(children: [
                  Expanded(
                    flex: 45,
                    child: SizedBox(
                      height: Constants.a7(context),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                color: Color.fromARGB(100, 0, 0, 0),
                              )
                            ]),
                        child: TextButton(
                            onPressed: facebookLogin,
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: Constants.h1(context)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 1),
                                      child: SvgPicture.asset(
                                        'assets/icons/facebook.svg',
                                        color: Colors.blueAccent[700],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('FACEBOOK',
                                            style: TextStyle(
                                                fontSize: Constants.s(context),
                                                fontWeight: Constants.bold,
                                                color: Colors.blueAccent[700])),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Spacer(flex: 15),
                  Expanded(
                    flex: 45,
                    child: SizedBox(
                      height: Constants.a7(context),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                color: Color.fromARGB(100, 0, 0, 0),
                              )
                            ]),
                        child: TextButton(
                            onPressed: googleLogin,
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Constants.h1(context),
                                  right: Constants.h1(context)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 25,
                                    child: SvgPicture.asset(
                                      'assets/icons/google.svg',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 75,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('GOOGLE',
                                            style: TextStyle(
                                                fontSize: Constants.s(context),
                                                fontWeight: Constants.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
        bottomSheet: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(Constants.h4(context), 0,
                Constants.h4(context), Constants.v7(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).translate("No_tens_un_compte") +
                      ' ',
                  style: TextStyle(
                      color: Constants.black(context),
                      fontSize: Constants.m(context)),
                ),
                InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: goToRegister,
                    child: Text(
                      AppLocalizations.of(context).translate("Registrat"),
                      style: TextStyle(
                        color: Constants.link(context),
                        fontSize: Constants.m(context),
                        fontWeight: Constants.bold,
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
