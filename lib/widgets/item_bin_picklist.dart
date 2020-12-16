import 'package:flutter/material.dart';
import 'package:msi_app/models/bin.rfv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/binnya_pick_list_provider.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

class ItemBinPicklist extends StatelessWidget {
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
            'Staging Bin Location :',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          authProvider.binId == null
              ? Text('No selected Bin')
              : Text(
                  '${authProvider.binId} ',
                ),
        ],
      ),
    );
  }

  Widget buildChangeBin(BuildContext context) {
    final binProvider = Provider.of<BinnyaPicListProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final poProvider = Provider.of<PickListWhsProvider>(context, listen: false);
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        await binProvider.getAllBinRtv();
        SelectDialog.showModal<BinRtv>(
          context,
          label: "Select Bin Location",
          showSearchBox: true,
          items: binProvider.itemsBins,
          itemBuilder: (context, item, _) {
            return ListTile(
              title: Text(item.binCode),
              subtitle: Text('ID: ${item.binCode}'),
            );
          },
          searchBoxDecoration: InputDecoration(hintText: 'Search by name'),
          onChange: (BinRtv binRtv) {
            authProvider.selectBin(binRtv);
            poProvider.setStagingBin(binRtv.toString());

          },
        );
      },
    );
  }
}
