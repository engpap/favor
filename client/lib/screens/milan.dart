import 'package:google_maps_flutter/google_maps_flutter.dart';

class District {
  String name;
  double lat;
  double lng;
  late CameraPosition cameraPos = CameraPosition(target: LatLng(lat, lng), zoom: 15);
  District(this.name, this.cameraPos, this.lat, this.lng);
}

//District
