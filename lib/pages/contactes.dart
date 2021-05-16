import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  Contacts({Key key}) : super(key: key);

  @override
  _Contacts createState() => _Contacts();
}

class _Contacts extends State<Contacts> {
  List<String> Contactos = ['Contacto1', 'Contacto2'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          Expanded(child: Text(Contactos[index]))
        ]),
        separatorBuilder: (_, __) => Divider(),
        itemCount: Contactos.length,
      ),
    );
  }
}
