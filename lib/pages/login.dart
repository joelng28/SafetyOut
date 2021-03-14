import 'package:app/defaults/constants.dart';
import 'package:app/widgets/password_input.dart';
import 'package:app/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  Login({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
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
                    Text(
                      'SafetyOUT',
                      style: TextStyle(
                        fontSize: 40 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1),
                        fontWeight: Constants.bolder,
                        /* shadows: [
                          Shadow(
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            color: Color.fromARGB(100, 0, 0, 0),
                          ),
                        ] */
                      )
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/logo.svg',
                    color: Constants.black,
                    height: 150 / (MediaQuery.of(context).size.height < 700 ? 1.5 : MediaQuery.of(context).size.height < 800 ? 1.3 : 1),
                    width: 150 / (MediaQuery.of(context).size.height < 700 ? 1.5 : MediaQuery.of(context).size.height < 800 ? 1.3 : 1),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Constants.v1(context)),
                    child: Text(
                      'Benvingut',
                      style: TextStyle(
                        color: Constants.darkGrey,
                        fontSize: Constants.xxl(context),
                        fontWeight: Constants.bolder
                      )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(Constants.h4(context), Constants.v5(context), Constants.h4(context), 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInput(
                      labelText: 'Correu electrònic',
                      prefixIcon: Icons.person,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(Constants.h4(context), Constants.v5(context), Constants.h4(context), 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PasswordInput(
                      labelText: 'Contrasenya'
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(Constants.h4(context), Constants.v1(context), Constants.h4(context), 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Has oblidat la contrasena?',
                        style: TextStyle(
                          fontSize: Constants.m(context),
                          fontWeight: Constants.bold,
                          color: Constants.link
                        )
                      )
                    ),
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(Constants.h4(context), Constants.v1(context), Constants.h4(context), 0),
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
                            ]
                          ),
                          child: TextButton(
                            onPressed: () {}, 
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.transparent)
                            ),
                            child: Text(
                              'Inicia sessió',
                              style: TextStyle(
                                fontSize: Constants.m(context),
                                fontWeight: Constants.bold,
                                color: Constants.primaryDark
                              )
                            )
                          ),
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
