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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Image(
                image: AssetImage('icons/user.svg'),
                color: Constants.black(context),
                width: Constants.xxl(context),
                height:Constants.xxl(context),
              ),
              Expanded(
                child: Text(Contactos[index])
              )
            ]
            
          ),
        separatorBuilder: (_, __) => Divider(),
        itemCount: Contactos.length,
      ),
    );
  }
}
