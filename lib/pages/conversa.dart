import 'package:app/defaults/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:app/models/chatModel.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../app_localizations.dart';

class Conversa extends StatefulWidget {
  Conversa({Key key}) : super(key: key);

  @override
  _Conversa createState() => _Conversa();
}

class _Conversa extends State<Conversa> {
  final textController = TextEditingController();
  List<Message> messages = [
    Message(messageContent: "Hello", messageType: "receiver"),
  ];
  IO.Socket socket;
  dynamic id;
  bool isConected = false;

  void sendMessage() {
    /*socket.emit('message', {
      'chatRoom': id.toString(),
      'author': '6081a40d875b4b3864bd1f21',
      'message': textController.text.toString()
    });*/
    messages.add(Message(
        messageContent: textController.text.toString(), messageType: "sender"));
    textController.clear();
  }

  void handleJoin(dynamic data) {
    id = data;
    isConected = true;
    print(id);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    IO.Socket socket = IO.io('https://safetyout.herokuapp.com/',
        OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      print('connect');
      socket.emit('join', {
        'user1_id': '6081a40d875b4b3864bd1f21',
        'user2_id': '609116e842fa750022ab15b7'
      });
    });
    socket.on('joined', (data) => handleJoin(data));

    /*socket.emit('join', {
      'user1_id': '6081a40d875b4b3864bd1f21',
      'user2_id': '609116e842fa750022ab15b7'
    });*/
    //socket.emit('message', {'chatRoom': })
  }

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
          title: Text("Nom d'usuari"),
          actions: [IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})],
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                //border: Border.all(color: Colors.black),
                                color:
                                    (messages[index].messageType == "receiver"
                                        ? Constants.white(context)
                                        : Constants.green(context))),
                            padding: EdgeInsets.all(16),
                            child: Text(messages[index].messageContent,
                                style: TextStyle(
                                    fontSize: Constants.s(context))))));
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate("Escriu_un_missatge"),
                              hintStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: FloatingActionButton(
                        onPressed: () => setState(() => sendMessage()),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Constants.green(context),
                        elevation: 0,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
