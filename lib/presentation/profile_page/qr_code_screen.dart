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
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: 390,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 206, 238, 220),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                child: Column(
                  children: [
                    Text(
                      'First Middle LastName',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: Image.asset(
                        'assets/images/qr_code.png',
                        height: 250,
                        width: 250,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Scan to pay or get user details'),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 105,
                        ),
                        Text('User ID: 35286832598'),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(onPressed: () => {}, icon: Icon(Icons.copy))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(Icons.qr_code_scanner_rounded),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Open in Scanner'),
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Share QR Code'),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
