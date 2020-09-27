import 'package:flutter/material.dart';
import 'package:msi_app/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kMedium),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: getProportionateScreenHeight(150),
                  ),
                ),
              ),
              Text('WMS Mobile App'),
              Text('Version 1.0'),
            ],
          ),
        ),
      ),
    );
  }
}
