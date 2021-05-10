import 'package:app/defaults/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../app_localizations.dart';

class Chats extends StatefulWidget {
  Chats({Key key}) : super(key: key);

  @override
  _Chats createState() => _Chats();
}

class _Chats extends State<Chats> {
  @override
  void initState() {
    super.initState();
    IO.Socket socket = IO.io('https://safetyout.herokuapp.com/');
    socket.connect();
    socket.emit('join', {
      'user1_id': '6081a40d875b4b3864bd1f21',
      'user2_id': '609116e842fa750022ab15b7'
    });
    //socket.emit('message', {'chatRoom': })
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Nom d'usuari"),
        ),
        body: Center(
            child: Column(
          children: [
            /*Align(
                alignment: Alignment.bottomCenter,
                child: */
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .translate("Escriu_un_missatge"),
                          hintStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.green,
                    elevation: 0,
                  ),
                ),
              ],
            ) //)
          ],
        )));
  }
}
