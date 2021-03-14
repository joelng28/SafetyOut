import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  Discover({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Discover createState() => _Discover();
}

class _Discover extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Discover',
            ),
          ],
        ),
      ),
    );
  }
}
