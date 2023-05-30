import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:youapp_test/main.dart' as app;
import 'package:youapp_test/views/home/initial_page.dart';
import 'package:youapp_test/views/login/login_page.dart';

void main() {
  group('main app test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
      'test',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
      },
    );

    testWidgets(
      'login',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(Key("email_input")), 'gandrainsan@yahoo.com');
        await tester.enterText(find.byKey(Key("password_input")), 'testtest');
        await tester.tap(find.byKey(Key('login_button')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key('logout_button')));
        await tester.pumpAndSettle();

        expect(find.byType(LoginPage), findsOneWidget);
      },
    );

    testWidgets(
      'register ',
      (tester) async {
        final email = 'test${DateTime.now().second}@emailtest.com';
        final username = 'testusername${DateTime.now().second}';

        app.main();
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key('to_register_button')));
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(Key("email_input")), email);
        await tester.enterText(find.byKey(Key("username_input")), username);
        await tester.enterText(find.byKey(Key("password_input")), 'testtest');
        await tester.enterText(
            find.byKey(Key("confirm_password_input")), 'testtest');
        await tester.tap(find.byKey(Key('register_button')));
        await tester.pumpAndSettle();

        expect(find.byType(InitialPage), findsOneWidget);
      },
    );

    testWidgets(
      'update about',
      (tester) async {
        final username = 'test${DateTime.now().second}';
        final weight = (DateTime.now().second + 120);
        final height = (DateTime.now().second + 30);

        app.main();
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(Key("email_input")), 'gandrainsan@yahoo.com');
        await tester.enterText(find.byKey(Key("password_input")), 'testtest');
        await tester.tap(find.byKey(Key('login_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('edit_button')));
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(Key('username_input')), username);
        await tester.enterText(
            find.byKey(Key('weight_input')), weight.toString());
        await tester.enterText(
            find.byKey(Key('height_input')), height.toString());
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('save_button')));
        await tester.pumpAndSettle();

        expect(tester.getSemantics(find.byKey(Key('Weight: '))),
            matchesSemantics(label: '${weight.toString()} kg'));
        expect(tester.getSemantics(find.byKey(Key('Height: '))),
            matchesSemantics(label: '${height.toString()} cm'));
      },
    );

    testWidgets(
      'input interests',
      (tester) async {
        final interest = 'test${DateTime.now().second}';

        app.main();
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(Key("email_input")), 'gandrainsan@yahoo.com');
        await tester.enterText(find.byKey(Key("password_input")), 'testtest');
        await tester.tap(find.byKey(Key('login_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Key('edit_interest')));
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(Key('interests_input')), interest);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.tap(find.byKey(Key('save_button')));
        await tester.pumpAndSettle();

        expect(find.byType(InitialPage), findsOneWidget);
      },
    );
  });
}
