import 'package:flutter/cupertino.dart';

class Contact {
  String destUserId;
  String name;
  String lastMessage;
  Contact({this.destUserId, @required this.name, this.lastMessage});
}
