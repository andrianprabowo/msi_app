import 'package:flutter/material.dart';
import 'package:msi_app/models/dashboard.dart';
import 'package:msi_app/screens/inventory_dispatch/inventory_dispatch_header_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_rtv/inventory_dispatch_header_screen_rtv.dart';
import 'package:msi_app/screens/inventory_dispatch_so/inventory_dispatch_header_screen_so.dart';
import 'package:msi_app/screens/picker_pick/picker_pick_screen.dart';
import 'package:msi_app/screens/picker_pick_rtv/picker_pick_rtv_screen.dart';
import 'package:msi_app/screens/picker_pick_so/picker_pick_so_screen.dart';
import 'package:msi_app/screens/production_issue/production_issue_screen.dart';
import 'package:msi_app/screens/production_pick_list/production_pick_list_screen.dart';
import 'package:msi_app/screens/production_receipt/production_receipt_screen.dart';
import 'package:msi_app/screens/production_receipt_rm/production_receipt_rm_screen.dart';
import 'package:msi_app/screens/put_away/put_away_screen.dart';
import 'package:msi_app/screens/put_away_rfo/put_away_rfo_screen.dart';
import 'package:msi_app/screens/receipt_vendor/receipt_vendor_screen.dart';
import 'package:msi_app/screens/receipt_vendor_rfo/receipt_vendor_rfo_screen.dart';
import 'package:msi_app/screens/stock_counting_header/stock_counting_header_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';

class ItemDashboard extends StatelessWidget {
  final Dashboard item;

  const ItemDashboard(this.item);

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // final pickListWhsProvider =
    //     Provider.of<PickListWhsProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        // pickListWhsProvider.selectPickList(item);
        // Navigator.of(context).pushNamed(PickItemReceiveScreen.routeName);

        switch (item.module) {
          case 'Inbound - Good Receipt PO':
            Navigator.of(context).pushNamed(ReceiptVendorScreen.routeName);
            break;
          case 'Inbound - PutAway GRPO':
            Navigator.of(context).pushNamed(PutAwayScreen.routeName);
            break;
          case 'Inbound - Receipt Outlet':
            Navigator.of(context).pushNamed(ReceiptVendorRfoScreen.routeName);
            break;
          case 'Inbound - PutAway Receipt Outlet':
            Navigator.of(context).pushNamed(PutAwayRfoScreen.routeName);
            break;
          case 'Outbound - Transfer Outlet - Pick List':
            Navigator.of(context).pushNamed(PickerPickScreen.routeName);
            break;
          case 'Outbound - Transfer Outlet - Inv.Dispatch':
            Navigator.of(context)
                .pushNamed(InventoryDispatchHeaderScreen.routeName);
            break;
          case 'Outbound - Sales Order - Pick List':
            Navigator.of(context).pushNamed(PickerPickSoScreen.routeName);
            break;
          case 'Outbound - Sales Order - Inv.Dispatch':
            Navigator.of(context)
                .pushNamed(InventoryDispatchHeaderSoScreen.routeName);
            break;
          case 'Outbound - Return to Vendor - Pick List':
            Navigator.of(context).pushNamed(PickerPickRtvScreen.routeName);
            break;
          case 'Outbound - Return to Vendor - Inv.Dispatch':
            Navigator.of(context)
                .pushNamed(InventoryDispatchHeaderRtvScreen.routeName);
            break;
          case 'Production - Transfer To Production - Pick List':
            Navigator.of(context).pushNamed(ProductionPickList.routeName);
            break;
          case 'Production - Transfer To Production - Receipt':
            Navigator.of(context).pushNamed(ProductionReceiptRM.routeName);
            break;
          case 'Production - Issue Raw Material':
            Navigator.of(context).pushNamed(ProductionIssue.routeName);
            break;
          case 'Production - Receipt Finished Goods':
            Navigator.of(context).pushNamed(ProductionReceipt.routeName);
            break;
          case 'Stock Counting':
            Navigator.of(context)
                .pushNamed(StockCountingHeaderScreen.routeName);
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.module),
            // BaseTitle(item.whsCode),
            BaseTitleColor(
                'You have ${item.count.toString()} document waiting to Prosses'),
          ],
        ),
      ),
    );
  }
}
