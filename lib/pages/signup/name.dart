import 'package:app/defaults/constants.dart';
import 'package:app/pages/signup/email.dart';
import 'package:app/widgets/raw_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../state/reg.dart';
import '../../widgets/raw_input.dart';

class RegData extends StatefulWidget {
  RegData({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _RegData createState() => _RegData();
}

class _RegData extends State<RegData> {
  Function paraEmail = (BuildContext context) {
    String nom = textController.text.toString();
    Provider.of<RegState>(context, listen: false).setName(nom);
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (_, __, ___) => Email()),
    );
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
                      /* AppLocalizations.of(context)
                            .translate("Registre_Usuari") */
                      'Introdueix el teu nom complet',
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
                  RawInput(
                    labelText:
                        AppLocalizations.of(context).translate("Nom_Complet"),
                  )
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
                            onPressed: () => paraEmail(context),
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
