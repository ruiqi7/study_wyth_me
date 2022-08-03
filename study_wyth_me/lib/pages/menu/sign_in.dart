import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:study_wyth_me/pages/menu/reset_password.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:study_wyth_me/pages/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _email = '';
  String _password = '';

  // invalid sign in error message
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
              const ChewyHeaderText(text: 'Sign In'),
              gapBox,
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField( // email
                        key: const Key('SignInEmailFormField'),
                        decoration: formFieldDeco.copyWith(hintText: 'Email'),
                        style: chewyTextStyle.copyWith(fontSize: 18.0),
                        validator: (value) => value!.trim().isEmpty ? 'Enter your email' : null,
                        onChanged: (value) {
                          setState(() => _email = value.trim());
                        },
                      ),
                      gapBox,
                      TextFormField( // password
                        key: const Key('SignInPasswordFormField'),
                        decoration: formFieldDeco.copyWith(hintText: 'Password'),
                        style: chewyTextStyle.copyWith(fontSize: 18.0),
                        obscureText: true,
                        validator: (value) => value!.trim().isEmpty ? 'Enter your password' : null,
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
                  key: const Key('SignInLoginButton'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: chewyTextStyle.copyWith(fontSize: 27.5),
                  ),
                  child: const AutoSizeText('Login', maxLines: 1),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      CustomUser? result = await _authenticate.customSignIn(_email, _password);
                      if (result == null) {
                        setState(() => _error = 'Invalid email and / or password.');
                      } else {
                        setState(() => _loading = true);
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
                      child: const AutoSizeText('Forgot Password?', maxLines: 1),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(child: const ResetPassword(), type: PageTransitionType.rightToLeftPop, childCurrent: widget)
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  backButton(context)
                ],
              ),
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