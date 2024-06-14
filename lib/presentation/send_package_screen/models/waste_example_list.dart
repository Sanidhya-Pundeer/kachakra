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
                      if (selectedItem != null)
                        WasteExanpleList(selectedItem: selectedItem!),
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

  WasteExanpleList({required this.selectedItem});

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
          children: currentRow.map((cardItem) {
            final int index = cardItems.indexOf(cardItem);

            return Expanded(
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
                  elevation: selectedIndex == index ? 0 : 0,
                  child: Container(
                    decoration: BoxDecoration(
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
                    height: 120,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            cardItem.name,
                            style: TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        cardItem.image,
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            cardItem.subhead,
                            style: TextStyle(
                              fontSize: 9,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  List<CardItem> getCardItems(String selectedItem) {
    switch (selectedItem) {
      case 'Construction Waste':
        return [
          CardItem(
              image: Image.asset(
                'assets/images/ceramicsone.png',
                height: 50,
              ),
              name: 'Ceramics',
              subhead: 'Tiles, Toilet Seats,\nWash Basin',
              imagetwo: Image.asset('assets/images/ceramictwo.png', height: 50)),
          CardItem(
              image: Image.asset('assets/images/debrisone.jpg', height: 50),
              name: 'Debris',
              subhead: 'Concrete, Bricks',
              imagetwo: Image.asset('assets/images/debristwo.png', height: 50)),
          CardItem(
              image: Image.asset(
                'assets/images/woodone.jpg',
                height: 50,
              ),
              name: 'Wood',
              subhead: 'Doors, Windows,\nFrames',
              imagetwo: Image.asset('assets/images/woodtwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/metal.png', height: 50),
              name: 'Metal',
              subhead: 'TMT Bars, Gate,\nGuard Rail',
              imagetwo: Image.asset('assets/images/metaltwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/glass.jpg', height: 50),
              name: 'Glass',
              subhead: 'Window Glass',
              imagetwo: Image.asset('assets/images/glasstwo.jpg', height: 50)),
        ];
      case 'Bulky Waste':
        return [
          CardItem(
              image: Image.asset('assets/images/furnituretwo.png', height: 50),
              name: 'Furniture',
              subhead: 'Beds, Sofas, Table, Cupboards',
              imagetwo:
                  Image.asset('assets/images/furnitureone.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/bulkyone.jpg', height: 50),
              name: 'Electronics',
              subhead: 'Fridge, Washing machine, Microwave, etc',
              imagetwo: Image.asset('assets/images/bulkytwo.jpg', height: 50)),
        ];
      case 'Sewage Wastewater':
        return [
          CardItem(
              image: Image.asset('assets/images/sewageone.jpg', height: 50),
              name: 'Industrial Waste',
              subhead: 'Through manholes, etc',
              imagetwo: Image.asset('assets/images/sewagetwo.jpg', height: 50)),
        ];
      default:
        return [];
    }
  }
}

class CardItem {
  final Image image;
  final String name;
  final String subhead;
  final Image imagetwo;

  CardItem(
      {required this.image,
      required this.name,
      required this.subhead,
      required this.imagetwo});
}

void main() {
  runApp(MyApp());
}
