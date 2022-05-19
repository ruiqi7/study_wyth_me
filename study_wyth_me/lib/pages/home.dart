import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/authentication.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              child: const Text(
                'log out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              onPressed: () async {
                await Authentication().customSignOut();
              },
            )
          ],
        )
      ),
    );
  }
}

