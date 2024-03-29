import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_whs_so.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_list_whs_so_provider.dart';
import 'package:msi_app/screens/pick_item_receive_so/pick_item_receive_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_text_line_list.dart';
import 'package:provider/provider.dart';

class ItemPickListWhsSo extends StatelessWidget {
  final PickListWhsSo item;

  const ItemPickListWhsSo(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final pickListWhsProvider =
        Provider.of<PickListWhsSoProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        pickListWhsProvider.selectPickList(item);
        Navigator.of(context).pushNamed(PickItemReceiveSoScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('SO Number', item.pickNumber),
            BaseTextLine('SO Date', convertDate(item.pickDate)),
            BaseTextLine('Cust Code', item.cardCode),
            BaseTextLineList('Cust Name', item.cardName,255),
            BaseTextLine('Picker', authProvider.username),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}
