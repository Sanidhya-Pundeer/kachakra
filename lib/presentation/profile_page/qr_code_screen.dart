import 'package:flutter/material.dart';

class CodeScreen extends StatefulWidget {
  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('First Middle LastName'),
            Image.asset(
              'assets/images/qr_code.png',
              height: 250,
              width: 250,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    ));
  }
}
