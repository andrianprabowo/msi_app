import 'package:flutter/material.dart';
import 'package:msi_app/screens/login/widgets/login_form.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Image.asset(
                  'assets/images/logo.png',
                  height: getProportionateScreenHeight(100),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                LoginForm(),
                SizedBox(height: getProportionateScreenHeight(kLarge)),
                BaseTitle("Ver 1.05")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
