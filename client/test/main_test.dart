import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/errors/error_handling.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/main.dart';
import 'package:http/http.dart' as http;
import 'package:project/providers/app_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/explore/providerExplore.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/introduction/introduction-1.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/services/adminService.dart';
import 'package:project/services/apis/google_calendar_api_wrapper.dart';
import 'package:project/services/authService.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/favorService.dart';
import 'package:project/services/leaderboardService.dart';
import 'package:project/services/postService.dart';
import 'package:project/services/profileService.dart';
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
