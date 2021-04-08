import 'dart:convert';

import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

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
  }

  void getFirstLocation() {
    location.getLocation().then((l) {
      setState(() {
        var url = Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
                l.latitude.toString() +
                ',' +
                l.longitude.toString() +
                '&radius=15000&keyword=parc&key=AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA&fields=geometry,name,types,formatted_address');
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
            places.forEach((place) {
              final marker = Marker(
                markerId: MarkerId(place["name"]),
                position:
                    LatLng(place["location"]["lat"], place["location"]["lng"]),
                infoWindow: InfoWindow(
                  title: place["name"],
                ),
              );
              markers[place["name"]] = marker;
            });
          });
        }).catchError((error) => print(error));
        var url2 = Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
                l.latitude.toString() +
                ',' +
                l.longitude.toString() +
                '&radius=15000&keyword=nature&key=AIzaSyALjO4lu3TWJzLwmCWBgNysf7O1pgje1oA&fields=geometry,name,types,formatted_address');
        http.get(url2).then((res) {
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
            places.forEach((place) {
              final marker = Marker(
                markerId: MarkerId(place["name"]),
                position:
                    LatLng(place["location"]["lat"], place["location"]["lng"]),
                infoWindow: InfoWindow(
                  title: place["name"],
                ),
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
        child: firstLocation
            ? GoogleMap(
                initialCameraPosition: firstLocation
                    ? CameraPosition(target: initialcameraposition, zoom: 18)
                    : CameraPosition(target: initialcameraposition),
                mapType: MapType.normal,
                onMapCreated: onMapCreated,
                myLocationEnabled: true,
                markers: markers.values.toSet(),
              )
            : Container(
                decoration: BoxDecoration(color: Constants.lightGrey(context)),
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
      ),
/*       floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ), */
    );
  }
}
