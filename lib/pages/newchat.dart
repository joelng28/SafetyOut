import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class NewChat extends StatefulWidget {
  NewChat({Key key}) : super(key: key);

  @override
  _NewChat createState() => _NewChat();
}

class _NewChat extends State<NewChat> {
  /*@override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(AppLocalizations.of(context).translate("Iniciar_xat")),
      ),
    );
  }
}
