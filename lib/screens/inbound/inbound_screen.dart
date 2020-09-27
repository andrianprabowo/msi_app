import 'package:flutter/material.dart';

class InboundScreen extends StatelessWidget {
  static const routeName = '/inbound';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbound Transaction'),
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
