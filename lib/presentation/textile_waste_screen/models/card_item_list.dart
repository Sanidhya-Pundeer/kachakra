import 'package:courier_delivery/core/utils/color_constant.dart';
import 'package:flutter/material.dart';

import '../../../data/requestData.dart';
import '../../../theme/app_style.dart';

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
                        style: TextStyle(fontSize: 16), // Example style, customize as needed
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue, // Set the arrow color
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      if (selectedItem != null)
                        CardItemList(selectedItem: selectedItem!),
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

class CardItemList extends StatefulWidget {
  final String? selectedItem;

  CardItemList({required this.selectedItem});

  @override
  _CardItemListState createState() => _CardItemListState();
}

class _CardItemListState extends State<CardItemList> {
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

    return Column(
      children: cardItems.asMap().entries.map((entry) {
        final int index = entry.key;
        final CardItem cardItem = entry.value;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });

            // Handle the tap event for each card item
            // You can customize this part based on your requirements
            print('Card Item Selected: ${cardItem.name}');
            RequestData.weight = "${cardItem.name} - ${cardItem.capacity}";
            RequestData.price = "${cardItem.price}";
          },
          child: Card(
            elevation: selectedIndex == index ? 8 : 6, // Adjust elevation for highlighted item
            child: ListTile(
              tileColor: selectedIndex == index ? ColorConstant.primaryAqua.withOpacity(0.2) : ColorConstant.gray50, // Background color for highlighted item
              leading: cardItem.image,
              title: Text(cardItem.name, style: AppStyle.txtSubheadline),
              subtitle: Text('${cardItem.capacity}, Price: ${cardItem.price}', style: AppStyle.txtAvenirRegular16),
            ),
          ),
        );
      }).toList(),
    );
  }

  List<CardItem> getCardItems(String selectedItem) {
    switch (selectedItem) {
      case 'Construction Waste':
        return [
          CardItem(image: Image.asset('assets/images/truck-small.png', width: 50,), name: 'Mini-Truck', capacity: 'Capacity: 1 Ton', price: '\₹ 500'),
          CardItem(image: Image.asset('assets/images/truck-big.png', width: 70), name: 'Truck', capacity: 'Capacity: 5 Ton', price: '\₹1000'),
        ];
      case 'Bulky Waste':
        return [
          CardItem(image: Image.asset('assets/images/truck-small.png', width: 50), name: 'Mini-Truck', capacity: 'Capacity: 1 Ton', price: '\₹600'),
          CardItem(image: Image.asset('assets/images/truck-big.png', width: 70), name: 'Truck', capacity: 'Capacity: 5 Ton', price: '\₹1200'),
        ];
      case 'Chemical Waste':
        return [
          CardItem(image: Image.asset('assets/images/truck-small.png', width: 50), name: 'Single-Tanker', capacity: 'Capacity: 500 l', price: '\₹1000'),
          CardItem(image: Image.asset('assets/images/truck-big.png', width: 70), name: 'Double-Tanker', capacity: 'Capacity: 1000 l', price: '\₹2000'),
        ];
      case 'Sewage Wastewater':
          return [
            CardItem(image: Image.asset('assets/images/tanker-small.png', width: 50), name: 'Single-Tanker', capacity: 'Capacity: 500 l', price: '\₹1000'),
            CardItem(image: Image.asset('assets/images/tanker-big.png', width: 70), name: 'Double-Tanker', capacity: 'Capacity: 1000 l', price: '\₹2000'),
          ];
      default:
        return [];
    }
  }
}

class CardItem {
  final Image image;
  final String name;
  final String capacity;
  final String price;

  CardItem({required this.image, required this.name, required this.capacity, required this.price});
}

void main() {
  runApp(MyApp());
}
