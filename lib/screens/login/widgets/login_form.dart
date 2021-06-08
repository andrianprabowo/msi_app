import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  String _decString;
  int _decLen;

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(kLarge),
        child: Column(
          children: [
            buildUsernameFormField(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildButtonLogin(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtonLogin(BuildContext context) {
    
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Login'),
        onPressed: () async {
          _formKey.currentState.save();

          if (_username.isEmpty || _password.isEmpty) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: getProportionateScreenWidth(kLarge)),
                  Text('Please input Username & Password fields'),
                ],
              ),
            ));
            return;
          }

          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);

          var loginSuccess = await authProvider.login(
            username: _username,
            password: _password,
            decLen: _decLen,
            decString: _decString,
          );

          if (loginSuccess) {
        await authProvider.getMenuByUsername();

            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: getProportionateScreenWidth(kLarge)),
                  Text('Wrong username or password'),
                ],
              ),
            ));
            // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }
        },
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      // initialValue: 'SX_Senopati',
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        hintText: 'Username',
      ),
      onSaved: (newValue) {
        _username = newValue;
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      // initialValue: 'password',
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        hintText: 'Password',
      ),
      onSaved: (value) {
        return _password = value;
      },
    );
  }
}
