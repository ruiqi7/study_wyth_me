import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/pages/authentication_wrapper.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // Root of App
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      value: Authentication().usersStream,
      initialData: null,
      child: const MaterialApp(
        title: 'Flutter App',
        home: AuthenticationWrapper(),
      ),
    );
  }
}