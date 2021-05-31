import 'dart:convert';
//import 'dart:html';

import 'package:app/defaults/constants.dart';
import 'package:app/storage/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:app/models/chatModel.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;

import '../app_localizations.dart';
import 'configBombolla.dart';
import 'contactes.dart';

class ConversaBubble extends StatefulWidget {
  ConversaBubble({Key key, @required this.BubbleId, this.UserId})
      : super(key: key);
  final String BubbleId;
  final String UserId;
  @override
  _ConversaBubble createState() => _ConversaBubble(this.BubbleId, this.UserId);
}

class _ConversaBubble extends State<ConversaBubble> {
  _ConversaBubble(this.bubbleId, this.userId);
  final String bubbleId;
  final String userId;
  final textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Contacts> members = [];
  List<Message> messages = [];

  void getMembersInfo() {}

  Function deleteChat(context, String algo) {}

  void sendMessage() {
    messages.add(
        Message(messageContent: textController.text.toString(), owner: false));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getMembersInfo();
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
          title: Text("Xat de la bombolla"),
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ConfigBubble(BubbleId: bubbleId, UserId: userId)));
              },
            ),
            IconButton(icon: Icon(Icons.delete), onPressed: () {})
          ],
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
                        child: messages[index].owner == true
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    //border: Border.all(color: Colors.black),
                                    color: (messages[index].owner == false
                                        ? Constants.white(context)
                                        : Constants.green(context))),
                                padding: EdgeInsets.all(10),
                                child: Text(messages[index].messageContent,
                                    style: TextStyle(
                                        color: (messages[index].owner == false
                                            ? Constants.black(context)
                                            : Colors.black),
                                        fontSize: Constants.s(context))))
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    //border: Border.all(color: Colors.black),
                                    color: (messages[index].owner == false
                                        ? Constants.white(context)
                                        : Constants.green(context))),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text("Joel",
                                          style: TextStyle(
                                              color: Constants.black(context),
                                              fontSize: Constants.s(context),
                                              fontWeight: Constants.bolder)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                          messages[index].messageContent,
                                          style: TextStyle(
                                              color: Constants.black(context),
                                              fontSize: Constants.s(context))),
                                    ),
                                  ],
                                ) /*Text(messages[index].messageContent,
                                style: TextStyle(
                                    color: (messages[index].owner == false
                                        ? Constants.black(context)
                                        : Colors.black),
                                    fontSize: Constants.s(context)))*/
                                )
                        /*Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            //border: Border.all(color: Colors.black),
                            color: (messages[index].owner == false
                                ? Constants.white(context)
                                : Constants.green(context))),
                        padding: EdgeInsets.all(10),
                        child: Text(messages[index].messageContent,
                            style: TextStyle(
                                color: (messages[index].owner == false
                                    ? Constants.black(context)
                                    : Colors.black),
                                fontSize: Constants.s(context))))*/
                        ));
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
