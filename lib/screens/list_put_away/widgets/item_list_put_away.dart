import 'package:flutter/material.dart';
import 'package:msi_app/models/list_put_away.dart';
import 'package:msi_app/providers/list_put_away_provider.dart';
import 'package:msi_app/screens/list_put_away_detail/list_put_away_detail_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ItemListPutAway extends StatelessWidget {
  final ListPutAway item;

  const ItemListPutAway(this.item);

  Widget get status {
    switch (item.status) {
      case 0:
        return Icon(Icons.sms_failed_outlined, color: Colors.red, size: 48);
        break;
      case 1:
        return Icon(Icons.check, color: Colors.green, size: 48);
        break;
      case 2:
        return Icon(Icons.block, color: Colors.blue, size: 48);
        break;
      default:
        return Icon(Icons.help_outline, color: Colors.grey, size: 48);
    }
  }

Widget get textStatus {
    switch (item.status) {
      case 2:
        return BaseTitleColor('Canceled');
        break;
      default:
        return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    final listProvider =
        Provider.of<ListPutAwayProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        if (item.status == 0) {
          listProvider.selectPo(item);
          Navigator.of(context)
              .pushNamed(ListPutAwayDetailScreen.routeName, arguments: item);
        }
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
                  BaseTextLine('Put Away No', item.grpono),
                  // BaseTextLine('Doc No', item.poNo),
                  BaseTextLine('Doc Date', convertDate(item.docDate)),
                  BaseTitle(item.logMessage),
                  textStatus

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
