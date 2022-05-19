import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/constants.dart';
import 'package:study_wyth_me/models/custom_text_widgets.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/services/authentication.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String email = '';
  String password = '';

  // invalid sign in error message
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const ChewyHeaderText(text: 'Sign In'),
              gapBox,
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField( // email
                        decoration: formFieldDeco.copyWith(hintText: 'Email'),
                        validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      gapBox,
                      TextFormField( // password
                        decoration: formFieldDeco.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (value) => value!.isEmpty ? 'Enter your password' : null,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      )
                    ],
                  ),
                ),
              ),
              gapBox,
              Container(
                width: 160,
                height: 55,
                decoration: largeRadiusRoundedBox,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 27.5,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontFamily: 'Chewy'
                    ),
                  ),
                  child: const Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      CustomUser? result = await _authenticate.customSignIn(email, password);
                      if (result == null) {
                        setState(() => error = 'Invalid email and / or password.');
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
              gapBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    width: 200,
                    height: 40,
                    decoration: largeRadiusRoundedBox,
                    child: TextButton(
                      child: const Text('Forgot Password?'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontFamily: 'Chewy'
                        ),
                      ),
                      onPressed: () {
                        // navigate to forgot password page
                      },
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  backButton(context)
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}