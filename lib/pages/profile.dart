import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Icono configuracion
                  IconButton(
                    icon: const Icon(Icons.settings),
                    color: Constants.black(context),
                    iconSize: Constants.xxl(context),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: Constants.h2(context),
                        left: Constants.h2(context)),
                    child: Column(
                      children: [
                        //Imagen perfil
                        new Container(
                          width: Constants.w10(context),
                          height: Constants.a10(context),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill, image: new NetworkImage(
                                      //Imagen de prueba, se colocará la imagen del usuario
                                      "https://i.imgur.com/BoN9kdC.png"))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: Constants.h2(context),
                        left: Constants.h2(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: Constants.h2(context),
                              left: Constants.h2(context)),
                          child: Row(
                            children: [
                              //Nombre usuario
                              Text(
                                'Joel Navarro',
                                style: TextStyle(
                                  fontSize: Constants.xxl(context),
                                  fontWeight: Constants.bolder,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: Constants.h2(context),
                              left: Constants.h2(context)),
                          child: Row(
                            children: [
                              //Boton editar perfil
                              ElevatedButton(
                                child: Text(
                                  'Editar Perfil',
                                  style: TextStyle(
                                    fontWeight: Constants.bolder,
                                  ),
                                ),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: Constants.white(context),
                                    textStyle: TextStyle(
                                      color: Constants.black(context),
                                    ),
                                    side: BorderSide(
                                        color: Constants.black(context)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
