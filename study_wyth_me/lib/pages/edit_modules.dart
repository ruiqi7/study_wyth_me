import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';

class EditModules extends StatefulWidget {
  const EditModules({Key? key}) : super(key: key);

  @override
  State<EditModules> createState() => _EditModulesState();
}

class _EditModulesState extends State<EditModules> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String module = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            color: whiteOpacity20,
            height: 75.0,
            child: Row(
              children: <Widget> [
                backIcon(context),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                    child: Text(
                      'Edit list of modules',
                      style: chewyTextStyle.copyWith(fontSize: 25.0), 
                    ),
                  )
                )
              ],
            )
          )
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField( // email
                  decoration: formFieldDeco.copyWith(hintText: 'Enter a Module'),
                  style: chewyTextStyle.copyWith(fontSize: 18.0),
                  validator: (value) => value!.isEmpty ? 'Enter a Module' : null,
                  onChanged: (value) {
                    setState(() => module = value);
                  },
                ),
              ),
            ),
            gapBox,
            Container(
              width: 100,
              height: 40,
              decoration: largeRadiusRoundedBox,
              child: TextButton(
                child: const Text('Add'),
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
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
