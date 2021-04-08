import 'dart:convert';

import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

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
  LatLng initialcameraposition = LatLng(20.5937, 78.9629);
  Location location = Location();
  final Map<String, Marker> markers = {};

  Future<void> onMapCreated(GoogleMapController cntlr) async {
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
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 18),
        ),
      );
    });
  }

  void getFirstLocation() {
    //AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA
    location.getLocation().then((l) {
      setState(() {
        var url = Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
                l.latitude.toString() +
                ',' +
                l.longitude.toString() +
                '&radius=1500&type=restaurant&key=AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA&fields=geometry,name,types,formatted_address');
        http.get(url).then((res) {
          Map<String, dynamic> body = jsonDecode(res.body);
          List<dynamic> results = body["results"];
          List<Map<String, dynamic>> places = [];
          results.forEach((element) {
            Map<String, dynamic> place = {
              "location": element["geometry"]["location"],
              "name": element["name"],
              "types": element["types"],
            };
            places.add(place);
          });
          print(places);
          setState(() {
            markers.clear();
            places.forEach((place) {
              final marker = Marker(
                markerId: MarkerId(place["name"]),
                position:
                    LatLng(place["location"]["lat"], place["location"]["lng"]),
              );
              markers[place["name"]] = marker;
            });
          });
        }).catchError((error) => print(error));
        initialcameraposition = LatLng(l.latitude, l.longitude);
        firstLocation = true;
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
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Constants.lightGrey(context),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black,
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 8), // changes position of shadow
              ),
            ],
          ),
          width: Constants.wFull(context),
          height: Constants.a14(context),
          child: firstLocation
              ? GoogleMap(
                  zoomGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  initialCameraPosition: firstLocation
                      ? CameraPosition(target: initialcameraposition, zoom: 18)
                      : CameraPosition(target: initialcameraposition),
                  mapType: MapType.normal,
                  onMapCreated: onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onTap: (LatLng lng) {
                    widget.mapPressed();
                  },
                  markers: markers.values.toSet(),
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
        ),
      ),
    );
  }
}
