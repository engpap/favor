import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/home.dart';

void main() {
  userModeShouldCreateState();
  setUserModeMethodsShouldWorkCorrectly();
  getUserModeMethodsShouldWorkCorrectly();
  getOppositeUserModeMethodsShouldWorkCorrectly();
}

void userModeShouldCreateState() {
  testWidgets('UserMode should create state', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: UserMode(
          key: UniqueKey(),
          child: Text("Test"),
        ),
      ),
    );

    final state = tester.state(find.byType(UserMode));
    expect(state, isA<UserModeState>());
  });
}

void setUserModeMethodsShouldWorkCorrectly() {
  group('setUserMode_* methods should work correctly', () {
    /// Test the setUserMode_provider() function by calling it and then
    /// using the isUserModeAs_provider() function to check if the provider
    /// status is set to true and the caller and admin statuses are set to false.
    testWidgets('setUserMode_provider() should work correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: UserMode(
            key: UniqueKey(),
            child: Text("Test"),
          ),
        ),
      );
      // Get the state object
      final _UserModeState =
          tester.state(find.byType(UserMode)) as UserModeState;

      ///"When UserMode is set to Provider, then Caller and Admin status boolean getters return false",
      _UserModeState.setUserMode_provider();
      expect(_UserModeState.isUserModeAs_provider(), true);
      expect(_UserModeState.isUserModeAs_caller(), false);
      expect(_UserModeState.isUserModeAs_admin(), false);

      ///"When UserMode is set to Caller, then Provider and Admin status boolean variables are false",
      _UserModeState.setUserMode_provider();
      expect(_UserModeState.providerStatus_state, true);
      expect(_UserModeState.callerStatus_state, false);
      expect(_UserModeState.adminStatus_state, false);
    });

    ///Test the setUserMode_caller() function by calling it and then using
    /// the isUserModeAs_caller() function to check if the caller status is
    /// set to true and the provider and admin statuses are set to false.
    testWidgets('setUserMode_caller() should work correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: UserMode(
            key: UniqueKey(),
            child: Text("Test"),
          ),
        ),
      );
      // Get the state object
      final _UserModeState =
          tester.state(find.byType(UserMode)) as UserModeState;

      ///"When UserMode is set to Caller, then Provider and Admin status boolean getters return false",
      _UserModeState.setUserMode_caller();
      expect(_UserModeState.isUserModeAs_caller(), true);
      expect(_UserModeState.isUserModeAs_provider(), false);
      expect(_UserModeState.isUserModeAs_admin(), false);

      ///"When UserMode is set to Caller, then Provider and Admin status boolean variables are false",
      _UserModeState.setUserMode_caller();
      expect(_UserModeState.callerStatus_state, true);
      expect(_UserModeState.providerStatus_state, false);
      expect(_UserModeState.adminStatus_state, false);
    });

    ///Test the setUserMode_admin() function by calling it and then using
    /// the isUserModeAs_admin() function to check if the admin status is
    /// set to true and the provider and caller statuses are set to false.
    testWidgets('setUserMode_admin() should work correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: UserMode(
            key: UniqueKey(),
            child: Text("Test"),
          ),
        ),
      );
      // Get the state object
      final _UserModeState =
          tester.state(find.byType(UserMode)) as UserModeState;

      ///"When UserMode is set to Admin, then Provider and Caller status boolean getters return false",
      _UserModeState.setUserMode_admin();
      expect(_UserModeState.isUserModeAs_admin(), true);
      expect(_UserModeState.isUserModeAs_caller(), false);
      expect(_UserModeState.isUserModeAs_provider(), false);

      ///"When UserMode is set to Admin, then Provider and Caller status boolean variables are false",
      _UserModeState.setUserMode_admin();
      expect(_UserModeState.adminStatus_state, true);
      expect(_UserModeState.callerStatus_state, false);
      expect(_UserModeState.providerStatus_state, false);
    });
  });
}

void getUserModeMethodsShouldWorkCorrectly() {
  group('getUserMode method should work correctly', () {
    testWidgets('getUserMode method should work correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: UserMode(
            key: UniqueKey(),
            child: Text("Test"),
          ),
        ),
      );
      // Get the state object
      final _UserModeState =
          tester.state(find.byType(UserMode)) as UserModeState;

      /// Test the getUserMode() function by setting the mode through
      /// setUserMode_provider(), previously tested, and then calling
      /// getUserMode() to check if the returned string is set to 'provider'
      _UserModeState.setUserMode_provider();
      expect(_UserModeState.getUserMode(), 'provider');

      /// Test the getUserMode() function by setting the mode through
      /// setUserMode_caller(), previously tested, and then calling
      /// getUserMode() to check if the returned string is set to 'caller'
      _UserModeState.setUserMode_caller();
      expect(_UserModeState.getUserMode(), 'caller');

      /// Test the getUserMode() function by setting the mode through
      /// setUserMode_admin(), previously tested, and then calling
      /// getUserMode() to check if the returned string is set to 'admin'
      _UserModeState.setUserMode_admin();
      expect(_UserModeState.getUserMode(), 'admin');
    });
  });
}

void getOppositeUserModeMethodsShouldWorkCorrectly() {
  group('getOppositeUserMode method should work correctly', () {
    testWidgets('getOppositeUserMode method should work correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: UserMode(
            key: UniqueKey(),
            child: Text("Test"),
          ),
        ),
      );
      // Get the state object
      final _UserModeState =
          tester.state(find.byType(UserMode)) as UserModeState;

      /// Test the getUserMode() function by setting the mode through
      /// setOppositeUserMode_provider(), previously tested, and then calling
      /// getOppositeUserMode() to check if the returned string is set to 'caller'
      _UserModeState.setUserMode_provider();
      expect(_UserModeState.getOppositeUserMode(), 'caller');

      /// Test the getOppositeUserMode() function by setting the mode through
      /// setUserMode_caller(), previously tested, and then calling
      /// getUserMode() to check if the returned string is set to 'caller'
      _UserModeState.setUserMode_caller();
      expect(_UserModeState.getOppositeUserMode(), 'provider');

      /// Test the getOppositeUserMode() function by setting the mode through
      /// setUserMode_admin(), previously tested, and then calling
      /// getOppositeUserMode() to check if the returned string is set to ''
      _UserModeState.setUserMode_admin();
      expect(_UserModeState.getOppositeUserMode(), '');
    });
  });
}
