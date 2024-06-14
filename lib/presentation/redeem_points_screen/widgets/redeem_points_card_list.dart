import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/core/utils/color_constant.dart';
import 'package:flutter/material.dart';

import '../../../data/requestData.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? selectedItem;
  List<String> items = ['Plastic Waste', 'Paper Waste', 'Metal Waste'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 19),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Type of waste:",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  // style: AppStyle.txtSubheadline, // Assuming you have this style defined
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        isExpanded: true,
                        value: selectedItem,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem = newValue;
                          });
                        },
                        items: items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 2,
                                    height: 20,
                                    color: Color(0xFF03BB85),
                                    margin: EdgeInsets.only(right: 8),
                                  ),
                                  Text(item),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        underline: Container(),
                        style: TextStyle(
                            fontSize: 16), // Example style, customize as needed
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue, // Set the arrow color
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // if (selectedItem != null)
                      //   WasteExanpleList(
                      //     selectedItem: selectedItem!,
                      //     redeemValue: double.tryParse(redeemValueController.text) ?? 0,
                      //   ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WasteExanpleList extends StatefulWidget {
  final String? selectedItem;
  final double redeemValue; // Add redeemValue parameter

  WasteExanpleList({required this.selectedItem, required this.redeemValue});

  @override
  _CardItemListState createState() => _CardItemListState();
}

class _CardItemListState extends State<WasteExanpleList> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedItem == null) {
      return Container();
    }

    List<CardItem> cardItems = getCardItems(widget.selectedItem!);
    RequestData.type_of_waste = widget.selectedItem!;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: (cardItems.length / 3).ceil(), // Number of rows
      itemBuilder: (context, rowIndex) {
        final int startIndex = rowIndex * 3;
        final int endIndex = (rowIndex + 1) * 3;

        // Ensure endIndex does not exceed the length of cardItems
        final List<CardItem> currentRow = cardItems.sublist(
          startIndex,
          endIndex > cardItems.length ? cardItems.length : endIndex,
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: currentRow.asMap().entries.map((entry) {
            final int index = entry.key;
            final CardItem cardItem = entry.value;

            return Expanded(
              flex: index == 1 ? 6 : 5, // Make the middle card twice as wide
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(3),
                  child: Card(
                    color: Colors.white,
                    elevation: index == 1 ? 6 : 3,
                    shadowColor: ColorConstant.highlighter,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: index == 2 ? AssetImage('assets/images/greenback.png') : AssetImage(''), // Replace 'assets/background_image.jpg' with your actual image path
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      height: index == 1 ? 90 : 70,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    cardItem.name,
                                    style: TextStyle(
                                      color: ColorConstant.highlighter,
                                      fontSize: index == 1 ? 32 : 24,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    cardItem.subhead + "  ",
                                    style: TextStyle(
                                      fontSize: index == 1 ? 18 : 12,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  List<CardItem> getCardItems(String selectedItem) {
    switch (selectedItem) {
      default:
        double totalValue = 900;
        int totalPoints = 1800;// Initial total value
        // Subtract the redeem value from the total value
        totalValue -= widget.redeemValue;
        totalPoints -= (widget.redeemValue*2).toInt();
              return  [
          CardItem(
            name: totalPoints.toString(),
            subhead: 'Points',
          ),
          CardItem(
            name: '₹ $totalValue',
            subhead: 'Total Value',
          ),
          CardItem(
            name: '5 kg',
            subhead: 'CO₂ reduced',
            image: Image.asset('assets/images/co2reduce.png', height: 30,),
          ),
        ];
    }
  }
}

class CardItem {
  final String name;
  final String subhead;
  final Image? image;

  CardItem({
    required this.name,
    required this.subhead,
    this.image,
  });
}

void main() {
  runApp(MyApp());
}
