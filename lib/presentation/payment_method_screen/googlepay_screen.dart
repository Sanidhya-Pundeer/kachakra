import 'package:courier_delivery/presentation/payment_method_screen/payment_configurations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GooglePayScreen extends StatefulWidget {
  const GooglePayScreen({super.key});

  @override
  State<GooglePayScreen> createState() => _GooglePayScreenState();
}

class _GooglePayScreenState extends State<GooglePayScreen> {
  final paymentItems = <PaymentItem>[];
  late String payment;

  Future<String> retrievePaymentAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String payment = prefs.getString('payment') ?? '';
    print("Payment Amount: ${payment}");
    return payment;
  }

  @override
  void initState() {
    paymentItems.add(PaymentItem(
        amount: '10', label: "Bin", status: PaymentItemStatus.final_price));
    super.initState();
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
                  "Welcome to GooglePay Payment Gateway",
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
              GooglePayButton(
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                paymentItems: paymentItems,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (result) =>
                    debugPrint('Payment Result $result'),
                // loadingIndicator: const Center(
                //   child: CircularProgressIndicator(),
                // ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
