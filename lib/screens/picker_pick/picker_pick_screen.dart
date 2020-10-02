import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_whs.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:msi_app/screens/picker_pick/widgets/item_pick_list_whs.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class PickerPickScreen extends StatelessWidget {
  static const routeName = '/picker_pick';

  @override
  Widget build(BuildContext context) {
    final pLWhsProvider = Provider.of<PickListWhsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle('Pick & Pack List'),
            Divider(),
            Expanded(
              child: FutureBuilder(
                future: pLWhsProvider.getPlDetailByWhs(),
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

                  List<PickListWhs> list = snapshot.data;
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
                          ),
                        )
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            return ItemPickListWhs(list[index]);
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
}
