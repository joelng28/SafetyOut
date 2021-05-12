import 'package:app/defaults/constants.dart';
import 'package:app/pages/newchat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app/models/contactChat.dart';

import '../app_localizations.dart';
import 'conversa.dart';

class Chats extends StatefulWidget {
  Chats({Key key}) : super(key: key);

  @override
  _Chats createState() => _Chats();
}

class _Chats extends State<Chats> {
  final textController = TextEditingController();

  List<Contact> chats = [
    Contact(name: 'Joel', lastMessage: "Hola que tal"),
    Contact(name: 'Joel2', lastMessage: "Hola que tal2")
  ];

  /*@override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    if (chats.isNotEmpty) {
      return Expanded(
          child: Scaffold(
        body: Stack(
          children: [
            ListView.separated(
                padding: EdgeInsets.only(
                    top: Constants.a5(context), bottom: Constants.a5(context)),
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: chats.length,
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
                      chats[index].name,
                      style: TextStyle(
                          fontWeight: Constants.bolder,
                          fontSize: Constants.l(context)),
                    ),
                    subtitle: Text(
                      chats[index].lastMessage,
                      style: TextStyle(fontSize: Constants.s(context)),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Conversa()));
                    },
                  ));
                })
          ],
        ),
      ));
    } else {
      return Expanded(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (_, __, ___) => NewChat()),
                    );
                  },
                  child: const Icon(Icons.chat_outlined, color: Colors.black),
                  backgroundColor: Constants.green(context)),
              body: Stack(children: [
                Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .translate("Aixó_està_molt_tranquil"),
                                style: TextStyle(
                                    color: Constants.grey(context),
                                    fontSize: Constants.l(context),
                                    fontWeight: Constants.bolder))
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: Constants.a7(context),
                                bottom: Constants.a3(context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/park.svg',
                                    color: Constants.grey(context), height: 150)
                              ],
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  AppLocalizations.of(context).translate(
                                          "Inicia_un_xat_amb_un_dels_teus") +
                                      "\n" +
                                      AppLocalizations.of(context).translate(
                                          "contactes_polsant_el_botó_inferior"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Constants.grey(context),
                                      fontSize: Constants.l(context),
                                      fontWeight: Constants.bolder))
                            ]),
                      ],
                    )),
              ])));
    }
  }
}
