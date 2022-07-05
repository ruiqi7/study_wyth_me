//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/pages/authentication_wrapper.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:study_wyth_me/services/notification.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init();
  runApp(const MaterialApp(
    initialRoute: '/',
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // Root of App
  @override
  Widget build(BuildContext context) {
    //Authentication().customSignOut();
    return StreamProvider<CustomUser?>.value(
      value: Authentication().usersStream,
      initialData: null,
      child: const Scaffold(
        body: AuthenticationWrapper(),
      ),
    );
  }
}