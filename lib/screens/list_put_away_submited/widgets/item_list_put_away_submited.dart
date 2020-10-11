import 'package:flutter/material.dart';
import 'package:msi_app/models/list_put_away_submited.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemListPutAwaySubmited extends StatelessWidget {
  final ListPutAwaySubmited item;

  const ItemListPutAwaySubmited(this.item);

  Widget get status {
    switch (item.status) {
      case "O":
        return Icon(Icons.close, color: Colors.red, size: 48);
        break;
      case "P":
        return Icon(Icons.check, color: Colors.green, size: 48);
        break;
      default:
        return Icon(Icons.help_outline, color: Colors.grey, size: 48);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.of(context).pushNamed(StagingItemScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(kSmall)),
            status,
            SizedBox(width: getProportionateScreenWidth(kMedium)),
            Expanded(
              child: Column(
                children: [
                  BaseTextLine('Put Away No', item.putAwayNumber),
                  BaseTextLine('From Stg Bin', item.fromStgBin),
                  BaseTextLine('Doc Date', convertDate(item.docDate)),
                  BaseTextLine('Binner', item.binner),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
