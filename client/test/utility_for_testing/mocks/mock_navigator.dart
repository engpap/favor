import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';

/*
class MockNavigator extends Mock implements NavigatorState {
  /// If the following method is not overriden then an error will show up.
  /// The reason is the following: toString method in the Mock class is not a
  ///  valid implementation of
  ///  the toString method in the Diagnosticable interface, because the method
  ///  signature is different. The Mock class's toString method takes
  ///  no arguments, while the Diagnosticable interface's toString method
  ///  takes a single argument minLevel.
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'MockNavigator';
  }
}*/

class MockNavigator extends Mock implements NavigatorState {
  final List<Route<dynamic>> _routes = <Route<dynamic>>[];

  /// If the following method is not overriden then an error will show up.
  /// The reason is the following: toString method in the Mock class is not a
  ///  valid implementation of
  ///  the toString method in the Diagnosticable interface, because the method
  ///  signature is different. The Mock class's toString method takes
  ///  no arguments, while the Diagnosticable interface's toString method
  ///  takes a single argument minLevel.
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'MockNavigator';
  }

  @override
  List<Route<dynamic>> get routes => _routes;

  @override
  Future<T?> push<T extends Object?>(Route<T> route) {
    _routes.add(route);
    return Future<T>.value(route.currentResult);
  }

  @override
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
  }) {
    _routes.removeWhere((route) => route.currentResult == result);
    _routes.add(newRoute);
    return Future<T?>.value(newRoute.currentResult);
  }
}
