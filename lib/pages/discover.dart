import 'dart:convert';
import 'dart:math';

import 'package:app/defaults/constants.dart';
import 'package:app/pages/consultaraforament.dart';
import 'package:app/widgets/border_button.dart';
import 'package:app/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  bool viewPlace = false;
  String placeName = 'Nom';
  String placeLocation = 'Ciutat, Comarca, País';
  String placeAddress = 'Adreça';
  String placeOpenHours = 'Horari';
  String placeGauge = 'Aforament';

  Future<void> onMapCreated(GoogleMapController cntlr) async {
    controller = cntlr;
    String mapStyle;
    Brightness theme = MediaQuery.of(context).platformBrightness;
    if (theme != null) {
      mapStyle = theme == Brightness.light
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
  }

  void retrievePlaces(LatLng l) {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            l.latitude.toString() +
            ',' +
            l.longitude.toString() +
            '&radius=5000&keyword=park|nature|sightseeing|public|terrace|mountain|castle&key=AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA&fields=geometry,name');
    var urlRes = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            l.latitude.toString() +
            ',' +
            l.longitude.toString() +
            '&radius=5000&keyword=outdoor seating&key=AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA&fields=geometry,name');
    Future.wait([http.get(url), http.get(urlRes)]).then((List responses) {
      List<Map<String, dynamic>> places = [];
      Map<String, dynamic> body = jsonDecode(responses[0].body);
      List<dynamic> results = body["results"];
      results.forEach((element) {
        Map<String, dynamic> place = {
          "location": element["geometry"]["location"],
          "name": element["name"]
        };
        places.add(place);
      });
      body = jsonDecode(responses[1].body);
      results = body["results"];
      results.forEach((element) {
        Map<String, dynamic> place = {
          "location": element["geometry"]["location"],
          "name": element["name"]
        };
        places.add(place);
      });
      setState(() {
        markers.clear();
        places.forEach((place) {
          final marker = Marker(
              markerId: MarkerId(place["name"]),
              anchor: Offset(0, -1),
              icon: BitmapDescriptor.defaultMarker,
              position:
                  LatLng(place["location"]["lat"], place["location"]["lng"]),
              onTap: () {
                //Llamada a la api buscando con la lat y lng
                // placeName = el nombre que te retorne
                // placeLocation = Ciutat, Comarca, País que te retorne como esta hecho en la pagina home
                // placeAddress = la dirección que te retorne
                // placeOpenHours = los horarios que te retorne
                // placeGauge = esto de momento nada
                setState(() {
                  viewPlace = true;
                });
                controller
                    .animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(place["location"]["lat"],
                                place["location"]["lng"]),
                            zoom: 18)))
                    .catchError((error) {});
              });
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
                    onTap: (lat) {
                      setState(() {
                        viewPlace = false;
                      });
                    },
                    initialCameraPosition: firstLocation
                        ? CameraPosition(
                            target: initialcameraposition, zoom: 18)
                        : CameraPosition(target: initialcameraposition),
                    mapType: MapType.normal,
                    onMapCreated: onMapCreated,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
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
                      child: Row(
                        children: [
                          SearchInput(
                            labelText: 'Cerca un espai obert',
                          ),
                        ],
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
            ),
            GestureDetector(
              onTap: () {},
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Constants.trueWhite(context),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  boxShadow: viewPlace
                      ? [
                          BoxShadow(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? Colors.black.withOpacity(0.3)
                                : Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 8), // changes position of shadow
                          ),
                        ]
                      : [],
                ),
                constraints: BoxConstraints(
                  maxHeight: viewPlace ? MediaQuery.of(context).size.height : 0,
                ),
                width: Constants.wFull(context),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Constants.v2(context),
                      left: Constants.h6(context),
                      right: Constants.h6(context)),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              placeName,
                              style: TextStyle(
                                  fontSize: Constants.l(context),
                                  fontWeight: Constants.bolder),
                            ),
                            InkWell(
                              child: Icon(Icons.close,
                                  size: Constants.xxl(context),
                                  color: Constants.black(context)),
                              onTap: () {
                                setState(() {
                                  viewPlace = false;
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          placeLocation,
                          style: TextStyle(
                              fontSize: Constants.m(context),
                              fontWeight: Constants.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Constants.v3(context)),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/placeholder.svg',
                                  color: Constants.black(context),
                                  height: Constants.xxl(context),
                                  width: Constants.xxl(context)),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Constants.h1(context)),
                                child: Text(
                                  placeName,
                                  style: TextStyle(
                                      fontSize: Constants.s(context),
                                      fontWeight: Constants.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Constants.v1(context)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: Constants.xxl(context),
                                color: Constants.black(context),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Constants.h1(context)),
                                child: Text(
                                  placeOpenHours,
                                  style: TextStyle(
                                      fontSize: Constants.s(context),
                                      fontWeight: Constants.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Constants.v1(context)),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/group.svg',
                                  color: Constants.black(context),
                                  height: Constants.xxl(context),
                                  width: Constants.xxl(context)),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Constants.h1(context)),
                                child: Text(
                                  placeGauge,
                                  style: TextStyle(
                                      fontSize: Constants.s(context),
                                      fontWeight: Constants.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Constants.v3(context),
                              bottom: Constants.v4(context)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  constraints: BoxConstraints(
                                      minWidth: Constants.w10(context),
                                      maxWidth: Constants.w11(context)),
                                  child: BorderButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  ConsultarAforament()),
                                        );
                                      },
                                      text: 'Veure més')),
                              Container(
                                  constraints: BoxConstraints(
                                      minWidth: Constants.w10(context),
                                      maxWidth: Constants.w11(context)),
                                  child: BorderButton(
                                      onPressed: () {}, text: 'Vull anar-hi')),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          elevation: 10,
          backgroundColor: Constants.trueWhite(context),
          onPressed: () {
            location.getLocation().then((loc) {
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(loc.latitude, loc.longitude), zoom: 18)))
                  .catchError((error) {});
              retrievePlaces(LatLng(loc.latitude, loc.longitude));
            });
            setState(() {
              viewPlace = false;
            });
          },
          child: Icon(
            Icons.location_searching,
            color: Constants.black(context),
          )),
    );
  }
}
