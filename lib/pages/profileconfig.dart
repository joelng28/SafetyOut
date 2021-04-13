import 'package:app/state/app_language.dart';
import 'package:app/app_localizations.dart';
import 'package:app/defaults/constants.dart';
import 'package:app/pages/app.dart';
import 'package:app/pages/login.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ProfileConfig extends StatefulWidget {
  ProfileConfig({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _ProfileConfig createState() => _ProfileConfig();
}

enum Appearence { light, dark, system }

class _ProfileConfig extends State<ProfileConfig> {
  Function logOut = (BuildContext context) {
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
                        .translate("Segur_que_vols_tancar_sessió"),
                    style: TextStyle(fontSize: Constants.m(context))),
              ],
            )),
            actions: <Widget>[
              TextButton(
                child: Text(
                    AppLocalizations.of(context).translate("Cancel·lar"),
                    style: TextStyle(color: Constants.black(context))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                    AppLocalizations.of(context).translate("Tancar_sessió"),
                    style: TextStyle(color: Constants.black(context))),
                onPressed: () {
                  Navigator.of(context).pop();
                  SecureStorage.deleteSecureStorage().then((val) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (_, __, ___) => Login()),
                    );
                  });
                },
              ),
            ],
          );
        });
  };

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    Locale locale = appLanguage.appLocal;
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
                            Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => App()));
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
                                .translate("Configuracio"),
                            style: TextStyle(
                                color: Constants.darkGrey(context),
                                fontSize: Constants.xl(context),
                                fontWeight: Constants.bolder)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(Constants.h4(context),
                    Constants.v7(context), Constants.h4(context), 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      child: Text(
                        'Canviar idioma',
                        style: TextStyle(
                            fontSize: Constants.l(context),
                            fontWeight: Constants.normal,
                            color: Constants.black(context)),
                      ),
                      onTap: () {
                        showPlatformDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(
                              'Canviar idioma',
                              style: TextStyle(
                                  fontSize: Constants.l(context),
                                  fontWeight: Constants.bold,
                                  color: Constants.black(context)),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Català',
                                      style: TextStyle(
                                          fontSize: Constants.m(context),
                                          color: Constants.black(context)),
                                    ),
                                    Radio(
                                      fillColor: MaterialStateProperty.all(
                                          Constants.black(context)),
                                      activeColor: Constants.primary(context),
                                      value: Locale('ca'),
                                      groupValue: locale,
                                      onChanged: (Locale val) {
                                        locale = val;
                                        appLanguage
                                            .changeLanguage(Locale("ca"));
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Castellà',
                                      style: TextStyle(
                                          fontSize: Constants.m(context),
                                          color: Constants.black(context)),
                                    ),
                                    Radio(
                                      fillColor: MaterialStateProperty.all(
                                          Constants.black(context)),
                                      activeColor: Constants.primary(context),
                                      value: Locale('es'),
                                      groupValue: locale,
                                      onChanged: (Locale val) {
                                        locale = val;
                                        appLanguage
                                            .changeLanguage(Locale("es"));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: PlatformText('OK'),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: Constants.v7(context)),
                child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () => logOut(context),
                    child: Text(
                        AppLocalizations.of(context).translate("Tancar_sessió"),
                        style: TextStyle(
                            fontSize: Constants.m(context),
                            fontWeight: Constants.bold,
                            color: Constants.red(context)))),
              ),
            ],
          ),
        ));
  }
}
