import 'package:flutter/material.dart';
import 'package:msi_app/utils/size_config.dart';

class ErrorInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Text('An error occured'),
        ],
      ),
    );
  }
}
