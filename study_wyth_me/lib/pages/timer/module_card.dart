import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ModuleCard extends StatelessWidget {
  final String module;
  final String uid;
  const ModuleCard({
    Key? key,
    required this.module,
    required this.uid
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    module,
                    style: chewyTextStyle.copyWith(fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 40,
                decoration: largeRadiusRoundedBox,
                child: TextButton(
                  key: const Key('RemoveModuleButton'),
                  child: const AutoSizeText('Remove', maxLines: 1),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    await DatabaseService(uid: uid).removeModule(module);
                  },
                )
              ),
            ],
          ),
        ),
        horizontalDivider
      ],
    );
  }
}