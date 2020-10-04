import 'package:flutter/material.dart';
import 'package:msi_app/utils/size_config.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Text('No Data Available'),
        ],
      ),
    );
  }
}
