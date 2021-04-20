import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Attendance {
  String user_id;
  String latitud;
  String longitud;
  DateTime fecha;
  int duracion;

  String get getPlace{  
    return null;
  }

  DateTime get getFechaInicial => fecha;
  DateTime get getFechaFinal => fecha;

  void setFechaInicial(DateTime f){
    fecha = f;
  }

  void setFechaFinal(DateTime f){
    fecha = f;
  }


}