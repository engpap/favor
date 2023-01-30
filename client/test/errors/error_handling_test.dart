import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mockito/mockito.dart';
import 'package:project/main.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/explore/providerExplore.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/errors/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:project/services/adminService.dart';
import 'package:provider/provider.dart';
import '../utility_for_testing/mocks/mock_build_context.dart';
import '../utility_for_testing/mocks/mock_navigator.dart';
import '../utility_for_testing/mocks/services/admin_service_mock.dart';
import '../utility_for_testing/mocks/services/apis/google_calendar_api_wrapper_mock.dart';
import '../utility_for_testing/mocks/services/auth_service_mock.dart';
import '../utility_for_testing/mocks/services/constants_service_mock.dart';
import '../utility_for_testing/mocks/services/favor_service_mock.dart';
import '../utility_for_testing/mocks/services/leaderboard_service_mock.dart';
import '../utility_for_testing/mocks/services/post_service_mock.dart';
import '../utility_for_testing/mocks/services/profile_service_mock.dart';

void main() {
  executeUnitTests();
  //executeWidgetTests();
}

void executeUnitTests() {
  MockContext mockContext = MockContext();
  MockNavigator mockNavigator = MockNavigator();
  when(mockContext.findAncestorStateOfType<NavigatorState>())
      .thenReturn(mockNavigator);
  test('onSuccess callback is called when status code is between 200 and 299',
      () {
    var response = http.Response('', 200);
    var onSuccessCalled = false;
    var onSuccess = () {
      onSuccessCalled = true;
    };

    var context = mockContext;
    httpErrorHandle(response: response, context: context, onSuccess: onSuccess);
    expect(onSuccessCalled, true);
  });
}
