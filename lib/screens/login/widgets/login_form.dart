import 'package:flutter/material.dart';
import 'package:msi_app/screens/home/home_screen.dart';
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

  List<Map<String, dynamic>> listWarehouse = [
    {
      "whsCode": "T.WMSICA",
      "whsName": "TRANSIT MSI CORPORATE ACCOUNT",
    },
    {
      "whsCode": "T.WMSICB",
      "whsName": "Transit The Harvest Cibubur",
    },
    {
      "whsCode": "T.WMSICC",
      "whsName": "Transit The Harvest Radio Dalam Call Center"
    },
    {
      "whsCode": "T.WMSICD",
      "whsName": "Transit The Harvest Pantai Indah Kapuk"
    },
    {
      "whsCode": "T.WMSICG",
      "whsName": "Transit The Harvest Sari Asih Ciledug",
    },
  ];
  String _selectedWarehouse;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(kLarge),
        child: Column(
          children: [
            buildUsernameFormField(),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            buildDropdownWarehouse(),
            SizedBox(
              height: getProportionateScreenHeight(kLarge * 2),
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField buildDropdownWarehouse() {
    return DropdownButtonFormField(
      isExpanded: true,
      items: listWarehouse
          .map((warehouse) => DropdownMenuItem(
                child: Text(
                  warehouse['whsName'],
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      onChanged: (value) {
        _selectedWarehouse = value;
      },
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        hintText: 'Username',
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        hintText: 'Password',
      ),
    );
  }
}
