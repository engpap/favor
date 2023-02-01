import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/errors/error_handling.dart';
import 'package:http/http.dart' as http;
import '../utility_for_testing/mocks/mock_build_context.dart';
import '../utility_for_testing/mocks/mock_navigator.dart';

void main() {
  executeUnitTests();
  executeWidgetTests();
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

void executeWidgetTests() {
  MockContext mockContext = MockContext();
  MockNavigator mockNavigator = MockNavigator();
  when(mockContext.findAncestorStateOfType<NavigatorState>())
      .thenReturn(mockNavigator);
  testWidgets(
      'onSuccess callback is not called when status code is not between 200 and 299',
      (tester) async {
    var response = http.Response('', 300);
    var onSuccessCalled = false;
    var onSuccess = () {
      onSuccessCalled = true;
    };

    var context = mockContext;
    httpErrorHandle(response: response, context: context, onSuccess: onSuccess);
    expect(onSuccessCalled, false);
  });
}
