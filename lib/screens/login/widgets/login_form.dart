import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:msi_app/models/warehouse.dart';
import 'package:msi_app/screens/login/widgets/selected_warehouse.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:search_widget/search_widget.dart';

class LoginForm extends StatefulWidget {
  final List<Warehouse> listWarehouse;

  const LoginForm(this.listWarehouse);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  Warehouse _selectedWarehouse;

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
            buildSearchableDropdown(),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
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
        onPressed: () {
          _formKey.currentState.save();

          if (_selectedWarehouse == null ||
              _username.isEmpty ||
              _password.isEmpty) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Please input all required fields')),
            );
            return;
          }

          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          authProvider.login(
            username: _username,
            warehouse: _selectedWarehouse,
            context: context,
          );
        },
      ),
    );
  }

  Widget buildDropdownWarehouse(List<Warehouse> list) {
    return DropdownButtonFormField(
      isExpanded: true,
      items: list
          .map((warehouse) => DropdownMenuItem(
                child: Text(
                  warehouse.whsName,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      onChanged: (value) {
        _selectedWarehouse = value;
      },
    );
  }

  Widget buildSearchableDropdown() {
    return SearchWidget<Warehouse>(
      dataList: widget.listWarehouse,
      hideSearchBoxWhenItemSelected: true,
      listContainerHeight: MediaQuery.of(context).size.height / 4,
      queryBuilder: (query, list) {
        return list
            .where((item) =>
                item.whsName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      popupListItemBuilder: (item) {
        return PopupListItemWidget(item);
      },
      selectedItemBuilder: (selectedItem, deleteSelectedItem) {
        return SelectedWarehouse(selectedItem, deleteSelectedItem);
      },
      // widget customization
      noItemsFoundWidget: NoItemsFound(),
      textFieldBuilder: (controller, focusNode) {
        return MyTextField(controller, focusNode);
      },
      onItemSelected: (item) {
        setState(() {
          if (item == null) {
            _selectedWarehouse = null;
            return;
          }

          _selectedWarehouse = item;
          print(_selectedWarehouse);
        });
        return _selectedWarehouse;
      },
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        hintText: 'Username',
      ),
      onSaved: (value) {
        return _username = value;
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
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
