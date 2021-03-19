import 'package:app/defaults/constants.dart';
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: Constants.h2(context),
                        left: Constants.h2(context)),
                    child: Column(
                      children: [
                        Text(
                          'Hello',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: Constants.h2(context),
                        left: Constants.h2(context)),
                    child: Column(
                      children: [
                        Text(
                          'Hello',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
