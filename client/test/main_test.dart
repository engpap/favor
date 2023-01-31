import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/main.dart';

import 'package:project/providers/app_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/explore/providerExplore.dart';

import 'package:provider/provider.dart';
import 'utility_for_testing/mocks/services/admin_service_mock.dart';
import 'utility_for_testing/mocks/services/apis/google_calendar_api_wrapper_mock.dart';
import 'utility_for_testing/mocks/services/auth_service_mock.dart';
import 'utility_for_testing/mocks/services/constants_service_mock.dart';
import 'utility_for_testing/mocks/services/favor_service_mock.dart';
import 'utility_for_testing/mocks/services/leaderboard_service_mock.dart';
import 'utility_for_testing/mocks/services/post_service_mock.dart';
import 'utility_for_testing/mocks/services/profile_service_mock.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => AppProvider(
              AdminServiceMock(),
              AuthServiceMock(),
              ConstantsServiceMock(),
              FavorServiceMock(),
              LeaderboardServiceMock(),
              PostServiceMock(),
              ProfileServiceMock_Unauthorized(),
              GoogleCalendarApiWrapperMock(),
            )),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ExploreQuery())
  ], child: const MyApp()));
}

void mainAuth() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => AppProvider(
              AdminServiceMock(),
              AuthServiceMock(),
              ConstantsServiceMock(),
              FavorServiceMock(),
              LeaderboardServiceMock(),
              PostServiceMock(),
              ProfileServiceMock(),
              GoogleCalendarApiWrapperMock(),
            )),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ExploreQuery())
  ], child: const MyApp()));
}

MultiProvider getWidgetToTest(Widget widget) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AppProvider(
                  AdminServiceMock(),
                  AdminAuthServiceMock(),
                  ConstantsServiceMock(),
                  FavorServiceMock(),
                  LeaderboardServiceMock(),
                  PostServiceMock(),
                  ProfileServiceMock(),
                  GoogleCalendarApiWrapperMock(),
                )),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ExploreQuery())
      ],
      child: CupertinoApp(
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        home: widget,
      ),
    );
