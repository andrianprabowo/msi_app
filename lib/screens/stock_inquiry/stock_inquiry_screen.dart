import 'package:flutter/material.dart';

class StockInquiryScreen extends StatelessWidget {
  static const routeName = '/stock_inquiry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Inquiry'),
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
