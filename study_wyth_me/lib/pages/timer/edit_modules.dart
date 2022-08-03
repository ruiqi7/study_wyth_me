import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/timer/module_list.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/services/database.dart';

class EditModules extends StatefulWidget {

  final String uid;
  const EditModules({ Key? key, required this.uid }) : super(key: key);

  @override
  State<EditModules> createState() => _EditModulesState();
}

class _EditModulesState extends State<EditModules> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _module = '';

  // to indicate if the module has been added
  String _message = '';

  final _fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: Container(
          color: whiteOpacity20,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              color: Colors.transparent,
              height: 75.0,
              child: Row(
                children: <Widget> [
                  closeIcon(context),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      child: AutoSizeText(
                        'Edit list of modules',
                        style: chewyTextStyle.copyWith(fontSize: 25.0),
                        maxLines: 1,
                      ),
                    )
                  )
                ],
              )
            )
          ),
        )
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              gapBox,
              gapBox,
              Form(
                key: _formKey,
                child: TextFormField(
                  key: const Key('ModuleFormField'),
                  decoration: formFieldDeco.copyWith(hintText: 'Module', hintStyle: const TextStyle(color: whiteOpacity70)),
                  style: chewyTextStyle.copyWith(fontSize: 18.0),
                  validator: (value) => value!.trim().isEmpty ? 'Enter a module' : null,
                  controller: _fieldText,
                  onChanged: (value) {
                    setState(() => _module = value.trim());
                  },
                ),
              ),
              gapBox,
              Container(
                width: 100,
                height: 40,
                decoration: largeRadiusRoundedBox,
                child: TextButton(
                  key: const Key('AddModuleButton'),
                  child: const AutoSizeText('Add', maxLines: 1),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String result = await DatabaseService(uid: widget.uid).updateNewModule(_module);
                      setState(() => _message = result);
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted) {
                          setState(() => _message = '');
                        }
                      });
                      _fieldText.clear();
                    }
                  },
                ),
              ),
              gapBoxH10,
              AutoSizeText(
                _message,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
                maxLines: 1,
              ),
              gapBox,
              horizontalDivider,
              const Expanded(child: ModuleList()),
            ],
          ),
        ),
      ),
    );
  }
}
