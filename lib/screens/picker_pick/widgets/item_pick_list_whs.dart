import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:msi_app/screens/pick_item_receive/pick_item_receive_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_text_line_list.dart';
import 'package:provider/provider.dart';

class ItemPickListWhs extends StatelessWidget {
  final PickListWhs item;

  const ItemPickListWhs(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final pickListWhsProvider =
        Provider.of<PickListWhsProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        pickListWhsProvider.selectPickList(item);
        Navigator.of(context).pushNamed(PickItemReceiveScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Pick Number', item.pickNumber),
            BaseTextLine('Pick Date', convertDate(item.pickDate)),
            BaseTextLine('Whs Code', item.cardCode),
            BaseTextLineList('Whs Name', item.cardName, 255),
            BaseTextLine('Picker', authProvider.username),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}
