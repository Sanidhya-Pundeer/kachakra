import 'dart:convert';
import 'dart:core';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhonePePayment extends StatefulWidget {
  const PhonePePayment({super.key});

  @override
  State<PhonePePayment> createState() => _PhonePePaymentState();
}

class _PhonePePaymentState extends State<PhonePePayment> {
  late String payment;
  String environment = "SANDBOX";
  String appId = "";
  String merchantId = "PGTESTPAYUAT86";
  bool enableLogging = true;

  String checksum = "";
  String saltKey = "96434309-7796-489d-8924-ab56988a6076";
  String saltIndex = "1";

  String callbackUrl = "google.com";
  String body = "";
  String apiEndPoint = "/pg/v1/pay";
  Object? result;

  getChecksum() {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": 1,
      "mobileNumber": "9999999999",
      "callbackUrl": callbackUrl,
      "paymentInstrument": {"type": "PAY_PAGE"},
      "deviceContext": {"deviceOS": "ANDROID"}
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));

    checksum =
        "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";

    return base64Body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    phonepeInit();
    body = getChecksum().toString();
  }

  Future<String> retrievePaymentAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    payment = prefs.getString('payment') ?? '';
    print("Payment: ${payment}");
    return payment;
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/images/logonewwhite.png',
                height: 180,
                width: 180,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Welcome to PhonePe Payment Gateway",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<String>(
                future: retrievePaymentAmount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    String payment = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text('Total payable amount: ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Icon(Icons.currency_rupee_rounded),
                            Center(
                              child: Text(
                                payment,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   int amount = int.parse(payment.toString().trim());
                    //   startPgTrancaction;
                    // });
                    startPgTrancaction();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Make Payment'),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Result ${result}")
            ],
          ),
        ),
      ),
    ));
  }

  void phonepeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void startPgTrancaction() async {
    PhonePePaymentSdk.startTransaction(body, callbackUrl, checksum, "")
        .then((response) => {
              setState(() {
                if (response != null) {
                  String status = response['status'].toString();
                  String error = response['error'].toString();
                  if (status == 'SUCCESS') {
                    // "Flow Completed - Status: Success!";
                    result = "Flow Completed - Status: Success!";
                  } else {
                    // "Flow Completed - Status: $status and Error: $error";
                    result =
                        "Flow Completed - Status: $status and Error: $error";
                    print(result);
                  }
                } else {
                  // "Flow Incomplete";
                  result = "Flow Incomplete";
                }
              })
            })
        .catchError((error) {
      // handleError(error)
      return <dynamic>{};
    });
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }
}
