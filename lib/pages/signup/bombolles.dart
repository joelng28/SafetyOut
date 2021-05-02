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
    return Expanded(
      child: ListView(
        children: [
          Text('Bombolles'),
        ],
      ),
    );
  }
}
