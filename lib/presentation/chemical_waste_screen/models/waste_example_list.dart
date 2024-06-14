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
                      elevation: selectedIndex == index ? 8 : 0,
                      shadowColor: ColorConstant.highlighter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? ColorConstant.highlighter.withOpacity(0.3)
                              : Colors.white,
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
                        height: widget.selectedItem == 'Re-Sell: \n"Turn your waste materials and get paid."' ? 110 : 97,
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                cardItem.name,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            cardItem.image,
                            Column(children: [
                              if (widget.selectedItem == 'Re-Sell: \n"Turn your waste materials and get paid."')
                                Text(
                                  'Resale Price:',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      cardItem.subhead + "  ",
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (widget.selectedItem == 'Re-Sell: \n"Turn your waste materials and get paid."')
                                    Image.asset('assets/images/greenarrow.png',
                                        width: 8, height: 10),
                                  ])
                            ]),
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
      case 'Re-Sell: \n"Turn your waste materials and get paid."':
        return [
          CardItem(
              image: Image.asset(
                'assets/images/kerosene.png',
                height: 40,
              ),
              name: 'Kerosene',
              subhead: '₹ 20/l',
              imagetwo:
                  Image.asset('assets/images/ceramictwo.png', height: 50)),
          CardItem(
              image: Image.asset('assets/images/paint.png', height: 40),
              name: 'Paint',
              subhead: '₹ 15/l',
              imagetwo: Image.asset('assets/images/debristwo.png', height: 50)),
          CardItem(
              image: Image.asset(
                'assets/images/rubber.png',
                height: 40,
              ),
              name: 'Rubber',
              subhead: '₹ 5/kg',
              imagetwo: Image.asset('assets/images/woodtwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/termiticide.png', height: 40),
              name: 'Termiticides',
              subhead: '₹ 12/l',
              imagetwo: Image.asset('assets/images/metaltwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/lubricant.png', height: 40),
              name: 'Lubricant',
              subhead: '₹ 8/l',
              imagetwo: Image.asset('assets/images/glasstwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/cooking.png', height: 40),
              name: 'Waste Cooking oil',
              subhead: '₹ 4/l',
              imagetwo: Image.asset('assets/images/glasstwo.jpg', height: 50)),
        ];
      case 'Dump':
        return [
          CardItem(
              image: Image.asset(
                'assets/images/kerosene.png',
                height: 40,
              ),
              name: 'Kerosene\n',
              subhead: '',
              imagetwo:
                  Image.asset('assets/images/ceramictwo.png', height: 50)),
          CardItem(
              image: Image.asset('assets/images/paint.png', height: 40),
              name: 'Paint\n',
              subhead: '',
              imagetwo: Image.asset('assets/images/debristwo.png', height: 50)),
          CardItem(
              image: Image.asset(
                'assets/images/rubber.png',
                height: 40,
              ),
              name: 'Rubber',
              subhead: '',
              imagetwo: Image.asset('assets/images/woodtwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/termiticide.png', height: 40),
              name: 'Termiticides',
              subhead: '',
              imagetwo: Image.asset('assets/images/metaltwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/lubricant.png', height: 40),
              name: 'Lubricant',
              subhead: '',
              imagetwo: Image.asset('assets/images/glasstwo.jpg', height: 50)),
          CardItem(
              image: Image.asset('assets/images/cooking.png', height: 40),
              name: 'Waste Cooking oil',
              subhead: '',
              imagetwo: Image.asset('assets/images/glasstwo.jpg', height: 50)),
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
