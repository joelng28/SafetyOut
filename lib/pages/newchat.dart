import 'package:app/defaults/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/models/contactChat.dart';

import '../app_localizations.dart';
import 'conversa.dart';

class NewChat extends StatefulWidget {
  NewChat({Key key}) : super(key: key);

  @override
  _NewChat createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  List<Contact> contacts = [
    Contact(name: 'Joel'),
    Contact(name: 'Joel2'),
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
    return Scaffold(
        appBar: AppBar(
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
                      fontWeight: Constants.bolder,
                      fontSize: Constants.l(context)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Conversa()));
                },
              ));
              /*Column(children: [
                Row(children: [Text(contacts[index].name)]),
                Row(children: [Text("Hola que tal")]),
              ]);*/
            },
          )
        ]));
  }
}
