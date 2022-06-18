import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_wyth_me/main.dart' as app;
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';
import 'package:study_wyth_me/pages/timer/countdown.dart';
import 'package:study_wyth_me/pages/timer/edit_modules.dart';
import 'package:study_wyth_me/pages/timer/module_card.dart';
import 'package:study_wyth_me/pages/timer/timer.dart';

void main() {
  Future<void> navigateToTimerPage(WidgetTester tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

    final timerTab = find.byKey(const Key('TimerTab'));
    await tester.tap(timerTab);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);
  }
  
  testWidgets('A user can set their desired studying time.', (tester) async {
    await navigateToTimerPage(tester);

    final circularTimerIcon = find.byKey(const Key('CircularTimerIcon'));
    await tester.tap(circularTimerIcon);
    await tester.pumpAndSettle();

    final cupertinoTimerPicker = find.byKey(const Key('CupertinoTimerPicker'));
    expect(cupertinoTimerPicker, findsOneWidget);

    await tester.drag(cupertinoTimerPicker, const Offset(0.0, 70.0));
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(195.0, 290.0));
    await tester.pumpAndSettle();

    final updatedCupertinoTimerPicker = find.descendant(of: circularTimerIcon, matching: find.text('00:28:00'));
    expect(updatedCupertinoTimerPicker, findsOneWidget);
  });

  testWidgets('A user can add and remove modules.', (tester) async {
    await navigateToTimerPage(tester);

    final editModulesButton = find.byKey(const Key('EditModulesButton'));
    await tester.tap(editModulesButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is EditModules), findsOneWidget);

    final moduleFormField = find.byKey(const Key('ModuleFormField'));
    final addModuleButton = find.byKey(const Key('AddModuleButton'));

    await tester.enterText(moduleFormField, 'module');
    await tester.pumpAndSettle();

    await tester.tap(addModuleButton);
    await tester.pumpAndSettle();

    final backButton = find.byKey(const Key('BackIcon'));
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);

    final dropdownMenu = find.byKey(const Key('DropdownMenu'));
    await tester.tap(dropdownMenu);
    await tester.pumpAndSettle();

    final dropdownMenuItem = find.descendant(of: dropdownMenu, matching: find.text('module'));
    expect(dropdownMenuItem, findsOneWidget);

    await tester.tapAt(const Offset(195.0, 290.0));
    await tester.pumpAndSettle();

    await tester.tap(editModulesButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is EditModules), findsOneWidget);

    final moduleCard = find.byWidgetPredicate((widget) => widget is ModuleCard && widget.module == 'module');
    final removeModuleButton = find.descendant(of: moduleCard, matching: find.byKey(const Key('RemoveModuleButton')));

    await tester.tap(removeModuleButton);
    await tester.pumpAndSettle();

    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);

    await tester.tap(dropdownMenu);
    await tester.pumpAndSettle();

    final updatedDropdownMenuItem = find.descendant(of: dropdownMenu, matching: find.text('module'));
    expect(updatedDropdownMenuItem, findsNothing);
  });
  
  testWidgets('A user can select a module.', (tester) async {
    await navigateToTimerPage(tester);

    final editModulesButton = find.byKey(const Key('EditModulesButton'));
    await tester.tap(editModulesButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is EditModules), findsOneWidget);

    final moduleFormField = find.byKey(const Key('ModuleFormField'));
    final addModuleButton = find.byKey(const Key('AddModuleButton'));

    await tester.enterText(moduleFormField, 'test');
    await tester.pumpAndSettle();

    await tester.tap(addModuleButton);
    await tester.pumpAndSettle();

    final backButton = find.byKey(const Key('BackIcon'));
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);

    final dropdownMenu = find.byKey(const Key('DropdownMenu'));
    await tester.tap(dropdownMenu);
    await tester.pumpAndSettle();

    await tester.longPressAt(const Offset(187.5, 520));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    final itemChosen = find.byWidgetPredicate((widget) => widget is DropdownButtonFormField2 && widget.initialValue == 'test');
    expect(itemChosen, findsOneWidget);
  });

  testWidgets('A user can start the countdown timer if a module is selected.', (tester) async {
    await navigateToTimerPage(tester);

    final dropdownMenu = find.byKey(const Key('DropdownMenu'));
    await tester.tap(dropdownMenu);
    await tester.pumpAndSettle();

    await tester.longPressAt(const Offset(187.5, 520));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    final itemChosen = find.byWidgetPredicate((widget) => widget is DropdownButtonFormField2 && widget.initialValue == 'test');
    expect(itemChosen, findsOneWidget);

    final startTimerButton = find.byKey(const Key('StartTimerButton'));
    await tester.tap(startTimerButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Countdown), findsOneWidget);
  });

  testWidgets('A user cannot start the countdown timer if no module is selected.', (tester) async {
    await navigateToTimerPage(tester);

    final dropdownMenu = find.byKey(const Key('DropdownMenu'));
    final noItemChosen = find.byWidgetPredicate((widget) => widget is DropdownButtonFormField2 && widget.initialValue == null);
    expect(noItemChosen, findsOneWidget);

    final startTimerButton = find.byKey(const Key('StartTimerButton'));
    await tester.tap(startTimerButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Countdown), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Please select a module.'), findsOneWidget);
  });
  
  testWidgets('A user cannot receive any points when the timer ends if the duration was less than 30 minutes long.', (tester) async {
    await navigateToTimerPage(tester);

    final circularTimerIcon = find.byKey(const Key('CircularTimerIcon'));
    await tester.tap(circularTimerIcon);
    await tester.pumpAndSettle();

    final cupertinoTimerPicker = find.byKey(const Key('CupertinoTimerPicker'));
    expect(cupertinoTimerPicker, findsOneWidget);

    for (int i = 0; i < 14; i++) {
      await tester.drag(cupertinoTimerPicker, const Offset(0.0, 70.0));
      await tester.pumpAndSettle();
    }

    await tester.tapAt(const Offset(195.0, 290.0));
    await tester.pumpAndSettle();

    final updatedCupertinoTimerPicker = find.descendant(of: circularTimerIcon, matching: find.text('00:02:00'));
    expect(updatedCupertinoTimerPicker, findsOneWidget);

    final dropdownMenu = find.byKey(const Key('DropdownMenu'));
    await tester.tap(dropdownMenu);
    await tester.pumpAndSettle();

    await tester.longPressAt(const Offset(187.5, 520));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    final itemChosen = find.byWidgetPredicate((widget) => widget is DropdownButtonFormField2 && widget.initialValue == 'test');
    expect(itemChosen, findsOneWidget);

    final startTimerButton = find.byKey(const Key('StartTimerButton'));
    await tester.tap(startTimerButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Countdown), findsOneWidget);

    for (int i = 0; i < 120; i++) {
      await Future.delayed(const Duration(seconds: 1), () async {
        await tester.pumpAndSettle();
      });
    }

    await tester.pump(const Duration(seconds: 1));

    final countdownDoneButton = find.byKey(const Key('CountdownDoneButton'));
    await tester.tap(countdownDoneButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);

    final homeTab = find.byKey(const Key('HomeTab'));
    await tester.tap(homeTab);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsOneWidget);

    final pointsWidget = find.byKey(const Key('HomePoints'));
    final pointsText = pointsWidget.evaluate().single.widget as Text;
    expect(pointsText.data, '0');
  });

  testWidgets('A user can cancel the countdown timer.', (tester) async {
    await navigateToTimerPage(tester);

    final dropdownMenu = find.byKey(const Key('DropdownMenu'));
    await tester.tap(dropdownMenu);
    await tester.pumpAndSettle();

    await tester.longPressAt(const Offset(187.5, 520));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    final itemChosen = find.byWidgetPredicate((widget) => widget is DropdownButtonFormField2 && widget.initialValue == 'test');
    expect(itemChosen, findsOneWidget);

    final startTimerButton = find.byKey(const Key('StartTimerButton'));
    await tester.tap(startTimerButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Countdown), findsOneWidget);

    final countdownCancelButton = find.byKey(const Key('CountdownCancelButton'));
    await tester.tap(countdownCancelButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);
  });

  testWidgets('A user cannot receive any points when the timer is cancelled.', (tester) async {
    await navigateToTimerPage(tester);

    final dropdownMenu = find.byKey(const Key('DropdownMenu'));
    await tester.tap(dropdownMenu);
    await tester.pumpAndSettle();

    await tester.longPressAt(const Offset(187.5, 520));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    final itemChosen = find.byWidgetPredicate((widget) => widget is DropdownButtonFormField2 && widget.initialValue == 'test');
    expect(itemChosen, findsOneWidget);

    final startTimerButton = find.byKey(const Key('StartTimerButton'));
    await tester.tap(startTimerButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Countdown), findsOneWidget);

    final countdownCancelButton = find.byKey(const Key('CountdownCancelButton'));
    await tester.tap(countdownCancelButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Timer), findsOneWidget);

    final homeTab = find.byKey(const Key('HomeTab'));
    await tester.tap(homeTab);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Home), findsOneWidget);

    final pointsWidget = find.byKey(const Key('HomePoints'));
    final pointsText = pointsWidget.evaluate().single.widget as Text;
    expect(pointsText.data, '0');
  });
}