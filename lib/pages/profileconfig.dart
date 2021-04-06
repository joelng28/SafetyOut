import 'package:app/app_localizations.dart';
import 'package:app/defaults/constants.dart';
import 'package:app/pages/login.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class ProfileConfig extends StatefulWidget {
  ProfileConfig({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _ProfileConfig createState() => _ProfileConfig();
}

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
                AppLocalizations.of(context).translate("Segur_que_vols_tancar_sessió"),
                style: TextStyle(
                  fontSize: Constants.m(context)
                )
              ),
            ],
          )
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              AppLocalizations.of(context).translate("Cancel·lar"),
              style: TextStyle(
                color: Constants.black(context)
              )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              AppLocalizations.of(context).translate("Tancar_sessió"),
              style: TextStyle(
                color: Constants.black(context)
              )),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Constants.a7(context),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Constants.red(context),
                              width: 2
                            )
                        ),
                        child: TextButton(
                            onPressed: () => logOut(context),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text(
                                AppLocalizations.of(context)
                                  .translate("Tancar_sessió"),
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
          ],
        ),
      ),
    );
  }
}
