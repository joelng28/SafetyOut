import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  Contacts({Key key}) : super(key: key);

  @override
  _Contacts createState() => _Contacts();
}

class _Contacts extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Text('Contactes')),
    );
  }
}
