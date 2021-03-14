import 'package:app/app_localizations.dart';
import 'package:app/pages/calendar.dart';
import 'package:app/pages/discover.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  App({Key key /*, this.title*/}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _App createState() => _App();
}

class _App extends State<App> {
    int index = 0;

    static List<Widget> pantalles = <Widget>[
      Home(),
      Discover(),
      Calendar(),
      Profile(),
    ];

  void onItemTapped(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: pantalles.elementAt(index)
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 45 / (MediaQuery.of(context).size.width < 380 ? 1.3 : 1),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,
              color: Colors.black,),
              label: "Home",
              activeIcon: Icon(Icons.home,
              color: Colors.black,),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.compass,
              color: Colors.black,),
              label: "Discover",
              activeIcon: Icon(CupertinoIcons.compass_fill,
              color: Colors.black,),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined,
              color: Colors.black,),
              label: "Calendar",
              activeIcon: Icon(Icons.calendar_today,
              color: Colors.black,),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person,
              color: Colors.black,),
              label: "Profile",
              activeIcon: Icon(CupertinoIcons.person_fill,
              color: Colors.black,),
            ),
          ],
          currentIndex: index,
          onTap: onItemTapped,
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
