import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home',
            ),
          ],
        ),
      ),
    );
  }
}
