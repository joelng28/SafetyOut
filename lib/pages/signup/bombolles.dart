import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bubbles extends StatefulWidget {
  Bubbles({Key key}) : super(key: key);

  @override
  _Bubbles createState() => _Bubbles();
}

class _Bubbles extends State<Bubbles> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Text('Bombolles')),
    );
  }
}
