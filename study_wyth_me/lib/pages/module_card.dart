import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ModuleCard extends StatelessWidget {
  final String module;
  const ModuleCard({
    Key? key,
    required this.module
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
              Text(
                module,
                style: chewyTextStyle.copyWith(fontSize: 20)
              ),
              Container(
                width: 100,
                height: 40,
                decoration: largeRadiusRoundedBox,
                child: TextButton(
                  child: const Text('Remove'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5.0),
                    primary: Colors.white,
                    textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                  ), onPressed: () {  },
                )
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white)
      ],
    );
  }
}