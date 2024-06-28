import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/marketplace_screen/marketplace_buy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hindgreco MarketPlace"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BidScreen(),
                              ))
                        },
                    child: Text("Buy")),
                ElevatedButton(
                    onPressed: () => {
                          Get.toNamed(AppRoutes.textileWasteScreen),
                        },
                    child: Text("Sell")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
