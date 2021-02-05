import 'package:flutter/material.dart';
import 'package:msi_app/models/enter_gl.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/item_gl_provider.dart';
import 'package:msi_app/providers/production_receipt_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

class ItemEnterGl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return FutureBuilder(
      future: authProvider.getData(),
      builder: (_, snapshot) {
        return Row(
          children: [
            buildTextInfo(authProvider),
            buildChangeBin(context),
          ],
        );
      },
    );
  }

  Widget buildTextInfo(AuthProvider authProvider) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GI Sequence No :',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          authProvider.binGl == null
              ? Text('Please input GI Sequence no')
              : Text(
                  '${authProvider.binGl} ',
                ),
        ],
      ),
    );
  }

  Widget buildChangeBin(BuildContext context) {
    final itemGlProvider = Provider.of<ItemGlProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final poProvider = Provider.of<ProductionReceiptProvider>(context, listen: false);
    var header = poProvider.selected;
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        await itemGlProvider.getEnterGl(header.poNumber);
        SelectDialog.showModal<EnterGl>(
          context,
          label: "Select Bin Location",
          showSearchBox: true,
          items: itemGlProvider.itemsGl,
          itemBuilder: (context, item, _) {
            return ListTile(
              title: Text(item.enterGl),
              subtitle: Text('ID: ${item.enterGl}'),
            );
          },
          searchBoxDecoration: InputDecoration(hintText: 'Search by name'),
          onChange: (EnterGl binGl) {
            authProvider.selectItemGl(binGl);
            poProvider.setGlItem(binGl.toString());
          },
        );
      },
    );
  }
}
