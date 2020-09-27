import 'package:flutter/material.dart';

class ReceiptVendorScreen extends StatelessWidget {
  static const routeName = '/receipt_vendor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt From Vendor'),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Icon(
              Icons.warning,
              size: 100,
              color: Colors.red,
            ),
            Text(
              'Under Development',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
