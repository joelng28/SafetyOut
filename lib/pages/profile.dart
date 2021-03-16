import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key /*, this.title*/}) : super(key: key);

  //final String title;

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
