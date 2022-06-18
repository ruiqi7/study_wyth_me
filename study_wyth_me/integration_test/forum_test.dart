import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:study_wyth_me/main.dart' as app;
import 'package:study_wyth_me/pages/forum/forum.dart';
import 'package:study_wyth_me/pages/forum/forum_post.dart';
import 'package:study_wyth_me/pages/forum/main_post.dart';
import 'package:study_wyth_me/pages/forum/new_post.dart';
import 'package:study_wyth_me/pages/forum/search_forum.dart';
import 'package:study_wyth_me/pages/forum/search_list.dart';
import 'package:study_wyth_me/pages/forum/thread.dart';
import 'package:study_wyth_me/pages/forum/thread_reply.dart';
import 'package:study_wyth_me/pages/forum/thread_response.dart';
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';

void main() {
  Future<void> navigateToForumPage(WidgetTester tester) async {
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

    final forumTab = find.byKey(const Key('forumTab'));
    await tester.tap(forumTab);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Forum), findsOneWidget);
  }

  testWidgets('A user can create a new post. ', (tester) async {
    await navigateToForumPage(tester);

    final createNewPostButton = find.byKey(const Key('CreateNewPostButton'));
    await tester.tap(createNewPostButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NewPost), findsOneWidget);

    final titleFormField = find.byKey(const Key('NewPostTitleFormField'));
    final textFormField = find.byKey(const Key('NewPostTextFormField'));
    final postButton = find.byKey(const Key('Post'));

    await tester.enterText(titleFormField, 'lorem ipsum');
    await tester.enterText(textFormField, 'lorem ipsum');
    await tester.pumpAndSettle();

    await tester.tap(postButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NewPost), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is Forum), findsOneWidget);
    expect(
        find.byWidgetPredicate(
                (widget) => widget is ForumPost
                    && widget.post.title == 'lorem ipsum'
                    && widget.post.content == 'lorem ipsum'),
        findsWidgets
    );
  });

  testWidgets('A user can cancel the creation of a new post.', (tester) async {
    await navigateToForumPage(tester);

    final createNewPostButton = find.byKey(const Key('CreateNewPostButton'));
    await tester.tap(createNewPostButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NewPost), findsOneWidget);

    final titleFormField = find.byKey(const Key('NewPostTitleFormField'));
    final textFormField = find.byKey(const Key('NewPostTextFormField'));
    final closeButton = find.byKey(const Key('CloseIcon'));

    await tester.enterText(titleFormField, 'loremipsum');
    await tester.enterText(textFormField, 'loremipsum');
    await tester.pumpAndSettle();

    await tester.tap(closeButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is NewPost), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is Forum), findsOneWidget);
    expect(
        find.byWidgetPredicate(
                (widget) => widget is ForumPost
                && widget.post.title == 'loremipsum'
                && widget.post.content == 'loremipsum'),
        findsNothing
    );
  });

  testWidgets('A user can search for a post based on the title.', (tester) async {
    await navigateToForumPage(tester);

    final searchPostButton = find.byKey(const Key('SearchPostButton'));
    await tester.tap(searchPostButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SearchForum), findsOneWidget);

    final titleFormField = find.byKey(const Key('SearchForumFormField'));

    await tester.enterText(titleFormField, 'Random Title');
    await tester.pumpAndSettle();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is SearchList), findsOneWidget);
    expect(
        find.byWidgetPredicate(
                (widget) => widget is ForumPost
                && widget.post.title.contains('Random Title')),
        findsWidgets
    );
  });
  
  testWidgets('A user can view the thread of a post.', (tester) async {
    await navigateToForumPage(tester);

    final forumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
                && widget.post.title == 'lorem ipsum'
                && widget.post.content == 'lorem ipsum'
    ).first;
    final rightPointingArrow = find.descendant(of: forumPost, matching: find.byKey(const Key('RightPointingArrow')));

    await tester.tap(rightPointingArrow);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);
    expect(find.byType(Scrollbar), findsOneWidget);
    expect(
        find.byWidgetPredicate(
                (widget) => widget is MainPost
                    && widget.post.title == 'lorem ipsum'
                    && widget.post.content == 'lorem ipsum'),
        findsOneWidget
    );
  });

  testWidgets('A user can like and unlike other users\' posts on the Forum page, but not their own.', (tester) async {
    await navigateToForumPage(tester);

    final forumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
            && widget.post.title == 'Random Title'
            && widget.post.content == 'Random Content'
    ).first;
    final thumbsUpIcon = find.descendant(of: forumPost, matching: find.byKey(const Key('ForumPostThumbsUp')));
    final likesWidget = find.descendant(of: forumPost, matching: find.byKey(const Key('ForumPostLikes')));
    var likesText = likesWidget.evaluate().single.widget as Text;
    int numOfLikes = int.parse(likesText.data!);

    await tester.tap(thumbsUpIcon);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: thumbsUpIcon, matching: find.byIcon(Icons.thumb_up_alt)), findsOneWidget);
    expect(find.descendant(of: forumPost, matching: likesWidget), findsOneWidget);

    likesText = likesWidget.evaluate().single.widget as Text;
    expect(int.parse(likesText.data!), numOfLikes + 1);

    await tester.tap(thumbsUpIcon);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: thumbsUpIcon, matching: find.byIcon(Icons.thumb_up_alt_outlined)), findsOneWidget);
    expect(find.descendant(of: forumPost, matching: likesWidget), findsOneWidget);

    likesText = likesWidget.evaluate().single.widget as Text;
    expect(int.parse(likesText.data!), numOfLikes);

    final ownForumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
            && widget.post.title == 'lorem ipsum'
            && widget.post.content == 'lorem ipsum'
    ).first;
    final thumbsUpIcon1 = find.descendant(of: ownForumPost, matching: find.byKey(const Key('OwnPostThumbsUp')));
    final likesWidget1 = find.descendant(of: ownForumPost, matching: find.byKey(const Key('ForumPostLikes')));
    var likesText1 = likesWidget1.evaluate().single.widget as Text;
    String numOfLikes1 = likesText1.data!;

    await tester.tap(thumbsUpIcon1);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: ownForumPost, matching: find.byIcon(Icons.thumb_up_alt_outlined)), findsOneWidget);
    expect(find.descendant(of: ownForumPost, matching: likesWidget1), findsOneWidget);

    likesText1 = likesWidget1.evaluate().single.widget as Text;
    expect(likesText1.data, numOfLikes1);
  });

  testWidgets('A user can like and unlike other users\' posts on the Thread page, but not their own.', (tester) async {
    await navigateToForumPage(tester);

    final forumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
            && widget.post.title == 'Random Title'
            && widget.post.content == 'Random Content'
    ).first;
    final rightPointingArrow = find.descendant(of: forumPost, matching: find.byKey(const Key('RightPointingArrow')));

    await tester.tap(rightPointingArrow);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);
    final threadPost = find.byWidgetPredicate(
            (widget) => widget is MainPost
                && widget.post.title == 'Random Title'
                && widget.post.content == 'Random Content');
    final thumbsUpIcon = find.descendant(of: threadPost, matching: find.byKey(const Key('ThreadPostThumbsUp')));
    final likesWidget = find.descendant(of: threadPost, matching: find.byKey(const Key('ThreadPostLikes')));
    var likesText = likesWidget.evaluate().single.widget as Text;
    int numOfLikes = int.parse(likesText.data!);

    await tester.tap(thumbsUpIcon);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: thumbsUpIcon, matching: find.byIcon(Icons.thumb_up_alt)), findsOneWidget);
    expect(find.descendant(of: threadPost, matching: likesWidget), findsOneWidget);

    likesText = likesWidget.evaluate().single.widget as Text;
    expect(int.parse(likesText.data!), numOfLikes + 1);

    await tester.tap(thumbsUpIcon);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: thumbsUpIcon, matching: find.byIcon(Icons.thumb_up_alt_outlined)), findsOneWidget);
    expect(find.descendant(of: threadPost, matching: likesWidget), findsOneWidget);

    likesText = likesWidget.evaluate().single.widget as Text;
    expect(int.parse(likesText.data!), numOfLikes);

    final backButton = find.byKey(const Key('BackIcon'));
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Forum), findsOneWidget);

    final ownForumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
            && widget.post.title == 'lorem ipsum'
            && widget.post.content == 'lorem ipsum'
    ).first;
    final rightPointingArrow1 = find.descendant(of: ownForumPost, matching: find.byKey(const Key('RightPointingArrow')));

    await tester.tap(rightPointingArrow1);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);
    final ownThreadPost = find.byWidgetPredicate(
            (widget) => widget is MainPost
                && widget.post.title == 'lorem ipsum'
                && widget.post.content == 'lorem ipsum');
    final thumbsUpIcon1 = find.descendant(of: ownThreadPost, matching: find.byKey(const Key('OwnThreadPostThumbsUp')));
    final likesWidget1 = find.descendant(of: ownThreadPost, matching: find.byKey(const Key('ThreadPostLikes')));
    var likesText1 = likesWidget1.evaluate().single.widget as Text;
    String numOfLikes1 = likesText1.data!;

    await tester.tap(thumbsUpIcon1);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: ownThreadPost, matching: find.byIcon(Icons.thumb_up_alt_outlined)), findsOneWidget);
    expect(find.descendant(of: ownThreadPost, matching: likesWidget1), findsOneWidget);

    likesText1 = likesWidget1.evaluate().single.widget as Text;
    expect(likesText1.data, numOfLikes1);
  });

  testWidgets('A user can leave a comment on anyone’s post.', (tester) async {
    await navigateToForumPage(tester);

    final forumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
            && widget.post.title == 'Random Title'
            && widget.post.content == 'Random Content'
    ).first;
    final rightPointingArrow = find.descendant(of: forumPost, matching: find.byKey(const Key('RightPointingArrow')));

    await tester.tap(rightPointingArrow);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);
    final threadPost = find.byWidgetPredicate(
            (widget) => widget is MainPost
            && widget.post.title == 'Random Title'
            && widget.post.content == 'Random Content').first;
    final postReplyButton = find.descendant(of: threadPost, matching: find.byKey(const Key('PostReplyButton')));
    final commentsWidget = find.descendant(of: threadPost, matching: find.byKey(const Key('ThreadPostComments')));
    var commentsText = commentsWidget.evaluate().single.widget as Text;
    int numOfComments = int.parse(commentsText.data!);

    await tester.ensureVisible(postReplyButton);
    await tester.tap(postReplyButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is ThreadReply), findsOneWidget);

    final textFormField = find.byKey(const Key('ThreadReplyTextFormField'));
    final replyButton = find.byKey(const Key('Reply'));

    await tester.enterText(textFormField, 'Random Comment on Post');
    await tester.pumpAndSettle();

    await tester.tap(replyButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is ThreadReply), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: find.byType(ThreadResponse), matching: find.text('Random Comment on Post')), findsWidgets);
    expect(find.descendant(of: threadPost, matching: commentsWidget), findsOneWidget);

    commentsText = commentsWidget.evaluate().single.widget as Text;
    expect(int.parse(commentsText.data!), numOfComments + 1);
  });

  testWidgets('A user can leave a comment on anyone’s comment.', (tester) async {
    await navigateToForumPage(tester);

    final forumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
            && widget.post.title == 'Random Title'
            && widget.post.content == 'Random Content'
    ).first;
    final rightPointingArrow = find.descendant(of: forumPost, matching: find.byKey(const Key('RightPointingArrow')));

    await tester.tap(rightPointingArrow);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);
    final threadResponse = find.widgetWithText(ThreadResponse, 'A comment');
    final postReplyButton = find.descendant(of: threadResponse, matching: find.byKey(const Key('CommentReplyButton'))).first;
    final commentsWidget = find.descendant(of: threadResponse, matching: find.byKey(const Key('ThreadResponseComments'))).first;
    var commentsText = commentsWidget.evaluate().single.widget as Text;
    int numOfComments = int.parse(commentsText.data!);

    await tester.ensureVisible(postReplyButton);
    await tester.tap(postReplyButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is ThreadReply), findsOneWidget);

    final textFormField = find.byKey(const Key('ThreadReplyTextFormField'));
    final replyButton = find.byKey(const Key('Reply'));

    await tester.enterText(textFormField, 'Random Comment on Comment');
    await tester.pumpAndSettle();

    await tester.tap(replyButton);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is ThreadReply), findsNothing);
    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: find.byType(ThreadResponse), matching: find.text('Random Comment on Comment')), findsWidgets);
    expect(find.descendant(of: threadResponse, matching: commentsWidget), findsOneWidget);

    commentsText = commentsWidget.evaluate().single.widget as Text;
    expect(int.parse(commentsText.data!), numOfComments + 1);
  });

  testWidgets('A user can like and unlike other users\' comments on the Thread page, but not their own.', (tester) async {
    await navigateToForumPage(tester);

    final forumPost = find.byWidgetPredicate(
            (widget) => widget is ForumPost
            && widget.post.title == 'Random Title'
            && widget.post.content == 'Random Content'
    ).first;
    final rightPointingArrow = find.descendant(of: forumPost, matching: find.byKey(const Key('RightPointingArrow')));

    await tester.tap(rightPointingArrow);
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Thread), findsOneWidget);
    final threadResponse = find.widgetWithText(ThreadResponse, 'A comment');
    final thumbsUpIcon = find.descendant(of: threadResponse, matching: find.byKey(const Key('ThreadCommentThumbsUp'))).first;
    final likesWidget = find.descendant(of: threadResponse, matching: find.byKey(const Key('ThreadCommentLikes'))).first;
    var likesText = likesWidget.evaluate().single.widget as Text;
    int numOfLikes = int.parse(likesText.data!);

    await tester.tap(thumbsUpIcon);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: thumbsUpIcon, matching: find.byIcon(Icons.thumb_up_alt)), findsOneWidget);
    expect(find.descendant(of: threadResponse, matching: likesWidget), findsOneWidget);

    likesText = likesWidget.evaluate().single.widget as Text;
    expect(int.parse(likesText.data!), numOfLikes + 1);

    await tester.tap(thumbsUpIcon);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: thumbsUpIcon, matching: find.byIcon(Icons.thumb_up_alt_outlined)), findsOneWidget);
    expect(find.descendant(of: threadResponse, matching: likesWidget), findsOneWidget);

    likesText = likesWidget.evaluate().single.widget as Text;
    expect(int.parse(likesText.data!), numOfLikes);

    final ownThreadResponse = find.widgetWithText(ThreadResponse, 'Random Comment on Post');
    final thumbsUpIcon1 = find.descendant(of: ownThreadResponse, matching: find.byKey(const Key('OwnThreadResponseThumbsUp'))).first;
    final likesWidget1 = find.descendant(of: ownThreadResponse, matching: find.byKey(const Key('ThreadCommentLikes'))).first;
    var likesText1 = likesWidget1.evaluate().single.widget as Text;
    String numOfLikes1 = likesText1.data!;

    await tester.ensureVisible(thumbsUpIcon1);
    await tester.pumpAndSettle();
    await tester.tap(thumbsUpIcon1);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));
    expect(find.descendant(of: ownThreadResponse, matching: find.byIcon(Icons.thumb_up_alt_outlined)), findsOneWidget);
    expect(find.descendant(of: ownThreadResponse, matching: likesWidget1), findsOneWidget);

    likesText1 = likesWidget1.evaluate().single.widget as Text;
    expect(likesText1.data, numOfLikes1);
  });
}