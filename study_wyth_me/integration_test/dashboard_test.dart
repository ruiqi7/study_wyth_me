import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_wyth_me/main.dart' as app;
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToHomePage(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final welcomeBackButton = find.byKey(const Key('WelcomeBackButton'));
    await tester.ensureVisible(welcomeBackButton);
    await tester.tap(welcomeBackButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SignIn), findsOneWidget);

    final emailFormField = find.byKey(const Key('SignInEmailFormField'));
    final passwordFormField = find.byKey(const Key('SignInPasswordFormField'));
    final loginButton = find.byKey(const Key('SignInLoginButton'));

    await tester.enterText(emailFormField, 'marylimtest@gmail.com');
    await tester.enterText(passwordFormField, 'marylim123');
    await tester.pumpAndSettle();

    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 3)); // buffer time for the loading page

    expect(find.byWidgetPredicate((widget) => widget is Home), findsOneWidget);
  }

  testWidgets('A user can view the profile picture, username, the ‘Logout’ button, the accumulated points, a ring chart and the navigation bar.', (tester) async {
    await navigateToHomePage(tester);

    final profilePicture = find.byKey(const Key('HomeProfilePicture'));
    expect(profilePicture, findsOneWidget);

    final username = find.byKey(const Key('HomeUsername'));
    expect(username, findsOneWidget);

    final logoutButton = find.byKey(const Key('Logout'));
    expect(logoutButton, findsOneWidget);

    final points = find.byKey(const Key('HomePoints'));
    expect(points, findsOneWidget);

    final ringChart = find.byKey(const Key('HomeRingChart'));
    expect(ringChart, findsOneWidget);
    
    final navigationBar = find.byKey(const Key('NavigationBar'));
    expect(navigationBar, findsOneWidget);
  });
}