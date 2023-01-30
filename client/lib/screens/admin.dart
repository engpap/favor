import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/statistics.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'milan.dart';
import 'milan.dart' as milan;
import 'package:project/functions/favorColors.dart' as favorColors;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: CupertinoPageScaffold(
            backgroundColor: Colors.white,
            child: SafeArea(
              child: ResponsiveLeayout(
                mobileBody: AdminScreen_M(),
                tabletBody: AdminScreen_M(),
              ),
            )));
  }
}

class AdminScreen_M extends StatefulWidget {
  const AdminScreen_M({super.key});

  @override
  State<AdminScreen_M> createState() => _AdminScreen_MState();
}

class _AdminScreen_MState extends State<AdminScreen_M> {
  Set<Marker> _markers = {};

  late final GoogleMapController _googleMapController;
  late Future<Statistics?> statistics;

  CameraPosition _cameraPosition = milan.Duomo.cameraPos;

  Marker provaMarker = Marker(
      markerId: MarkerId("Marker di prova"),
      position: milan.Duomo.cameraPos.target,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(
        title: milan.Duomo.name,
        snippet: "snip",
      ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_markers.add(provaMarker);
    statistics = Provider.of<AppProvider>(context).getStatistics(context);
    print(statistics);
  }

  Future<void> _moveToDuomo() async {
    _googleMapController
        .animateCamera(CameraUpdate.newLatLng(_cameraPosition.target));
    setState(() {
      //_markers..clear(); //..add(provaMarker);
    });
    print(statistics);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Expanded(
          child: Container(
            child: Stack(
              children: [
                // MAP
                GoogleMap(
                  myLocationButtonEnabled: false,
                  minMaxZoomPreference: MinMaxZoomPreference(12, 15),
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: (controller) {
                    _googleMapController = controller;
                    _googleMapController.setMapStyle(milan.mapStyle);
                  },
                  initialCameraPosition: _cameraPosition,
                  mapType: MapType.normal,
                  markers: _markers,
                ),
                // BUTTONS
                Container(
                  padding: EdgeInsets.all(9),
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: _moveToDuomo,
                        backgroundColor: favorColors.PrimaryBlue,
                        child: const Icon(
                          Icons.location_city,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        //
        Container(
          height: 100,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<Statistics?>(
                    future: statistics,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        for (MapEntry<String, int> entry in snapshot.data!.stats.entries) {
                          print('${entry.key}: ${entry.value}');
                          
                          Marker? marker = newFavorMarker(entry.key, entry.value);
                          if (marker != null) _markers..add(marker);
                        }
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.stats.length,
                          itemBuilder: (context, index) {
                            var key = snapshot.data!.stats.keys.toList()[index];
                            return Text('${key}: ${snapshot.data!.stats[key]}');
                          });
              
                      } else
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.red,
                        );
                    })),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Marker? newFavorMarker(String location, int value) {
  // from String to District : where District.name == location
  District? district = getDistrictFromName(location);
  if (district != null) {
    return Marker(
        markerId: MarkerId(location),
        position: district.cameraPos.target,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: value.toString(),
          snippet: location,
        ));
  } else
    return null;
}
