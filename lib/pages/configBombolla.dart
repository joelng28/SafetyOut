import 'dart:convert';
//import 'dart:html';

import 'package:app/defaults/constants.dart';
import 'package:app/pages/profile.dart';
import 'package:app/widgets/raw_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:http/http.dart' as http;

import '../app_localizations.dart';

class ConfigBubble extends StatefulWidget {
  ConfigBubble({Key key, @required this.BubbleId, this.UserId})
      : super(key: key);
  final String BubbleId;
  final String UserId;
  @override
  _ConfigBubble createState() => _ConfigBubble(this.BubbleId, this.UserId);
}

class _ConfigBubble extends State<ConfigBubble> {
  _ConfigBubble(this.bubbleId, this.userId);
  final String bubbleId;
  final String userId;
  String adminId;
  List<String> MembersIDs = [];
  List<String> MembersNames = [];
  static String bubbleName;

  void getInfoBombolla() {
    MembersIDs.clear();
    MembersNames.clear();
    var urlB = Uri.parse('https://safetyout.herokuapp.com/bubble/' + bubbleId);
    http.get(urlB).then((res) {
      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        Map<String, dynamic> binfo = body["bubble"];
        setState(() {
          bubbleName = binfo['name'];
          adminId = binfo['admin'];
          binfo['members'].forEach((m) {
            Map<String, dynamic> member = m;
            MembersIDs.add(member["userId"]);
            var urlName = Uri.parse(
                'https://safetyout.herokuapp.com/user/' + member["userId"]);
            http.get(urlName).then((resName) {
              if (resName.statusCode == 200) {
                Map<String, dynamic> bodyName = jsonDecode(resName.body);
                Map<String, dynamic> user = bodyName["user"];
                setState(() {
                  MembersNames.add(user['name'] + " " + user["surnames"]);
                });
              }
            });
          });
        });
      }
    });
  }

  void outOfBubble() {
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
                        .translate("Segur_que_vols_sortir_de_la_bombolla"),
                    style: TextStyle(fontSize: Constants.m(context))),
              ],
            )),
            actions: <Widget>[
              TextButton(
                  child: Text(AppLocalizations.of(context).translate("Sortir"),
                      style: TextStyle(color: Constants.red(context))),
                  onPressed:
                      () {} /*{
                  var url = Uri.parse(
                      'https://safetyout.herokuapp.com/chat/' + chatId);
                  http.delete(url).then((res) {
                    if (res.statusCode == 200) {
                      print("OK");
                      Navigator.of(context).pop();
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              Profile())); //Tornar a profile
                    } else {
                      print(res.statusCode);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding:
                                  EdgeInsets.fromLTRB(24, 20, 24, 0),
                              content: SingleChildScrollView(
                                  child: ListBody(
                                children: <Widget>[
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate("Error_de_xarxa"),
                                      style: TextStyle(
                                          fontSize: Constants.m(context))),
                                ],
                              )),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate("Acceptar"),
                                      style: TextStyle(
                                          color: Constants.black(context))),
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
                                    style: TextStyle(
                                        fontSize: Constants.m(context))),
                              ],
                            )),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                    AppLocalizations.of(context)
                                        .translate("Acceptar"),
                                    style: TextStyle(
                                        color: Constants.black(context))),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  });
                },*/
                  ),
              TextButton(
                child: Text(
                    AppLocalizations.of(context).translate("Cancel·lar"),
                    style: TextStyle(color: Constants.black(context))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void deleteMember(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Text("Segur que vols eliminar a " + MembersNames[index] + " ?",
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
                child: Text(AppLocalizations.of(context).translate("Confirmar"),
                    style: TextStyle(color: Constants.black(context))),
                onPressed: () {
                  Navigator.of(context).pop();
                  calldeleteMember(index);
                },
              ),
            ],
          );
        });
  }

  void calldeleteMember(int index) {
    var url = Uri.parse('https://safetyout.herokuapp.com/bubble/' +
        bubbleId +
        '/members/' +
        MembersIDs[index]);
    http.delete(url).then((res) {
      Map<String, dynamic> body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        getInfoBombolla();
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                content: SingleChildScrollView(
                    child: ListBody(
                  children: <Widget>[
                    Text(body["message"],
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

  void deleteBubble() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Text("Segur que vols eliminar la bombolla?",
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
                child: Text(AppLocalizations.of(context).translate("Confirmar"),
                    style: TextStyle(color: Constants.black(context))),
                onPressed: () {
                  Navigator.of(context).pop();
                  calldeleteBubble();
                },
              ),
            ],
          );
        });
  }

  void calldeleteBubble() {
    var url = Uri.parse('https://safetyout.herokuapp.com/bubble/' + bubbleId);
    http.delete(url).then((res) {
      Map<String, dynamic> body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Navigator.push(
          context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => Profile()),
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                content: SingleChildScrollView(
                    child: ListBody(
                  children: <Widget>[
                    Text(body["message"],
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

  @override
  void initState() {
    super.initState();
    getInfoBombolla();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
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
                    child: Text("Configurar Bombolla",
                        style: TextStyle(
                            color: Constants.darkGrey(context),
                            fontSize: Constants.xl(context),
                            fontWeight: Constants.bolder)),
                  ),
                ),
                Align(
                  // BotoCrearBombolla
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: Constants.xxs(context)),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {},
                      child: Icon(Icons.check,
                          size: 32 /
                              (MediaQuery.of(context).size.width < 380
                                  ? 1.3
                                  : 1),
                          color: Constants.black(context)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      top: Constants.v7(context), left: Constants.h7(context)),
                  child: Text(
                    AppLocalizations.of(context).translate('Nom_Bombolla'),
                    style: TextStyle(
                        color: Constants.black(context),
                        fontSize: Constants.m(context),
                        fontWeight: Constants.bold),
                  ))),
          Padding(
            padding: EdgeInsets.fromLTRB(Constants.h7(context),
                Constants.v1(context), Constants.h7(context), 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawInput(
                  labelText: bubbleName == null
                      ? AppLocalizations.of(context).translate("Nom_Bombolla")
                      : bubbleName,
                  onChanged: (value) => setState(() {
                    bubbleName = value;
                  }),
                )
              ],
            ),
          ),
          Flexible(
            child: Padding(
                padding: EdgeInsets.only(
                    top: Constants.v2(context),
                    left: Constants.h1(context),
                    right: Constants.h1(context)),
                child: ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: MembersNames.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: ListTile(
                        leading: Container(
                            width: Constants.w9(context),
                            height: Constants.w9(context),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    //fit: BoxFit.cover,
                                    image: NetworkImage(
                                        //Imagen de prueba, se colocará la imagen del usuario
                                        "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg")))),
                        title: Text(
                          MembersNames[index],
                          style: TextStyle(
                              color: Constants.black(context),
                              fontWeight: Constants.bolder,
                              fontSize: Constants.l(context)),
                        ),
                        trailing: adminId == userId
                            ? IconButton(
                                icon: Icon(Icons.close,
                                    color: Constants.red(context)),
                                iconSize: Constants.w6(context),
                                onPressed: () {
                                  deleteMember(index);
                                })
                            : null,
                      ));
                    })),
          )
        ])),
        bottomSheet: (adminId != userId) == true
            ? SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: Constants.v7(context)),
                      child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => outOfBubble(),
                          child: Text("Sortir de la bombolla",
                              style: TextStyle(
                                  fontSize: Constants.m(context),
                                  fontWeight: Constants.bold,
                                  color: Constants.red(context)))),
                    ),
                  ],
                ),
              )
            : SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: Constants.v7(context)),
                      child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => deleteBubble(),
                          child: Text("Eliminar bombolla",
                              style: TextStyle(
                                  fontSize: Constants.m(context),
                                  fontWeight: Constants.bold,
                                  color: Constants.red(context)))),
                    ),
                  ],
                ),
              ) //Boton eliminar bombolla
        );
  }
}
