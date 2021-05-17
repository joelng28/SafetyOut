import 'dart:convert';
import 'dart:io';

import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';

import 'package:app/widgets/email_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_localizations.dart';
import 'package:http/http.dart' as http;

class Contacts extends StatefulWidget {
  Contacts({Key key}) : super(key: key);

  @override
  _Contacts createState() => _Contacts();
}

class _Contacts extends State<Contacts> {
  List<String> Contactos = ['Contacto1', 'Contacto2'];
  List<String> ContactoSolicitudName = ['prova9'];
  List<String> ContactoSolicitudID = [];
  String email;
  FocusNode pwdFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SecureStorage.readSecureStorage('SafetyOUT_UserId').then((id) {
      var url2 = Uri.parse(
          'https://safetyout.herokuapp.com/user/' + id + '/friendRequests');
      http.get(url2).then((res) {
        if (res.statusCode == 200) {
          Map<String, dynamic> body = jsonDecode(res.body);
          print(body);
          ContactoSolicitudName.add(
              body['friendRequests'][0]['user_id_request']);
          ContactoSolicitudID.add(body['friendRequests'][0]['_id']);
          print(ContactoSolicitudID);
        }
      });
    });
  }

  void acceptarSolicitud(BuildContext context, int index) {
    var url = Uri.parse('https://safetyout.herokuapp.com/friendRequest/' +
        ContactoSolicitudID[index] +
        '/accept');
    http.post(url).then((res) {
      if (res.statusCode == 200) {
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
                            .translate("Sol·licitud_acceptada"),
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
    });
  }

  void rebutjarSolicitud(BuildContext context, int index) {
    var url = Uri.parse('https://safetyout.herokuapp.com/friendRequest/' +
        ContactoSolicitudID[index] +
        '/deny');
    http.post(url).then((res) {
      if (res.statusCode == 200) {
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
                            .translate("Sol·licitud_rebutjada"),
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
    });
  }

  void submitEnviar(BuildContext context) {
    print(email);

    var url = Uri.parse('https://safetyout.herokuapp.com/user?email=' + email);
    http.get(url).then((res) {
      if (res.statusCode == 200) {
        //Ventana informant sol·licitud pendent
        Map<String, dynamic> body = jsonDecode(res.body);
        var url1 = Uri.parse('https://safetyout.herokuapp.com/friendRequest');
        SecureStorage.readSecureStorage('SafetyOUT_UserId').then((id) {
          http.post(url1, body: {
            'user_id_request': id,
            'user_id_requested': body["id"]
          }).then((res) {
            if (res.statusCode == 201) {
              Navigator.of(context).pop();
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
                                  .translate("Sol·licitud_pendent"),
                              style: TextStyle(fontSize: Constants.m(context))),
                        ],
                      )),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("Acceptar"),
                              style:
                                  TextStyle(color: Constants.black(context))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          });
        });
      }
    }).catchError((err) {
      print(err);
      //Sale error por pantalla
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate("Error de xarxa"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
      Expanded(
        //Solicitus de contacte
        child: ListView.separated(
          itemBuilder: (_, index) =>
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              width: 50.0, //Constants.w9(context),
              height: 50.0, //Constants.w9(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(
                      //Imagen de prueba, se colocará la imagen del usuario
                      "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"))),
            ),
            Flexible(child: Text(ContactoSolicitudName[index])),
            Flexible(
                //Acceptar contacte
                child: IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    iconSize: 30.0,
                    onPressed: () {
                      acceptarSolicitud(context, index);
                    })),
            Container(
                //Cancelar contacte
                child: IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red),
                    iconSize: 30.0,
                    onPressed: () {
                      rebutjarSolicitud(context, index);
                    }))
          ]),
          separatorBuilder: (_, __) => Divider(),
          itemCount: ContactoSolicitudName.length,
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        //Boto afegir contacte
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                          title: Text('Envia una sol·licitud de contacte'),
                          content: EmailInput(
                            labelText: AppLocalizations.of(context)
                                .translate("Correu_electronic"),
                            prefixIcon: FontAwesomeIcons.solidUser,
                            onChanged: (val) => setState(() {
                              email = val;
                            }),
                            onSubmitted: (val) => pwdFocusNode.requestFocus(),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('Cancel·lar'),
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                Navigator.of(context).pop('Cancel·lar');
                              },
                            ),
                            TextButton(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('Enviar'),
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () => setState(() {
                                      submitEnviar(context);
                                    }))
                          ]));
            },
            style: ButtonStyle(
                /*padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        vertical: Constants.v1(context),
                        horizontal: Constants.h1(context))),*/
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0),
                )),
                backgroundColor:
                    MaterialStateProperty.all(Constants.trueWhite(context))),
            child: Text(
                AppLocalizations.of(context).translate('Afegeix_contacte'),
                style: TextStyle(
                    fontSize: Constants.m(context),
                    fontWeight: Constants.bold,
                    color: Constants.black(context))))
      ]),
      Flexible(
        child: ListView.separated(
          itemBuilder: (_, index) =>
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: Constants.w9(context),
              height: Constants.w9(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(
                      //Imagen de prueba, se colocará la imagen del usuario
                      "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"))),
            ),
            Flexible(child: Text(Contactos[index]))
          ]),
          separatorBuilder: (_, __) => Divider(),
          itemCount: Contactos.length,
        ),
      )
    ]));
  }
}
