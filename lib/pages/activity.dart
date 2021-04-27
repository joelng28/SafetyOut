import 'package:app/defaults/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Activity extends StatefulWidget {
  Activity(this.placeName, this.time, this.placeGauge,
      {Key key /*, this.title*/})
      : super(key: key);

  final String placeName;
  final DateTime time;
  final int placeGauge;

  @override
  _Activity createState() =>
      _Activity(this.placeName, this.time, this.placeGauge);
}

class _Activity extends State<Activity> {
  _Activity(this.placeName, this.time, this.placeGauge);
  final String placeName;
  final DateTime time;
  final int placeGauge;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Constants.v2(context)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(children: [
              Text("Lloc",
                  style: TextStyle(
                    color: Constants.black(context),
                    fontSize: Constants.m(context),
                  )),
            ]),
            Column(children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Icon(
                  Icons.more_horiz,
                  size: Constants.xxl(context),
                  color: Constants.black(context),
                ),
                onTap: () {},
              )
            ])
          ]),
        ),
        Padding(
            padding: EdgeInsets.only(
                right: Constants.h3(context), top: Constants.v1(context)),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  size: Constants.xxl(context),
                  color: Constants.black(context),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Constants.h1(context)),
                  child: Text("Hora",
                      style: TextStyle(
                        color: Constants.black(context),
                        fontSize: Constants.s(context),
                      )),
                ),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(
                top: Constants.v1(context), right: Constants.h3(context)),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/group.svg',
                    color: Constants.black(context),
                    height: Constants.xxl(context),
                    width: Constants.xxl(context)),
                Padding(
                    padding: EdgeInsets.only(left: Constants.h1(context)),
                    child: Text("Moltes/poques persones",
                        style: TextStyle(
                          color: Constants.black(context),
                          fontSize: Constants.s(context),
                        ))),
              ],
            )),
      ],
    );
  }
}
