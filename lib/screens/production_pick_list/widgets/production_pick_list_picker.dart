import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_pick_list_provider.dart';
import 'package:msi_app/screens/production_pick_list_item/production_pick_list_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionPickListPicker extends StatelessWidget {
  final ProductionPickListModel item;

  const ProductionPickListPicker(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final pickListWhsProvider =
        Provider.of<ProductionPickListProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        pickListWhsProvider.selectPickList(item);
        Navigator.of(context).pushNamed(ProductionPickListItem.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Pick Number', item.pickNumber),
            BaseTextLine('Pick Date', convertDate(item.pickDate)),
            BaseTextLine('Req Whs Code', item.cardCode),
            BaseTextLine('Req Whs Name', item.cardName),
            BaseTextLine('Picker', authProvider.username),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}