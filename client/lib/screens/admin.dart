import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/statistics.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'milan.dart';
import 'package:project/screens/milan.dart' as milan;
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
            backgroundColor: Color.fromARGB(255, 245, 245, 245),
            child: SafeArea(
              child: ResponsiveLayout(
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

  // initial state of camera position: Duomo
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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    statistics = Provider.of<AppProvider>(context).getStatistics(context);
    print(statistics);
  }

  Future<void> _moveToDuomo() async {
    _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
        _cameraPosition.target, _cameraPosition.zoom));
    setState(() {});
    print(statistics);
  }

  Future<void> _moveTo(String districtName) async {
    District district = milan.setDistricts
        .singleWhere((element) => equalsIgnoreCase(element.name, districtName));
    _googleMapController.animateCamera(
        CameraUpdate.newLatLngZoom(district.cameraPos.target, district.zoom));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
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
                      // LOG OUT
                      FloatingActionButton(
                        key: Key("log_out_button_floating"),
                        heroTag: null,
                        onPressed: (() {
                          Provider.of<AppProvider>(context, listen: false)
                              .signout(context: context);
                        }),
                        backgroundColor: favorColors.Error,
                        child: const Icon(
                          Icons.exit_to_app,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // CENTER MAP
                      FloatingActionButton(
                        key: Key("center_map_button"),
                        heroTag: null,
                        onPressed: _moveToDuomo,
                        backgroundColor: favorColors.PrimaryBlue,
                        child: const Icon(
                          Icons.location_city,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
                // LOGO FAVOR
                Container(
                  key: Key("logo_container"),
                  padding: EdgeInsets.all(9),
                  alignment: Alignment.topLeft,
                  height: Responsive.heightFixOver(80, 20, context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: Responsive.widthFixOver(70, 25, context),
                        height: Responsive.heightFixOver(70, 18, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo/logo.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // LEGEND
        Container(
          height: 90,
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder<Statistics?>(
                    future: statistics,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        for (MapEntry<String, int> entry
                            in snapshot.data!.stats.entries) {
                          print('${entry.key}: ${entry.value}');

                          Marker? marker =
                              newFavorMarker(entry.key, entry.value);
                          if (marker != null) _markers..add(marker);
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.stats.length,
                            itemBuilder: (context, index) {
                              var key =
                                  snapshot.data!.stats.keys.toList()[index];
                              return buildLegend(context, key,
                                  snapshot.data!.stats[key].toString());
                            });
                      } else
                        // If error
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

  Widget buildLegend(BuildContext context, String district, value) {
    return Container(
      key: Key("legend_${district}"),
      child: CustomCard(
          padding: EdgeInsets.zero,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(favorColors.IntroBg),
              foregroundColor:
                  MaterialStateProperty.all<Color>(favorColors.PrimaryBlue),
              overlayColor:
                  MaterialStateProperty.all<Color>(favorColors.SecondaryBlue),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            onPressed: () {
              _moveTo(district);
            },
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    district,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.widthFixOver(18, 5, context),
                      color: favorColors.PrimaryBlue,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("completed: ${value}"),
                ],
              ),
            ),
          )),
    );
  }
}

Marker? newFavorMarker(String location, int value) {
  District? district = getDistrictFromName(location);
  if (district != null) {
    return Marker(
        markerId: MarkerId(location),
        position: district.cameraPos.target,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(
          title: value.toString(),
          snippet: location,
        ));
  } else
    return null;
}
