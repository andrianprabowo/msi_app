import 'package:flutter/material.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';

class AddItemHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 60,
            color: Colors.lightGreen,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          BaseTitle('INPUT ITEM FIRST'),
        ],
      ),
    );
  }
}
