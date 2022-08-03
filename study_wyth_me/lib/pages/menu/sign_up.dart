import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:study_wyth_me/pages/loading.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _email = '';
  String _username = '';
  String _password = '';

  // invalid sign up error message
  String _error = '';

  // determines whether to display loading screen
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? const Loading() : Scaffold(
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
                        key: const Key('SignUpEmailFormField'),
                        decoration: formFieldDeco.copyWith(hintText: 'Email'),
                        style: chewyTextStyle.copyWith(fontSize: 18.0),
                        validator: (value) => value!.trim().isEmpty ? 'Enter your email' : null,
                        onChanged: (value) {
                          setState(() => _email = value.trim());
                        },
                      ),
                      gapBox,
                      TextFormField( // username
                        key: const Key('SignUpUsernameFormField'),
                        decoration: formFieldDeco.copyWith(hintText: 'Username'),
                        style: chewyTextStyle.copyWith(fontSize: 18.0),
                        validator: (value) => value!.trim().isEmpty ? 'Enter your username' : null,
                        onChanged: (value) {
                          setState(() => _username = value.trim());
                        },
                      ),
                      gapBox,
                      TextFormField( // password
                        key: const Key('SignUpPasswordFormField'),
                        decoration: formFieldDeco.copyWith(hintText: 'Password'),
                        style: chewyTextStyle.copyWith(fontSize: 18.0),
                        obscureText: true,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Enter your password';
                          } else if (value.trim().length < 6) {
                            return 'Enter at least 6 characters';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() => _password = value.trim());
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
                  key: const Key('SignUpButton'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: chewyTextStyle.copyWith(fontSize: 27.5),
                  ),
                  child: const AutoSizeText('Sign Up!', maxLines: 1),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String message = await _authenticate.customSignUp(_email, _username, _password);
                      if (message.isNotEmpty) {
                        setState(() => _error = message);
                      } else {
                        setState(() => _loading = true);
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
              gapBox,
              backButton(context),
              gapBoxH10,
              AutoSizeText(
                _error,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}