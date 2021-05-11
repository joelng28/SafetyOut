import 'package:app/defaults/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bubbles extends StatefulWidget {
  Bubbles({Key key}) : super(key: key);

  @override
  _Bubbles createState() => _Bubbles();
}

class _Bubbles extends State<Bubbles> {
  List<String> Pomp = ['Bubble1', 'Bubble2'];
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, index) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Image(
                image: AssetImage('icons/bubbles.svg'),
                color: Constants.black(context),
                width: Constants.xxl(context),
                height:Constants.xxl(context),
              ),
              Expanded(
                child: Text(Pomp[index])
              )
            ]
            
          ),
        separatorBuilder: (_, __) => Divider(),
        itemCount: Pomp.length,
      ),
    );
  }
}

