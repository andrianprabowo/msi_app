import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/screens/pick_item_receive/pick_item_receive_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';

class ItemPickListWhs extends StatelessWidget {
  final PickListWhs item;

  const ItemPickListWhs(this.item);

  String get dateString {
    return DateFormat.yMMMMd().format(item.pickDate);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PickItemReceiveScreen.routeName,
            arguments: item.pickNumber);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Pick Number', item.pickNumber),
            buildRow('Pick Date', dateString),
            FutureBuilder(
              future: Prefs.getString(Prefs.username),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return buildRow('Picker', snapshot.data);
              },
            ),
            buildRow('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(value)
      ],
    );
  }
}
