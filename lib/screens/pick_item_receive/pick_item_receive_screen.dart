import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/providers/pick_item_receive_provider.dart';
import 'package:msi_app/screens/pick_item_receive/widgets/item_pick_receive.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class PickItemReceiveScreen extends StatefulWidget {
  static const routeName = '/pick_item_receive';

  @override
  _PickItemReceiveScreenState createState() => _PickItemReceiveScreenState();
}

class _PickItemReceiveScreenState extends State<PickItemReceiveScreen> {
  final _remarks = TextEditingController();

  String convertDate(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    PickListWhs item = ModalRoute.of(context).settings.arguments;
    final pLItemReceiveProvider = Provider.of<PickItemReceiveProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick List'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Pick Number', item.pickNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildRow('Pick Date', convertDate(item.pickDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildRemarksFormField(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildTitle('Pick & Pack List'),
            Divider(),
            Expanded(
              child: FutureBuilder(
                future:
                    pLItemReceiveProvider.getPlItemReceiveByPo(item.pickNumber),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Text('An error occured'),
                        ],
                      ),
                    );
                  }

                  List<PickItemReceive> list = snapshot.data;
                  return (list.length == 0)
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.insert_drive_file,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text('No Data Available'),
                          ],
                        ))
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            return ItemPickReceive(list[index]);
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
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

  Widget buildRemarksFormField() {
    return TextFormField(
      maxLines: 2,
      controller: _remarks,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kLarge),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Remarks',
        hintText: 'Input Remarks',
      ),
    );
  }
}
