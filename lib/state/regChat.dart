import 'package:flutter/material.dart';

class RegChat extends ChangeNotifier {
  String id = '';

  String get getId => id;

  void setId(String id) {
    this.id = id;
  }
}
