import 'package:flutter/material.dart';
import 'package:project/models/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/favor_information_page/favorInformationPage.dart';

import '../../main_test.dart';
import '../../utility_for_testing/mocks/dummy_models.dart';

void main() {
  testWidgets('Test FavorInformation Widget', (WidgetTester tester) async {
    // Create a sample post for testing
    // Build the widget and attach it to the tester
    await tester.pumpWidget(getWidgetToTest(FavorInformationPageScreen(
        post: dummy_caller_post, userType: "caller")));

    // Check if FavorPerson is built
    expect(find.byType(FavorPerson), findsOneWidget);

    // Check if the text values match
    expect(find.textContaining(dummy_caller_post.name!), findsOneWidget);
    expect(find.textContaining(dummy_caller_post.surname!), findsOneWidget);
    expect(find.textContaining(dummy_caller_post.email!), findsOneWidget);
    expect(find.textContaining(dummy_caller_post.description), findsOneWidget);
    // Number of widgets cotianing the location are:
    // - 1 if the user does not appear in the location's leaderboard
    // - 2 if the user is in the location's leaderboard
    expect(find.textContaining(dummy_caller_post.location),
        findsAtLeastNWidgets(1));

    // Check if Book it button is built
    expect(find.byType(BookFavorButton), findsOneWidget);
  });
}
