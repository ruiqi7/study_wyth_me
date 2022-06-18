import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_wyth_me/main.dart' as app;
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/pages/leaderboard/edit_friends.dart';
import 'package:study_wyth_me/pages/leaderboard/friend_card.dart';
import 'package:study_wyth_me/pages/leaderboard/leaderboard.dart';
import 'package:study_wyth_me/pages/leaderboard/leaderboard_list.dart';
import 'package:study_wyth_me/pages/leaderboard/user_card.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';

void main() {
  Future<void> navigateToLeaderboardPage(WidgetTester tester) async {
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
    await tester.pumpAndSettle(
        const Duration(seconds: 3)); // buffer time for the loading page

    expect(find.byWidgetPredicate((widget) => widget is Home), findsOneWidget);

    final leaderboardTab = find.byKey(const Key('LeaderboardTab'));
    await tester.tap(leaderboardTab);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Leaderboard), findsOneWidget);
  }
  
  testWidgets('A user can view the accumulated points, the rank and the community leaderboard.', (tester) async {
    await navigateToLeaderboardPage(tester);

    final points = find.byKey(const Key('LeaderboardPoints'));
    expect(points, findsOneWidget);
    
    final rank = find.byKey(const Key('Rank'));
    expect(rank, findsOneWidget);
    
    final leaderboard = find.byWidgetPredicate((widget) => widget is LeaderboardList);
    expect(leaderboard, findsOneWidget);
  });

  testWidgets('A user can view the accumulated points, the rank, the friends leaderboard and the \'Add a new friend\' button.', (tester) async {
    await navigateToLeaderboardPage(tester);

    final friendsButton = find.byKey(const Key('FriendsButton'));
    await tester.tap(friendsButton);
    await tester.pumpAndSettle();

    final points = find.byKey(const Key('LeaderboardPoints'));
    expect(points, findsOneWidget);

    final rank = find.byKey(const Key('Rank'));
    expect(rank, findsOneWidget);

    final leaderboard = find.byWidgetPredicate((widget) => widget is LeaderboardList);
    expect(leaderboard, findsOneWidget);

    final addFriendButton = find.byKey(const Key('AddFriendButton'));
    expect(addFriendButton, findsOneWidget);
  });
  
  testWidgets('A user can search, add and remove a friend.', (tester) async {
    await navigateToLeaderboardPage(tester);

    final friendsButton = find.byKey(const Key('FriendsButton'));
    await tester.tap(friendsButton);
    await tester.pumpAndSettle();

    final addFriendButton = find.byKey(const Key('AddFriendButton'));
    await tester.tap(addFriendButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is EditFriends), findsOneWidget);

    final usernameFormField = find.byKey(const Key('EditFriendsUsernameFormField'));

    await tester.enterText(usernameFormField, 'loremipsum');
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final friendCard = find.byWidgetPredicate(
            (widget) => widget is FriendCard
                && widget.username == 'loremipsum'
                && widget.isFriend == false);
    final addButton = find.descendant(of: friendCard, matching: find.byKey(const Key('AddButton')));

    await tester.tap(addButton);
    await tester.pumpAndSettle();

    final backButton = find.byKey(const Key('BackIcon'));
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is EditFriends), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is Leaderboard), findsOneWidget);
    expect(addFriendButton, findsOneWidget);

    final friendsLeaderboard = find.byWidgetPredicate((widget) => widget is LeaderboardList);
    final friendOnLeaderboard = find.descendant(
        of: friendsLeaderboard,
        matching: find.byWidgetPredicate((widget) => widget is UserCard && widget.appUser.username == 'loremipsum')
    );
    expect(friendOnLeaderboard, findsOneWidget);

    await tester.tap(addFriendButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is EditFriends), findsOneWidget);

    await tester.enterText(usernameFormField, 'loremipsum');
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final friendCard1 = find.byWidgetPredicate(
            (widget) => widget is FriendCard
            && widget.username == 'loremipsum'
            && widget.isFriend == true);
    final removeButton = find.descendant(of: friendCard1, matching: find.byKey(const Key('RemoveButton')));

    await tester.tap(removeButton);
    await tester.pumpAndSettle();

    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is EditFriends), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is Leaderboard), findsOneWidget);
    expect(addFriendButton, findsOneWidget);

    final friendsLeaderboard1 = find.byWidgetPredicate((widget) => widget is LeaderboardList);
    final friendOnLeaderboard1 = find.descendant(
        of: friendsLeaderboard1,
        matching: find.byWidgetPredicate((widget) => widget is UserCard && widget.appUser.username == 'loremipsum')
    );
    expect(friendOnLeaderboard1, findsNothing);
  });
}