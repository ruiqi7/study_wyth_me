import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/services/authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String email = '';
  String username = '';
  String password = '';

  // invalid sign up error message
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
              const ChewyHeaderText(text: 'Sign Up'),
              gapBox,
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField( // email
                        decoration: formFieldDeco.copyWith(hintText: 'Email'),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      gapBox,
                      TextFormField( // username
                        decoration: formFieldDeco.copyWith(hintText: 'Username'),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => value!.isEmpty ? 'Enter your username' : null,
                        onChanged: (value) {
                          setState(() => username = value);
                        },
                      ),
                      gapBox,
                      TextFormField( // password
                        decoration: formFieldDeco.copyWith(hintText: 'Password'),
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your password';
                          } else if (value.length < 6) {
                            return 'Enter at least 6 characters';
                          } else {
                            return null;
                          }
                        },
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
                    textStyle: chewyTextStyle.copyWith(fontSize: 27.5),
                  ),
                  child: const Text('Sign Up!'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      CustomUser? result = await _authenticate.customSignUp(email, username, password);
                      if (result == null) {
                        setState(() => error = 'Please try again.');
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
              gapBox,
              backButton(context),
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