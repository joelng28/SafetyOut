import 'dart:convert';
import 'dart:math';

import 'package:app/defaults/constants.dart';
import 'package:app/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../app_localizations.dart';

class Discover extends StatefulWidget {
  Discover({Key key}) : super(key: key);

  @override
  _Discover createState() => _Discover();
}

class _Discover extends State<Discover> {
  bool firstLocation = false;
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  GoogleMapController controller;
  LatLng initialcameraposition = LatLng(20.5937, 78.9629);
  LatLng lastLatLng = LatLng(20.5937, 78.9629);
  LatLng movingCamPos = LatLng(20.5937, 78.9629);
  Location location = Location();
  final Map<String, Marker> markers = {};

  Future<void> onMapCreated(GoogleMapController cntlr) async {
    final theme = WidgetsBinding.instance.window.platformBrightness;
    String mapStyle = theme == Brightness.light
        ? await rootBundle.loadString('assets/map_styles/light.json')
        : await rootBundle.loadString('assets/map_styles/dark.json');
    await cntlr.setMapStyle(mapStyle);

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void retrievePlaces(LatLng l) {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            l.latitude.toString() +
            ',' +
            l.longitude.toString() +
            '&radius=5000&keyword=park|nature|sightseeing|public|terrace|mountain|castle&key=AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA&fields=geometry,name,types,formatted_address');
    var urlRes = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            l.latitude.toString() +
            ',' +
            l.longitude.toString() +
            '&radius=5000&keyword=outdoor seating&key=AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA&fields=geometry,name,types,formatted_address');
    Future.wait([http.get(url), http.get(urlRes)]).then((List responses) {
      List<Map<String, dynamic>> places = [];
      Map<String, dynamic> body = jsonDecode(responses[0].body);
      List<dynamic> results = body["results"];
      results.forEach((element) {
        Map<String, dynamic> place = {
          "location": element["geometry"]["location"],
          "name": element["name"],
          "types": element["types"],
        };
        places.add(place);
      });
      body = jsonDecode(responses[1].body);
      results = body["results"];
      results.forEach((element) {
        Map<String, dynamic> place = {
          "location": element["geometry"]["location"],
          "name": element["name"],
          "types": element["types"],
        };
        places.add(place);
      });
      setState(() {
        markers.clear();
        places.forEach((place) {
          final marker = Marker(
            markerId: MarkerId(place["name"]),
            anchor: Offset(0, -1),
            position:
                LatLng(place["location"]["lat"], place["location"]["lng"]),
            infoWindow: InfoWindow(
              title: place["name"],
            ),
          );
          markers[place["name"]] = marker;
        });
      });
    }).catchError((error) => {});
  }

  void getFirstLocation() {
    location.getLocation().then((l) {
      initialcameraposition = LatLng(l.latitude, l.longitude);
      lastLatLng = initialcameraposition;
      firstLocation = true;
      setState(() {
        retrievePlaces(lastLatLng);
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate("Error de xarxa"),
                      style: TextStyle(fontSize: Constants.m(context))),
                ],
              )),
              actions: <Widget>[
                TextButton(
                  child: Text(
                      AppLocalizations.of(context).translate("Acceptar"),
                      style: TextStyle(color: Constants.black(context))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    });
  }

  @override
  void initState() {
    super.initState();
    getFirstLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            firstLocation
                ? GoogleMap(
                    initialCameraPosition: firstLocation
                        ? CameraPosition(
                            target: initialcameraposition, zoom: 18)
                        : CameraPosition(target: initialcameraposition),
                    mapType: MapType.normal,
                    onMapCreated: onMapCreated,
                    myLocationEnabled: true,
                    markers: markers.values.toSet(),
                    onCameraIdle: () {
                      setState(() {
                        if (pow(movingCamPos.latitude - lastLatLng.latitude,
                                    2) >=
                                0.0000000100000 ||
                            pow(movingCamPos.longitude - lastLatLng.longitude,
                                    2) >=
                                0.0000000100000) {
                          lastLatLng = movingCamPos;
                          retrievePlaces(movingCamPos);
                        }
                      });
                    },
                    onCameraMove: (CameraPosition newCamPos) {
                      movingCamPos = newCamPos.target;
                    },
                  )
                : Container(
                    decoration:
                        BoxDecoration(color: Constants.lightGrey(context)),
                    child: Center(
                      child: SpinKitFadingCube(
                          color: Colors.white,
                          size: 40.0 /
                              (MediaQuery.of(context).size.height < 700
                                  ? 1.3
                                  : MediaQuery.of(context).size.height < 800
                                      ? 1.15
                                      : 1)),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(
                  top: Constants.v3(context),
                  right: Constants.h6(context),
                  left: Constants.h6(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 5,
                            color: Color.fromARGB(100, 0, 0, 0),
                          )
                        ],
                      ),
                      child: SearchInput(
                        labelText: 'Cerca un espai obert',
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: Constants.v3(context)),
                    child: Container(
                        height: Constants.a7(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 5,
                              color: Color.fromARGB(100, 0, 0, 0),
                            )
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Suggerències',
                                  style: TextStyle(
                                      color: Constants.black(context),
                                      fontWeight: Constants.bold,
                                      fontSize: Constants.m(context))),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Constants.h1(context)),
                                child: Icon(FontAwesomeIcons.chevronDown,
                                    color: Constants.black(context),
                                    size: 24.0 /
                                        (MediaQuery.of(context).size.height <
                                                700
                                            ? 1.3
                                            : MediaQuery.of(context)
                                                        .size
                                                        .height <
                                                    800
                                                ? 1.15
                                                : 1)),
                              )
                            ],
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: Constants.v1(context),
                                      horizontal: Constants.h1(context))),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                              backgroundColor: MaterialStateProperty.all(
                                  Constants.trueWhite(context))),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
/*       floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ), */
    );
  }
}
