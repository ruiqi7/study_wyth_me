import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';
import 'about_page.dart';
import 'custom_text_widgets.dart';

const bgColour = Color.fromRGBO(0, 34, 75, 1.0);

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
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final double buttonWidth = 300;
  final double buttonHeight = 80;
  final SizedBox gapBox = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColour,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const ChewyHeaderText(text: 'Study Wyth Me'),
            const SizedBox(height: 45),
            Container(
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(255, 255, 255, 0.15),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: 'Chewy'

                  ),
                ),
                child: const Text('Welcome Back!'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
              ),
            ),
            gapBox,
            Container(
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(255, 255, 255, 0.15)
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: 'Chewy'

                  ),
                ),
                child: const Text('I\'m new here!'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
              ),
            ),
            gapBox,
            Container(
              width: buttonWidth,
              height: buttonHeight,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(255, 255, 255, 0.15)
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: 'Chewy'

                  ),
                ),
                child: const Text('About'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}

