import 'package:flutter/material.dart';
import 'package:msi_app/models/bin.rfv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/bin_rtv_provider.dart';
import 'package:msi_app/providers/purchase_order_rfo_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

class ItemBinRfo extends StatelessWidget {
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
    final binProvidero = Provider.of<BinRtvProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final poProvider =
        Provider.of<PurchaseOrderRfoProvider>(context, listen: false);
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        await binProvidero.getAllBinRtvo();
        SelectDialog.showModal<BinRtv>(
          context,
          label: "Select Staging Bin Location",
          showSearchBox: true,
          items: binProvidero.itemsBins,
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
