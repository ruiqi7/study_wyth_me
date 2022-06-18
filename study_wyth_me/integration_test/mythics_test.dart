import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_wyth_me/main.dart' as app;
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';
import 'package:study_wyth_me/pages/mythics/mythics.dart';

void main() {
  Future<void> navigateToMythicsPage(WidgetTester tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    app.main();
    await tester.pumpAndSettle();

    final welcomeBackButton = find.byKey(const Key('WelcomeBackButton'));
    await tester.ensureVisible(welcomeBackButton);
    await tester.tap(welcomeBackButton);
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) => widget is SignIn), findsOneWidget);

    final emailFormField = find.byKey(const Key('SignInEmailFormField'));
    final passwordFormField = find.byKey(const Key('SignInPasswordFormField'));
    final loginButton = find.byKey(const Key('SignInLoginButton'));

    await tester.enterText(emailFormField, 'marylimtest@gmail.com');
    await tester.enterText(passwordFormField, 'marylim123');
    await tester.pumpAndSettle();

    await tester.tap(loginButton);
    await tester.pumpAndSettle(
        const Duration(seconds: 3)); // buffer time for the loading page

    expect(find.byWidgetPredicate((widget) => widget is Home), findsOneWidget);

    final mythicsTab = find.byKey(const Key('MythicsTab'));
    await tester.tap(mythicsTab);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Mythics),
        findsOneWidget);
  }
  
  testWidgets('A user is able to view the accumulated points and all the mythics collected.', (tester) async {
    await navigateToMythicsPage(tester);

    final points = find.byKey(const Key('MythicsPoints'));
    expect(points, findsOneWidget);

    final mythicsCollection = find.byKey(const Key('MythicsCollection'));
    expect(mythicsCollection, findsOneWidget);
  });

  testWidgets('A user is unable to claim a mythic with insufficient accumulated points.', (tester) async {
    await navigateToMythicsPage(tester);

    final claimButton = find.byKey(const Key('ClaimButton')).first;
    await tester.tap(claimButton);
    await tester.pumpAndSettle();

    final alertDialogue = find.widgetWithText(AlertDialog, 'Insufficient points to claim!');
    expect(alertDialogue, findsOneWidget);
  });
}