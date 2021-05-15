import 'dart:convert';

import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/models/contactChat.dart';
import 'package:http/http.dart' as http;

import '../app_localizations.dart';
import 'conversa.dart';

class NewChat extends StatefulWidget {
  NewChat({Key key}) : super(key: key);

  @override
  _NewChat createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  List<Contact> contacts = [];
  /*@override
  void dispose() {
    super.dispose();
  }*/

  @override
  void initState() {
    super.initState();
    SecureStorage.readSecureStorage('SafetyOUT_UserId').then((id) {
      var url =
          Uri.parse('https://safetyout.herokuapp.com/user/' + id + '/friends');
      http.get(url).then((res) {
        if (res.statusCode == 200) {
          Map<String, dynamic> body = jsonDecode(res.body);
          List<dynamic> friends = body["friends"];
          friends.forEach((element) {
            Map<String, dynamic> user = element;
            String userid = user["userId"].toString();
            var url2 =
                Uri.parse('https://safetyout.herokuapp.com/user/' + userid);
            http.get(url2).then((res) {
              if (res.statusCode == 200) {
                Map<String, dynamic> body2 = jsonDecode(res.body);
                Map<String, dynamic> user2 = body2["user"];
                setState(() {
                  print(userid);
                  Contact c = Contact(
                      name: user2["name"].toString() + " " + user2["surnames"]);
                  contacts.add(c);
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
                                style:
                                    TextStyle(fontSize: Constants.m(context))),
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
            });
          });
        } else {
          (print(res.statusCode));
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
        appBar: AppBar(
          backgroundColor: Constants.white(context),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(AppLocalizations.of(context).translate("Iniciar_xat")),
        ),
        body: Stack(children: [
          ListView.separated(
            padding: EdgeInsets.only(
                top: Constants.a5(context), bottom: Constants.a5(context)),
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: contacts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                  child: ListTile(
                leading: Container(
                  width: Constants.w7(context),
                  height: Constants.w7(context),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(
                          //Imagen de prueba, se colocará la imagen del usuario
                          "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"))),
                ),
                title: Text(
                  contacts[index].name,
                  style: TextStyle(
                      color: Constants.black(context),
                      fontWeight: Constants.bolder,
                      fontSize: Constants.l(context)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Conversa()));
                },
              ));
            },
          )
        ]));
  }
}
