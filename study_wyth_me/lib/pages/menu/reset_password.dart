import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final Authentication _authenticate = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // value of the form field
  String _email = '';

  // message to indicate if password reset email was sent
  String _message = '';

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
                        style: chewyTextStyle.copyWith(fontSize: 18.0),
                        validator: (value) => value!.trim().isEmpty ? 'Enter your email' : null,
                        onChanged: (value) {
                          setState(() => _email = value.trim());
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
                  child: const AutoSizeText(
                    'Send Password Reset Email',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String status = await _authenticate.customResetPassword(_email);
                      setState(() => _message = status);
                    }
                  },
                ),
              ),
              gapBox,
              backButton(context),
              gapBoxH10,
              AutoSizeText(
                _message,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
