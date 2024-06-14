import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/requestData.dart';
import '../../../data/userData.dart';
import 'dart:convert' hide Codec;

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
  TextEditingController searchController = TextEditingController();
  bool showMarkers = true;
  Set<Marker> markers = {}; // Use Set to hold markers
  Color customTransparentColor =
  Color.fromRGBO(255, 255, 255, 0.4627450980392157);
  Position _currentPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    accuracy: 0.0,
    altitude: 0.0, // Providing default value for altitude
    heading: 0.0, // Providing default value for heading
    speed: 0.0, // Providing default value for speed
    speedAccuracy: 0.0, // Providing default value for speedAccuracy
    timestamp: DateTime.now(), // Providing default value for timestamp
  );
  late BitmapDescriptor customMarkerIcon;
  late GoogleMapController _mapController; // Define _mapController

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> polylines = {};

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

    return Column(children: [
      if (widget.selectedItem == 'Sell Old')
        Container(
            alignment: Alignment.center,
            margin: getMargin(bottom: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Today's Exchange Price",
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "(Last Updated: 28/01/24)",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  IntrinsicWidth(
                    child: Container(
                      padding: getPadding(all: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                        borderRadius:
                            BorderRadius.circular(getHorizontalSize(8)),
                        color: ColorConstant.whiteA700,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "₹ 12 / kg ",
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 4),
                          Image.asset('assets/images/redarrow.png',
                              width: 11, height: 13),
                        ],
                      ),
                    ),
                  ),
                ])),
      if (widget.selectedItem == 'Upcycle')
        Container(
            alignment: Alignment.center,
            margin: getMargin(bottom: 10),
            child: Text(
              'Creative & Sustainable way \nto give new life to old or discarded fabrics',
              style: AppStyle.txtSubheadline,
              textAlign: TextAlign.center,
            )),
      if (widget.selectedItem == 'Upcycle')
        Container(
            alignment: Alignment.center,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/textilebgtwo.jpg'), // Replace with your image asset
                fit: BoxFit.cover, // Adjust this according to your needs
              ),
            ),
            margin: getMargin(bottom: 0),
            child: Text(
              '',
              style: AppStyle.txtSubheadline,
              textAlign: TextAlign.center,
            )),
      if (widget.selectedItem == 'Tailors')
        Container(
            alignment: Alignment.center,
            margin: getMargin(bottom: 10),
            child: Text(
              'Find Tailors near you: \n Alter your old clothes with new designs \nlike old pair of jeans into shorts.',
              style: AppStyle.txtSubheadline,
              textAlign: TextAlign.center,
            )),
      if (widget.selectedItem == 'Tailors')
        Container(
            alignment: Alignment.center,
            height: 270,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            margin: getMargin(bottom: 0),
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    UserData.currentPosition.latitude,
                    UserData.currentPosition
                        .longitude), // Initial position set to your desired location
                zoom: 16.0,
              ),
              polylines: polylines,
              trafficEnabled: false,
              markers: markers,
              mapType: MapType.normal, // Set map type to none
              // Disable points of interest
              compassEnabled: true,
              zoomControlsEnabled: false,
              indoorViewEnabled: false,
              buildingsEnabled: true,
              mapToolbarEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                // Load custom map style
                controller.setMapStyle(jsonEncode([
                  {
                    "stylers": [
                      {"hue": "#e0d8ff"},
                      {"saturation": 10}, // Reduce saturation to 100%
                      {
                        "lightness": 30
                      } // Adjust lightness for desired greyish tone
                    ]
                  },
                  {
                    "featureType": "poi.business",
                    "stylers": [
                      {"visibility": "off"} // Hide all businesses
                    ]
                  },
                  {
                    "featureType": "poi.business",
                    "elementType": "geometry",
                    "stylers": [
                      {
                        "visibility": "on"
                      }, // Show geometry of important businesses

                      {"hue": "#e0d8ff"},
                      {"saturation": 10}, // Reduce saturation to 100%
                      {"lightness": 50} // Color for important businesses
                    ]
                  },
                  {
                    "featureType": "poi.business",
                    "elementType": "labels.icon",
                    "stylers": [
                      {"visibility": "off"} // Hide icons of all businesses
                    ]
                  }
                ]));
              },
            ),
        ),
      Column(
        children: cardItems.asMap().entries.map((entry) {
          final int index = entry.key;
          final CardItem cardItem = entry.value;

          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      cardItem.name,
                      style: AppStyle.txtSubheadline,
                      textAlign: TextAlign.center,
                    )),
                Card(
                  elevation: selectedIndex == index
                      ? 4
                      : 0, // Adjust elevation for highlighted item
                  child: ListTile(
                    tileColor: selectedIndex == index
                        ? ColorConstant.highlighter.withOpacity(0.2)
                        : ColorConstant.whiteA700,
                    subtitle: Row(
                      children: [
                        if (cardItem.image != null)
                          Expanded(
                              child: Image(
                                  image: cardItem.image!.image,
                                  width: 120,
                                  height: 100)),
                        SizedBox(width: 10),
                        Image.asset('assets/images/arrows.png', width: 50),
                        SizedBox(width: 10),
                        // Adjust the spacing between images
                        if (cardItem.imagetwo != null)
                          Expanded(
                              child: Image(
                                  image: cardItem.imagetwo!.image,
                                  width: 120,
                                  height: 100)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ]));
        }).toList(),
      ),
    ]);
  }

  List<CardItem> getCardItems(String selectedItem) {
    switch (selectedItem) {
      case 'Sell Old':
        return [
          CardItem(
              image:
                  Image.asset('assets/images/sell_textile_one.png', width: 80),
              name: 'Cash-In',
              subhead: '',
              imagetwo:
                  Image.asset('assets/images/textilesellcash.png', width: 80)),
          CardItem(
              image:
                  Image.asset('assets/images/sell_textile_one.png', width: 80),
              name: 'Trade',
              subhead: '',
              imagetwo:
                  Image.asset('assets/images/sell_textile_two.png', width: 80)),
        ];
      case 'Upcycle':
        return [];

      default:
        return [];
    }
  }
}

class CardItem {
  final Image? image;
  final String name;
  final String subhead;
  final Image? imagetwo;

  CardItem(
      {this.image, required this.name, required this.subhead, this.imagetwo});
}

void main() {
  runApp(MyApp());
}
