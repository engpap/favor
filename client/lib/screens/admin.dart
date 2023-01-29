import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/services/authService.dart';
import 'package:project/services/profileService.dart';

import 'package:project/functions/favorColors.dart' as favorColors;

import 'package:google_maps_flutter/google_maps_flutter.dart';



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

class AdminScreen_M extends StatelessWidget {
  const AdminScreen_M({super.key});

  static const double _defaultLat = 45.464211;
  static const double _defaultLng = 9.191383;

  static const CameraPosition _defaultLocation = CameraPosition(target: LatLng(_defaultLat, _defaultLng), zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      
      child: Stack(
        children: [
          GoogleMap(
          initialCameraPosition: _defaultLocation,
        ),]
      ),
      
    );
  }
}
