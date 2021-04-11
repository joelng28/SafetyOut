import 'dart:convert';
import 'dart:math';

import 'package:app/defaults/constants.dart';
import 'package:app/theme_mode_handler.dart';
import 'package:app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../app_localizations.dart';

class Home extends StatefulWidget {
  Home({Key key, this.mapPressed}) : super(key: key);

  final Function() mapPressed;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  bool firstLocation = false;
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  GoogleMapController controller;
  String address = '';
  LatLng initialcameraposition = LatLng(20.5937, 78.9629);
  LatLng lastLatLng = LatLng(20.5937, 78.9629);
  Location location = Location();
  final Map<String, Marker> markers = {};

  Future<void> onMapCreated(GoogleMapController cntlr) async {
    String mapStyle;
    String theme = await ThemeModeManager().loadThemeMode();
    if (theme != null) {
      mapStyle = theme == 'ThemeMode.light'
          ? await rootBundle.loadString('assets/map_styles/light.json')
          : await rootBundle.loadString('assets/map_styles/dark.json');
    } else {
      mapStyle = MediaQuery.of(context).platformBrightness == Brightness.light
          ? await rootBundle.loadString('assets/map_styles/light.json')
          : await rootBundle.loadString('assets/map_styles/dark.json');
    }

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
    controller = cntlr;
    location.onLocationChanged.listen((LocationData l) {
      controller
          .animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 18),
            ),
          )
          .catchError((error) {});
    });
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
          );
          markers[place["name"]] = marker;
        });
        Geocoder.local
            .findAddressesFromCoordinates(Coordinates(l.latitude, l.longitude))
            .then((addresses) {
          Address newAddress = addresses.first;
          address = newAddress.locality.toString() +
              ', ' +
              newAddress.adminArea.toString() +
              ', ' +
              newAddress.countryName.toString();
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
        Geocoder.local
            .findAddressesFromCoordinates(Coordinates(l.latitude, l.longitude))
            .then((addresses) {
          Address newAddress = addresses.first;
          address = newAddress.locality.toString() +
              ', ' +
              newAddress.adminArea.toString() +
              ', ' +
              newAddress.countryName.toString();
        });
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
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Constants.white(context),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeModeHandler.of(context).themeMode ==
                            ThemeMode.light
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              width: Constants.wFull(context),
              height: Constants.a13(context),
              child: Stack(
                children: [
                  firstLocation
                      ? GoogleMap(
                          zoomGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          rotateGesturesEnabled: false,
                          initialCameraPosition: firstLocation
                              ? CameraPosition(
                                  target: initialcameraposition, zoom: 18)
                              : CameraPosition(target: initialcameraposition),
                          mapType: MapType.normal,
                          onMapCreated: onMapCreated,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          onTap: (LatLng lng) {
                            widget.mapPressed();
                          },
                          markers: markers.values.toSet(),
                          onCameraMove: (CameraPosition newCamPos) {
                            LatLng movingCamPos = newCamPos.target;
                            setState(() {
                              if (pow(
                                          movingCamPos.latitude -
                                              lastLatLng.latitude,
                                          2) >=
                                      0.0001000100000 ||
                                  pow(
                                          movingCamPos.longitude -
                                              lastLatLng.longitude,
                                          2) >=
                                      0.0001000100000) {
                                lastLatLng = movingCamPos;
                                retrievePlaces(movingCamPos);
                              }
                            });
                          },
                        )
                      : Center(
                          child: SpinKitFadingCube(
                              color: Colors.white,
                              size: 40.0 /
                                  (MediaQuery.of(context).size.height < 700
                                      ? 1.3
                                      : MediaQuery.of(context).size.height < 800
                                          ? 1.15
                                          : 1)),
                        ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Constants.v3(context),
                        right: Constants.h6(context),
                        left: Constants.h6(context)),
                    child: Container(
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
                        child: Container(
                          child: LocationInput(
                            text: address,
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Constants.v4(context),
                  left: Constants.h6(context),
                  right: Constants.h6(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Restriccions',
                      style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.xl(context),
                          fontWeight: Constants.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
