import 'dart:convert';
//import 'dart:html';

import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:app/widgets/raw_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:http/http.dart' as http;

import '../app_localizations.dart';

class ConfigBubble extends StatefulWidget {
  ConfigBubble({Key key, @required this.BubbleId, this.UserId}) : super(key: key);
  final String BubbleId;
  final String UserId;
  @override
  _ConfigBubble createState() => _ConfigBubble(this.BubbleId, this.UserId);
}

class _ConfigBubble extends State<ConfigBubble> {
  _ConfigBubble(this.bubbleId, this.userId);
  final String bubbleId;
  final String userId;
  bool isAdmin = false;
  List<String> MembersIDs = [];
  List<String> MembersNames = [];
  static String bubbleName;

  void getInfoBombolla() {
    MembersIDs.clear();
    var urlB = Uri.parse('https://safetyout.herokuapp.com/bubble/' + bubbleId);
    http.get(urlB).then((resName) {
      if (resName.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(resName.body);
        setState(() {
          bubbleName = body['name'];
          SecureStorage.readSecureStorage('SafetyOUT_UserId').then((id) {
            isAdmin = id == body['admin'];
          });
          MembersIDs = body['members'];
        });
      }
    });
  }

  void getParticipants() {
    MembersNames.clear();
    MembersIDs.forEach((id) {
      var urlName = Uri.parse(
          'https://safetyout.herokuapp.com/user/' + id);
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
  }

  void eliminarParticipant(int index) {}

  void eliminarBombolla() {}

  void sortirBombolla() {}

  @override
  void initState() {
    super.initState();
    getInfoBombolla();
    getParticipants();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column( children: <Widget>[
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
                            "Configurar Bombolla",
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
              Align( alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: Constants.v7(context),
                          left: Constants.h7(context)),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('Nom_Bombolla'),
                        style: TextStyle(
                            color: Constants.black(context),
                            fontSize: Constants.m(context),
                            fontWeight: Constants.bold),
                      )
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(Constants.h7(context),
                    Constants.v1(context), Constants.h7(context), 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawInput(
                      labelText:
                      AppLocalizations.of(context).translate("Nom_Bombolla"),
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
                          return ListTile(
                              leading: Container(
                                  width: Constants.w9(context),
                                  height: Constants.w9(context),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        //fit: BoxFit.cover,
                                          image: NetworkImage(
                                            //Imagen de prueba, se colocará la imagen del usuario
                                              "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg")))
                              ),
                              title: Text(
                                MembersNames[index],
                                style: TextStyle(
                                    color: Constants.black(context),
                                    fontWeight: Constants.bolder,
                                    fontSize: Constants.l(context)),
                              ),
                              trailing: isAdmin ? Icon(
                                  Icons.close,
                                  color: Constants.red(context)
                              ) : null,
                              onTap: () {eliminarParticipant(index);}
                          );
                        }
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: Constants.v7(context)),
                child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    child: Text(
                        isAdmin ?
                        AppLocalizations.of(context).translate("Borrar_Bombolla")
                        : AppLocalizations.of(context).translate("Sortir_Bombolla"),
                        style: TextStyle(
                            fontSize: Constants.m(context),
                            fontWeight: Constants.bold,
                            color: Constants.red(context))),
                    onTap: () => isAdmin ? eliminarBombolla() : sortirBombolla()),
              ),
            ])
        )
    );
  }


}