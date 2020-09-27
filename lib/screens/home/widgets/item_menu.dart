import 'package:flutter/material.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class ItemMenu extends StatelessWidget {
  final IconData iconData;
  final String label;
  final String routeName;

  const ItemMenu({
    @required this.iconData,
    @required this.label,
    @required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(routeName),
      },
      child: Container(
        child: Column(
          children: [
            Icon(
              iconData,
              size: 50,
              color: Colors.black87,
            ),
            SizedBox(height: getProportionateScreenHeight(kSmall)),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
