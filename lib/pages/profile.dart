import 'dart:convert';

import 'package:app/app_localizations.dart';
import 'package:app/defaults/constants.dart';
import 'package:app/pages/profileconfig.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  //final String title;

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  String name = '';
  String surnames = '';

  @override
  void initState() {
    super.initState();
    SecureStorage.readSecureStorage('SafetyOUT_UserId').then((id) {
      var url =
          Uri.parse('https://safetyout.herokuapp.com/user/getUserInfo/' + id);
      http.get(url).then((res) {
        if (res.statusCode == 200) {
          Map<String, dynamic> body = jsonDecode(res.body);
          Map<String, dynamic> user = body["user"];
          setState(() {
            name = user["name"];
            surnames = user["surnames"];
          });
        } else {
          //print(res.statusCode);
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
                              .translate("Error_de_xarxa"),
                          style: TextStyle(fontSize: Constants.m(context))),
                    ],
                  )),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                          AppLocalizations.of(context).translate("Acceptar"),
                          style: TextStyle(color: Constants.black(context))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
      }).catchError((err) {
        //Sale error por pantalla
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
                            .translate("Error_de_xarxa"),
                        style: TextStyle(fontSize: Constants.m(context))),
                  ],
                )),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                        AppLocalizations.of(context).translate("Acceptar"),
                        style: TextStyle(color: Constants.black(context))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Icono configuracion
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: Constants.black(context),
                  iconSize: Constants.xxl(context),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => ProfileConfig()),
                    );
                  },
                ),
              ],
            ),
            name == ''
                ? Expanded(
                    child: Container(
                      decoration:
                          BoxDecoration(color: Constants.trueWhite(context)),
                      child: Center(
                        child: SpinKitFadingCube(
                            color: Colors.grey,
                            size: 40.0 /
                                (MediaQuery.of(context).size.height < 700
                                    ? 1.3
                                    : MediaQuery.of(context).size.height < 800
                                        ? 1.15
                                        : 1)),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Constants.h7(context)),
                        child: Column(
                          children: [
                            //Imagen perfil
                            Container(
                              width: Constants.w10(context),
                              height: Constants.a10(context),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill, image: NetworkImage(
                                          //Imagen de prueba, se colocará la imagen del usuario
                                          "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"))),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: Constants.h1(context),
                            left: Constants.h7(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                //Nombre usuario
                                SizedBox(
                                  width: Constants.w11(context),
                                  child: Text(
                                    name + ' ' + surnames,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: Constants.l(context),
                                      fontWeight: Constants.bolder,
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                //Boton editar perfil
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Constants.v1(context)),
                                  child: Container(
                                    height: Constants.a6(context) +
                                        Constants.a2(context),
                                    child: TextButton(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("Editar_perfil"),
                                        style: TextStyle(
                                            fontSize: Constants.xs(context),
                                            fontWeight: Constants.bolder,
                                            color: Constants.black(context)),
                                      ),
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          primary: Constants.trueWhite(context),
                                          textStyle: TextStyle(
                                            color: Constants.black(context),
                                          ),
                                          side: BorderSide(
                                              color: Constants.black(context)),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
