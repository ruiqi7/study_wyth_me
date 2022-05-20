import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // value of the form field
  String email = '';

  // message to indicate if password reset email was sent
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const ChewyHeaderText(text: 'Reset Password'),
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
                      )
                    ],
                  ),
                ),
              ),
              gapBox,
              Container(
                width: 210,
                height: 90,
                decoration: largeRadiusRoundedBox,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: chewyTextStyle.copyWith(fontSize: 27.5),
                  ),
                  child: const Text(
                      'Send Password Reset Email',
                      textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                        setState(() => message = 'Email sent!');
                      } on FirebaseAuthException catch (authException) {
                        String error = authException.code;
                        if (error == 'invalid-email') {
                          setState(() => message = 'Invalid email.');
                        } else if (error == 'user-not-found') {
                          setState(() => message = 'No account found with that email.');
                        }
                      } catch (exception) {
                        setState(() => message = 'Please try again.');
                      }
                    }
                  },
                ),
              ),
              gapBox,
              backButton(context),
              const SizedBox(height: 10.0),
              Text(
                message,
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
