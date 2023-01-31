import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/screens/admin.dart';

import '../main_test.dart';

void main() {
  testWidgets("AdminScreen UI Test", (tester) async {
    await tester.pumpWidget(getWidgetToTest(AdminScreen()));
    await tester.pumpAndSettle();
    // Check if GoogleMap widget exists
    expect(find.byType(GoogleMap), findsOneWidget);

    // Check if Log Out button exists
    expect(find.byKey(Key("log_out_button_floating")), findsOneWidget);

    // Check if center_map_button exists
    await tester.ensureVisible(find.byKey(Key("center_map_button")));
    expect(find.byKey(Key("center_map_button")), findsOneWidget);

    // Check if favor logo is shown
    expect(find.byKey(Key("logo_container")), findsOneWidget);

    // Check if at least a legend returned by server is shown
    expect(find.byKey(Key("legend_LORETO")), findsOneWidget);
  });
}
