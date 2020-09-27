import 'package:flutter/material.dart';
import 'package:msi_app/screens/login/login_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  void startTimer(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    startTimer(context);
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
