import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
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
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [
    Message(messageContent: "Hello", owner: false),
  ];
  IO.Socket socket;
  dynamic chatRoomId;
  bool isConected = false;
  String currentUserId;

  void sendMessage() {
    socket.emit('message', {
      'chatRoom': chatRoomId.toString(),
      'author': currentUserId,
      'message': textController.text.toString()
    });
  }

  void handleMessage(dynamic data) {
    setState(() {
      messages.add(Message(
          messageContent: textController.text.toString(),
          owner: data[1].toString() == currentUserId ? true : false));
      if (messages.length > 4) {
        _scrollController.animateTo(
          messages.length.toDouble() * 70.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 700),
        );
      }
      textController.clear();
    });
    print(data[2].toString());
  }

  void handleJoin(dynamic data) {
    chatRoomId = data;
    isConected = true;
    print(chatRoomId);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentUserId =
        SecureStorage.readSecureStorage('SafetyOUT_UserId').toString();
    try {
      socket = IO.io('https://safetyout.herokuapp.com/',
          OptionBuilder().setTransports(['websocket']).build());
      socket.onConnect((_) {
        print('connect');
        socket.emit('join', {
          'user1_id': currentUserId,
          'user2_id': '609116e842fa750022ab15b7'
        });
      });
      socket.on('joined', (data) => handleJoin(data));
      socket.on('message', (data) => handleMessage(data));
    } catch (e) {
      print(e.toString());
    }
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
          title: Text("Nom d'usuari"),
          actions: [IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})],
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 50),
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    width: 80,
                    height: 80,
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                    child: Align(
                        alignment: (messages[index].owner == false
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                //border: Border.all(color: Colors.black),
                                color: (messages[index].owner == false
                                    ? Constants.white(context)
                                    : Constants.green(context))),
                            padding: EdgeInsets.all(10),
                            child: Text(messages[index].messageContent,
                                style: TextStyle(
                                    fontSize: Constants.s(context))))));
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color: Constants.trueWhite(context),
                    width: 500,
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0, bottom: 15.0, right: 10.0),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: TextField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .translate("Escriu_un_missatge"),
                                      contentPadding:
                                          const EdgeInsets.only(left: 20.0),
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      filled: true,
                                      fillColor: Constants.lightGrey(context),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: FloatingActionButton(
                                onPressed: () => setState(() => sendMessage()),
                                child: Icon(
                                  Icons.send,
                                  color: Constants.grey(context),
                                  size: 25,
                                ),
                                backgroundColor: Constants.lightGrey(context),
                                elevation: 0,
                              ),
                            )),
                      ],
                    )))
          ],
        ));
  }
}
