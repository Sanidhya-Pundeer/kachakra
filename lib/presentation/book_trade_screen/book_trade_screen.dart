import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/presentation/book_trade_screen/sell_fragment.dart';

import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';

import 'buy_fragment.dart';



class BookTradeScreen extends StatefulWidget {
  const BookTradeScreen({Key? key}) : super(key: key);

  @override
  State<BookTradeScreen> createState() => _BookTradeScreenState();
}
class _BookTradeScreenState extends State<BookTradeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColorfulSafeArea(
        color: ColorConstant.whiteA700,
        child: Scaffold(
          backgroundColor: ColorConstant.whiteA700,
          appBar: AppBar(
            backgroundColor: ColorConstant.whiteA700,
            elevation: 0,
            title: Text("Books Marketplace"),
            bottom: TabBar(
              indicatorColor: ColorConstant.highlighter,
              labelColor: ColorConstant.highlighter,
              controller: _tabController,
              tabs: [
                Tab(text: 'Buy'),
                Tab(text: 'Sell'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              BuyFragment(),
              SellFragment(),
            ],
          ),
        ),
      ),
    );
  }
}
