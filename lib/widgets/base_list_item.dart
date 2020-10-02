import 'package:flutter/material.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class BaseListItem extends StatelessWidget {
  final String title;
  final Future<List<dynamic>> webService;
  final Function onClick;

  const BaseListItem({
    this.title,
    this.webService,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(title),
        buildListItem(webService),
      ],
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

  Widget buildListItem(Future<List<dynamic>> webservice) {
    return Expanded(
      child: FutureBuilder(
        future: webService,
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

          List<dynamic> list = snapshot.data;
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
                    return buildItemDetail(list[index]);
                  },
                );
        },
      ),
    );
  }

  Widget buildItemDetail(item) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSmall)),
          border: Border.all(
            width: kTiny,
            color: kPrimaryColor,
            style: BorderStyle.solid,
          ),
        ),
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // item.values.toList(),
            buildRow('PO Number', item.poNumber),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String key, String value) {
    return Row(
      children: [
        Text(
          key,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(value, softWrap: true)
      ],
    );
  }
}
