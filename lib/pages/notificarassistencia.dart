import 'package:flutter/material.dart';

class Notificarassistencia extends StatefulWidget {
  Notificarassistencia({Key key}) : super(key: key);

  //final String title;

  @override
  _Notificarassistencia createState() => _Notificarassistencia();
}

class _Notificarassistencia extends State<Notificarassistencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Notificar assistència'),
        actions: [
          IconButton(icon: const Icon(Icons.check_rounded), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
