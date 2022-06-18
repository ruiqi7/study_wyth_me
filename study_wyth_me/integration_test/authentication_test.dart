import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_wyth_me/main.dart' as app;
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/pages/menu/about.dart';
import 'package:study_wyth_me/pages/menu/main_menu.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';
import 'package:study_wyth_me/pages/menu/sign_up.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('An existing user can sign in to the account.', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final welcomeBackButton = find.byKey(const Key('WelcomeBackButton'));
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
  });

  testWidgets('A new user can register an account.', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final imNewHereButton = find.byKey(const Key('ImNewHereButton'));
    await tester.ensureVisible(imNewHereButton);
    await tester.tap(imNewHereButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    final emailFormField = find.byKey(const Key('SignUpEmailFormField'));
    final usernameFormField = find.byKey(const Key('SignUpUsernameFormField'));
    final passwordFormField = find.byKey(const Key('SignUpPasswordFormField'));
    final signUpButton = find.byKey(const Key('SignUpButton'));

    await tester.enterText(emailFormField, 'loremipsum@gmail.com');
    await tester.enterText(usernameFormField, 'loremipsum');
    await tester.enterText(passwordFormField, 'loremipsum');
    await tester.pumpAndSettle();

    await tester.tap(signUpButton);
    await tester.pumpAndSettle(const Duration(seconds: 3)); // buffer time for the loading page

    expect(find.byWidgetPredicate((widget) => widget is Home), findsOneWidget);
  });
  
  testWidgets('A user cannot sign in with an invalid email and / or password.', (tester) async {
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

    await tester.enterText(emailFormField, 'invalid');
    await tester.enterText(passwordFormField, 'invalid');
    await tester.pumpAndSettle();

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is SignIn), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Invalid email and / or password.'), findsOneWidget);
  });
  
  testWidgets('A user cannot register with an invalid email.', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final imNewHereButton = find.byKey(const Key('ImNewHereButton'));
    await tester.ensureVisible(imNewHereButton);
    await tester.tap(imNewHereButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    final emailFormField = find.byKey(const Key('SignUpEmailFormField'));
    final usernameFormField = find.byKey(const Key('SignUpUsernameFormField'));
    final passwordFormField = find.byKey(const Key('SignUpPasswordFormField'));
    final signUpButton = find.byKey(const Key('SignUpButton'));

    await tester.enterText(emailFormField, 'invalid');
    await tester.enterText(usernameFormField, 'testing');
    await tester.enterText(passwordFormField, 'testing');
    await tester.pumpAndSettle();

    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Please try again.'), findsOneWidget);
  });
  
  testWidgets('A user cannot register with an existing email.', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final imNewHereButton = find.byKey(const Key('ImNewHereButton'));
    await tester.ensureVisible(imNewHereButton);
    await tester.tap(imNewHereButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    final emailFormField = find.byKey(const Key('SignUpEmailFormField'));
    final usernameFormField = find.byKey(const Key('SignUpUsernameFormField'));
    final passwordFormField = find.byKey(const Key('SignUpPasswordFormField'));
    final signUpButton = find.byKey(const Key('SignUpButton'));

    await tester.enterText(emailFormField, 'marylimtest@gmail.com');
    await tester.enterText(usernameFormField, 'testing');
    await tester.enterText(passwordFormField, 'testing');
    await tester.pumpAndSettle();

    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('There exists an account with this email.'), findsOneWidget);
  });

  testWidgets('A user cannot register with an existing username.', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final imNewHereButton = find.byKey(const Key('ImNewHereButton'));
    await tester.ensureVisible(imNewHereButton);
    await tester.tap(imNewHereButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    final emailFormField = find.byKey(const Key('SignUpEmailFormField'));
    final usernameFormField = find.byKey(const Key('SignUpUsernameFormField'));
    final passwordFormField = find.byKey(const Key('SignUpPasswordFormField'));
    final signUpButton = find.byKey(const Key('SignUpButton'));

    await tester.enterText(emailFormField, 'testing@gmail.com');
    await tester.enterText(usernameFormField, 'marylim');
    await tester.enterText(passwordFormField, 'testing');
    await tester.pumpAndSettle();

    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('This username has been taken up.'), findsOneWidget);
  });

  testWidgets('A user cannot register with a weak password.', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final imNewHereButton = find.byKey(const Key('ImNewHereButton'));
    await tester.ensureVisible(imNewHereButton);
    await tester.tap(imNewHereButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    final emailFormField = find.byKey(const Key('SignUpEmailFormField'));
    final usernameFormField = find.byKey(const Key('SignUpUsernameFormField'));
    final passwordFormField = find.byKey(const Key('SignUpPasswordFormField'));
    final signUpButton = find.byKey(const Key('SignUpButton'));

    await tester.enterText(emailFormField, 'testing@gmail.com');
    await tester.enterText(usernameFormField, 'testing');
    await tester.enterText(passwordFormField, 'test');
    await tester.pumpAndSettle();

    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is SignUp), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Enter at least 6 characters'), findsOneWidget);
  });
  
  testWidgets('A user can log out of the account.', (tester) async {
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

    final logoutButton = find.byKey(const Key('Logout'));
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is MainMenu), findsOneWidget);
  });
  
  testWidgets('A user can read about the purpose of the app.', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final aboutButton = find.byKey(const Key('AboutButton'));
    await tester.ensureVisible(aboutButton);
    await tester.tap(aboutButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is About), findsOneWidget);
    expect(
        find.text('This app serves as an integrated platform to help you study '
        'better! It features a gamification system for you to '
        'find motivation in studying, and also a discussion forum '
        'for you to resolve your academic troubles.'),
        findsOneWidget
    );
  });
}