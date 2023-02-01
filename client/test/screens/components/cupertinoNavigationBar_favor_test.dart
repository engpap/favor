// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is run as part of a reduced test set in CI on Mac and Windows
// machines.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/components/cupertinoNavigationBar_favor.dart';

int count = 0;

void main() {
  group("Tests imported from flutter documentation", () {
    testWidgets('Middle still in center with asymmetrical actions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favor(
            leading: CupertinoButton(
              onPressed: null,
              child: Text('Something'),
            ),
            middle: Text('Title'),
          ),
        ),
      );

      // Expect the middle of the title to be exactly in the middle of the screen.
      expect(tester.getCenter(find.text('Title')).dx, 400.0);
    });

    testWidgets('Middle still in center with back button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favor(
            middle: Text('Title'),
          ),
        ),
      );

      tester
          .state<NavigatorState>(find.byType(Navigator))
          .push(CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return const CupertinoNavigationBar_favor(
            middle: Text('Page 2'),
          );
        },
      ));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Expect the middle of the title to be exactly in the middle of the screen.
      expect(tester.getCenter(find.text('Page 2')).dx, 400.0);
    });

    testWidgets('Non-opaque background adds blur effects',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favor(
            middle: Text('Title'),
          ),
        ),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('Nav bar displays correctly', (WidgetTester tester) async {
      final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        CupertinoApp(
          navigatorKey: navigator,
          home: const CupertinoNavigationBar_favor(
            middle: Text('Page 1'),
          ),
        ),
      );
      navigator.currentState!.push<void>(CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return const CupertinoNavigationBar_favor(
            middle: Text('Page 2'),
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(
          find.byType(CupertinoNavigationBar_favorBackButton), findsOneWidget);
      // Pops the page 2
      navigator.currentState!.pop();
      await tester.pump();
      // Needs another pump to trigger the rebuild;
      await tester.pump();
      // The back button should still persist;
      expect(
          find.byType(CupertinoNavigationBar_favorBackButton), findsOneWidget);
      // The app does not crash
      expect(tester.takeException(), isNull);
    });

    testWidgets('Padding works in RTL', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Align(
              alignment: Alignment.topCenter,
              child: CupertinoNavigationBar_favor(
                leading:
                    CupertinoButton(onPressed: null, child: Text('Cheetah')),
                // Let the box take all the vertical space to test vertical padding but let
                // the nav bar position it horizontally.
                middle: Text('Title'),
                trailing: CupertinoButton(onPressed: null, child: Text('Puma')),
                padding: EdgeInsetsDirectional.only(
                  start: 10.0,
                  end: 20.0,
                ),
              ),
            ),
          ),
        ),
      );

      expect(
          tester
              .getTopRight(find.widgetWithText(CupertinoButton, 'Cheetah'))
              .dx,
          800.0 - 10.0);
      expect(tester.getTopLeft(find.widgetWithText(CupertinoButton, 'Puma')).dx,
          20.0);

      // Title is still exactly centered.
      expect(tester.getCenter(find.text('Title')).dx, 400.0);
    });

    testWidgets('Nav bar uses theme defaults', (WidgetTester tester) async {
      count = 0x000000;
      await tester.pumpWidget(
        CupertinoApp(
          home: CupertinoNavigationBar_favor(
            leading: CupertinoButton(
              onPressed: () {},
              child: _ExpectStyles(
                  color: CupertinoColors.systemBlue.color, index: 0x000001),
            ),
            middle: const _ExpectStyles(
                color: CupertinoColors.black, index: 0x000100),
            trailing: CupertinoButton(
              onPressed: () {},
              child: _ExpectStyles(
                  color: CupertinoColors.systemBlue.color, index: 0x010000),
            ),
          ),
        ),
      );
      expect(count, 0x010101);
    });

    testWidgets('Nav bar respects themes', (WidgetTester tester) async {
      count = 0x000000;
      await tester.pumpWidget(
        CupertinoApp(
          theme: const CupertinoThemeData(brightness: Brightness.dark),
          home: CupertinoNavigationBar_favor(
            leading: CupertinoButton(
              onPressed: () {},
              child: _ExpectStyles(
                  color: CupertinoColors.systemBlue.darkColor, index: 0x000001),
            ),
            middle: const _ExpectStyles(
                color: CupertinoColors.white, index: 0x000100),
            trailing: CupertinoButton(
              onPressed: () {},
              child: _ExpectStyles(
                  color: CupertinoColors.systemBlue.darkColor, index: 0x010000),
            ),
          ),
        ),
      );
      expect(count, 0x010101);
    });

    testWidgets('Theme active color can be overridden',
        (WidgetTester tester) async {
      count = 0x000000;
      await tester.pumpWidget(
        CupertinoApp(
          theme: const CupertinoThemeData(primaryColor: Color(0xFF001122)),
          home: CupertinoNavigationBar_favor(
            leading: CupertinoButton(
              onPressed: () {},
              child: const _ExpectStyles(
                  color: Color(0xFF001122), index: 0x000001),
            ),
            middle:
                const _ExpectStyles(color: Color(0xFF000000), index: 0x000100),
            trailing: CupertinoButton(
              onPressed: () {},
              child: const _ExpectStyles(
                  color: Color(0xFF001122), index: 0x010000),
            ),
          ),
        ),
      );
      expect(count, 0x010101);
    });

    testWidgets('No slivers with no large titles', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar_favor(
              middle: Text('Title'),
            ),
            child: Center(),
          ),
        ),
      );

      expect(find.byType(SliverPersistentHeader), findsNothing);
    });

    testWidgets('Auto back/close button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favor(
            middle: Text('Home page'),
          ),
        ),
      );

      expect(find.byType(CupertinoButton), findsNothing);

      tester
          .state<NavigatorState>(find.byType(Navigator))
          .push(CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return const CupertinoNavigationBar_favor(
            middle: Text('Page 2'),
          );
        },
      ));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CupertinoButton), findsOneWidget);
      expect(find.text(String.fromCharCode(CupertinoIcons.back.codePoint)),
          findsOneWidget);

      tester
          .state<NavigatorState>(find.byType(Navigator))
          .push(CupertinoPageRoute<void>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return const CupertinoNavigationBar_favor(
                middle: Text('Dialog page'),
              );
            },
          ));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.widgetWithText(CupertinoButton, 'Close'), findsOneWidget);

      // Test popping goes back correctly.
      await tester.tap(find.text('Close'));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Page 2'), findsOneWidget);

      await tester
          .tap(find.text(String.fromCharCode(CupertinoIcons.back.codePoint)));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Home page'), findsOneWidget);
    });

    testWidgets('Long back label turns into "back"',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: Placeholder(),
        ),
      );

      tester.state<NavigatorState>(find.byType(Navigator)).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar_favor(
                previousPageTitle: '012345678901',
              ),
              child: Placeholder(),
            );
          },
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(
          find.widgetWithText(CupertinoButton, '012345678901'), findsOneWidget);

      tester.state<NavigatorState>(find.byType(Navigator)).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar_favor(
                previousPageTitle: '0123456789012',
              ),
              child: Placeholder(),
            );
          },
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.widgetWithText(CupertinoButton, 'Back'), findsOneWidget);
    });

    testWidgets('Border should be displayed by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favor(
            middle: Text('Title'),
          ),
        ),
      );

      final DecoratedBox decoratedBox = tester
          .widgetList(find.descendant(
            of: find.byType(CupertinoNavigationBar_favor),
            matching: find.byType(DecoratedBox),
          ))
          .first as DecoratedBox;
      expect(decoratedBox.decoration.runtimeType, BoxDecoration);

      final BoxDecoration decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);

      final BorderSide side = decoration.border!.bottom;
      expect(side, isNotNull);
    });

    testWidgets('Overrides border color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favor(
            middle: Text('Title'),
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFAABBCC),
                width: 0.0,
              ),
            ),
          ),
        ),
      );

      final DecoratedBox decoratedBox = tester
          .widgetList(find.descendant(
            of: find.byType(CupertinoNavigationBar_favor),
            matching: find.byType(DecoratedBox),
          ))
          .first as DecoratedBox;
      expect(decoratedBox.decoration.runtimeType, BoxDecoration);

      final BoxDecoration decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);

      final BorderSide side = decoration.border!.bottom;
      expect(side, isNotNull);
      expect(side.color, const Color(0xFFAABBCC));
    });

    testWidgets('Border should not be displayed when null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favor(
            middle: Text('Title'),
            border: null,
          ),
        ),
      );

      final DecoratedBox decoratedBox = tester
          .widgetList(find.descendant(
            of: find.byType(CupertinoNavigationBar_favor),
            matching: find.byType(DecoratedBox),
          ))
          .first as DecoratedBox;
      expect(decoratedBox.decoration.runtimeType, BoxDecoration);

      final BoxDecoration decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.border, isNull);
    });

    testWidgets('NavBar draws a light system bar for a dark background',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetsApp(
          color: const Color(0xFFFFFFFF),
          onGenerateRoute: (RouteSettings settings) {
            return CupertinoPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                return const CupertinoNavigationBar_favor(
                  middle: Text('Test'),
                  backgroundColor: Color(0xFF000000),
                );
              },
            );
          },
        ),
      );
      expect(SystemChrome.latestStyle, SystemUiOverlayStyle.light);
    });

    testWidgets('NavBar draws a dark system bar for a light background',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetsApp(
          color: const Color(0xFFFFFFFF),
          onGenerateRoute: (RouteSettings settings) {
            return CupertinoPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                return const CupertinoNavigationBar_favor(
                  middle: Text('Test'),
                  backgroundColor: Color(0xFFFFFFFF),
                );
              },
            );
          },
        ),
      );
      expect(SystemChrome.latestStyle, SystemUiOverlayStyle.dark);
    });

    testWidgets(
        'CupertinoNavigationBar_favorBackButton shows an error when manually added outside a route',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CupertinoNavigationBar_favorBackButton());

      final dynamic exception = tester.takeException();
      expect(exception, isAssertionError);
      expect(
          exception.toString(),
          contains(
              'CupertinoNavigationBar_favorBackButton should only be used in routes that can be popped'));
    });

    testWidgets(
        'CupertinoNavigationBar_favorBackButton shows an error when placed in a route that cannot be popped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoNavigationBar_favorBackButton(),
        ),
      );

      final dynamic exception = tester.takeException();
      expect(exception, isAssertionError);
      expect(
          exception.toString(),
          contains(
              'CupertinoNavigationBar_favorBackButton should only be used in routes that can be popped'));
    });

    testWidgets(
        'CupertinoNavigationBar_favorBackButton with a custom onPressed callback can be placed anywhere',
        (WidgetTester tester) async {
      bool backPressed = false;

      await tester.pumpWidget(
        CupertinoApp(
          home: CupertinoNavigationBar_favorBackButton(
            onPressed: () => backPressed = true,
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text(String.fromCharCode(CupertinoIcons.back.codePoint)),
          findsOneWidget);

      await tester.tap(find.byType(CupertinoNavigationBar_favorBackButton));

      expect(backPressed, true);
    });

    testWidgets(
      'Manually inserted CupertinoNavigationBar_favorBackButton still automatically '
      'show previous page title when possible',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CupertinoApp(
            home: Placeholder(),
          ),
        );

        tester.state<NavigatorState>(find.byType(Navigator)).push(
              CupertinoPageRoute<void>(
                title: 'An iPod',
                builder: (BuildContext context) {
                  return const CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar_favor(),
                    child: Placeholder(),
                  );
                },
              ),
            );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        tester.state<NavigatorState>(find.byType(Navigator)).push(
              CupertinoPageRoute<void>(
                title: 'A Phone',
                builder: (BuildContext context) {
                  return const CupertinoNavigationBar_favorBackButton();
                },
              ),
            );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.widgetWithText(CupertinoButton, 'An iPod'), findsOneWidget);
      },
    );

    testWidgets(
      'CupertinoNavigationBar_favorBackButton onPressed overrides default pop behavior',
      (WidgetTester tester) async {
        bool backPressed = false;
        await tester.pumpWidget(
          const CupertinoApp(
            home: Placeholder(),
          ),
        );

        tester.state<NavigatorState>(find.byType(Navigator)).push(
              CupertinoPageRoute<void>(
                title: 'An iPod',
                builder: (BuildContext context) {
                  return const CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar_favor(),
                    child: Placeholder(),
                  );
                },
              ),
            );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        tester.state<NavigatorState>(find.byType(Navigator)).push(
              CupertinoPageRoute<void>(
                title: 'A Phone',
                builder: (BuildContext context) {
                  return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar_favor(
                      leading: CupertinoNavigationBar_favorBackButton(
                        onPressed: () => backPressed = true,
                      ),
                    ),
                    child: const Placeholder(),
                  );
                },
              ),
            );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        await tester.tap(find.byType(CupertinoNavigationBar_favorBackButton));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        // The second page is still on top and didn't pop.
        expect(find.text('A Phone'), findsOneWidget);
        // Custom onPressed called.
        expect(backPressed, true);
      },
    );

    testWidgets('Null NavigationBar border transition',
        (WidgetTester tester) async {
      // This is a regression test for https://github.com/flutter/flutter/issues/71389
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar_favor(
              middle: Text('Page 1'),
              border: null,
            ),
            child: Placeholder(),
          ),
        ),
      );

      tester.state<NavigatorState>(find.byType(Navigator)).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar_favor(
                middle: Text('Page 2'),
                border: null,
              ),
              child: Placeholder(),
            );
          },
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Page 1'), findsNothing);
      expect(find.text('Page 2'), findsOneWidget);

      await tester
          .tap(find.text(String.fromCharCode(CupertinoIcons.back.codePoint)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Page 1'), findsOneWidget);
      expect(find.text('Page 2'), findsNothing);
    });
  });
}

class _ExpectStyles extends StatelessWidget {
  const _ExpectStyles({
    required this.color,
    required this.index,
  });

  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = DefaultTextStyle.of(context).style;
    expect(style.color, isSameColorAs(color));
    expect(style.fontFamily, '.SF Pro Text');
    expect(style.fontSize, 17.0);
    expect(style.letterSpacing, -0.41);
    count += index;
    return Container();
  }
}
